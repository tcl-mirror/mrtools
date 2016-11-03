/*
# This software is copyrighted 2015 - 2016 by G. Andrew Mangogna.
# The following terms apply to all files associated with the software unless
# explicitly disclaimed in individual files.
# 
# The authors hereby grant permission to use, copy, modify, distribute,
# and license this software and its documentation for any purpose, provided
# that existing copyright notices are retained in all copies and that this
# notice is included verbatim in any distributions. No written agreement,
# license, or royalty fee is required for any of the authorized uses.
# Modifications to this software may be copyrighted by their authors and
# need not follow the licensing terms described here, provided that the
# new terms are clearly indicated on the first page of each file where
# they apply.
# 
# IN NO EVENT SHALL THE AUTHORS OR DISTRIBUTORS BE LIABLE TO ANY PARTY FOR
# DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING
# OUT OF THE USE OF THIS SOFTWARE, ITS DOCUMENTATION, OR ANY DERIVATIVES
# THEREOF, EVEN IF THE AUTHORS HAVE BEEN ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
# 
# THE AUTHORS AND DISTRIBUTORS SPECIFICALLY DISCLAIM ANY WARRANTIES,
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT.  THIS SOFTWARE
# IS PROVIDED ON AN "AS IS" BASIS, AND THE AUTHORS AND DISTRIBUTORS HAVE
# NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS,
# OR MODIFICATIONS.
# 
# GOVERNMENT USE: If you are acquiring this software on behalf of the
# U.S. government, the Government shall have only "Restricted Rights"
# in the software and related documentation as defined in the Federal
# Acquisition Regulations (FARs) in Clause 52.227.19 (c) (2).  If you
# are acquiring the software on behalf of the Department of Defense,
# the software shall be classified as "Commercial Computer Software"
# and the Government shall have only "Restricted Rights" as defined in
# Clause 252.227-7013 (c) (1) of DFARs.  Notwithstanding the foregoing,
# the authors grant the U.S. Government and others acting in its behalf
# permission to use and distribute the software in accordance with the
# terms specified in this license.
Micca version: 0.1
*/

#ifndef MICCA_RT_H_
#define MICCA_RT_H_

/*
 * Standard Includes
 */
#include <stdlib.h>
#include <stddef.h>
#include <inttypes.h>
#include <stdbool.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

#if __STDC_VERSION__ > 199001L
#   include <stdalign.h>
#   include <stdnoreturn.h>
#else
#   define alignas(x)
#   define noreturn
#endif /* __STDC_VERSION__ > 199001L */

/*
 * Preprocessor Defines
 */
#ifndef COUNTOF
#define COUNTOF(a)  (sizeof(a) / sizeof(a[0]))
#endif /* COUNTOF */
/*
 * Constants
 */
#define MRT_StateCode_IG    (-1)
#define MRT_StateCode_CH    (-2)
#ifndef MRT_INSTANCESETSIZE
#   define MRT_INSTANCESETSIZE 128
#endif /* MRT_INSTANCESETSIZE */
#ifndef MRT_TRANSACTIONSIZE
#   define MRT_TRANSACTIONSIZE 64
#endif /* MRT_TRANSACTIONSIZE */
#ifndef MRT_EVENTPOOLSIZE
#   define MRT_EVENTPOOLSIZE 32
#endif /* MRT_EVENTPOOLSIZE */
#ifndef MRT_ECB_PARAM_SIZE
#   define MRT_ECB_PARAM_SIZE  32
#endif /* MRT_ECB_PARAM_SIZE */
    // No such class.
#define MICCA_PORTAL_NO_CLASS       (-1)
    // No such instance.
#define MICCA_PORTAL_NO_INST        (-2)
    // No such attribute.
#define MICCA_PORTAL_NO_ATTR        (-3)
    // Instance slot is not in use.
#define MICCA_PORTAL_UNALLOC        (-4)
    // Class does not have a state model.
#define MICCA_PORTAL_NO_STATE_MODEL (-5)
    // No such event for the class.
#define MICCA_PORTAL_NO_EVENT       (-6)
    // No such state for the class.
#define MICCA_PORTAL_NO_STATE       (-7)
    // Class does not support dynamic instances.
#define MICCA_PORTAL_NO_DYNAMIC     (-8)
    // Operation not allowed on a dependent attribute.
#define MICCA_PORTAL_DEPENDENT_ATTR (-9)
    // Value was truncated due to lack of space.
#define MICCA_PORTAL_TRUNCATED      (-10)
#ifndef MRT_SYNCQUEUESIZE
#   define MRT_SYNCQUEUESIZE 10
#endif /* MRT_SYNCQUEUESIZE */

/*
 * Data Types
 */
typedef int16_t MRT_AllocStatus ;
typedef int8_t MRT_StateCode ;
typedef uint8_t MRT_RefCount ;
typedef enum {
    mrtIndependentAttr,
    mrtDependentAttr
} MRT_AttrType ;
typedef enum {
    mrtTransitionEvent,
    mrtPolymorphicEvent,
    mrtCreationEvent
} MRT_EventType ;
typedef uint8_t MRT_EventCode ;
typedef uint32_t MRT_DelayTime ;
typedef char MRT_EventParams[MRT_ECB_PARAM_SIZE] ;
typedef uint8_t MRT_DispatchCount ;
typedef void MRT_ActivityFunction(void *const, void const *const) ;
typedef MRT_ActivityFunction *MRT_PtrActivityFunction ;
typedef size_t MRT_AttrOffset ;
typedef unsigned short MRT_ClassId ;
typedef unsigned short MRT_InstId ;
typedef unsigned short MRT_AttrId ;
typedef size_t MRT_AttrSize ;
typedef unsigned short MRT_AssignerId ;
typedef uint8_t MRT_SubclassCode ;
typedef enum {
    mrtCantHappen = 1,
    mrtEventInFlight,
    mrtNoECB,
    mrtNoInstSlot,
    mrtUnallocSlot,
    mrtSyncOverflow,
    mrtRefIntegrity,
    mrtTransOverflow,
    mrtStaticRelationship,
    mrtRelationshipLinkage,

#       ifdef _POSIX_C_SOURCE
    mrtTimerOpFailed,
    mrtSignalOpFailed,
    mrtSelectWaitFailed,
#       endif /* _POSIX_C_SOURCE */
} MRT_ErrorCode ;
typedef struct mrtinstance {
    struct mrtclass const *classDesc ;
    MRT_AllocStatus alloc ;
    MRT_StateCode currentState ;
    MRT_RefCount refCount ;

#       ifndef MRT_NO_NAMES
    char const *name ;
#       endif /* MRT_NO_NAMES */
} MRT_Instance ;
typedef void MRT_AttrFormula(void const *const self, void *const pvalue, MRT_AttrSize vsize) ;
typedef struct mrtattribute {
    MRT_AttrSize size ;
    MRT_AttrType type ;
    union {
        MRT_AttrOffset offset ;
        MRT_AttrFormula *formula ;
    } access ;

#       ifndef MRT_NO_NAMES
    char const *name ;
#       endif /* MRT_NO_NAMES */
} MRT_Attribute ;
typedef struct mrtclass {
    struct mrtinstallocblock *iab ;
    unsigned eventCount ;
    struct mrteventdispatchblock const *edb ;
    struct mrtpolydispatchblock const *pdb ;
    unsigned relCount ;
    struct mrtrelationship const * const *classRels ;
    unsigned attrCount ;
    MRT_Attribute const *classAttrs ;
    unsigned instCount ;
    struct mrtsuperclassrole const *containment ;

#       ifndef MRT_NO_NAMES
    char const *name ;
    char const *const *eventNames ;
#       endif /* MRT_NO_NAMES */
} MRT_Class ;
typedef void (*MRT_InstCtor)(void *const) ;
typedef void (*MRT_InstDtor)(void *const) ;
typedef struct mrtinstallocblock {
    void *storageStart ;
    void *storageFinish ;
    void *storageLast ;
    MRT_AllocStatus alloc ;
    size_t instanceSize ;
    MRT_InstCtor construct ;
    MRT_InstDtor destruct ;
    unsigned linkCount ;
    MRT_AttrOffset const *linkOffsets ;
} MRT_iab ;
typedef struct mrtinstanceiterator {
    void *instance ;
    MRT_iab *iab ;
} MRT_InstIterator ;
typedef uint32_t MRT_SetWord ;
#define MRT_SETWORD_BITS    (sizeof(MRT_SetWord) * 8)

typedef struct mrtinstanceset {
    MRT_Class const *classDesc ; // <1>
    MRT_SetWord instvector[(MRT_INSTANCESETSIZE + MRT_SETWORD_BITS - 1) /
            MRT_SETWORD_BITS] ; // <2>
} MRT_InstSet ;
typedef struct mrtinstsetiterator {
    MRT_InstSet *set ;
    void *instance ;
    MRT_SetWord *vectorloc ;
    unsigned bitoffset ;
} MRT_InstSetIterator ;
typedef enum {
    mrtSimpleAssoc,
    mrtClassAssoc,
    mrtRefGeneralization,
    mrtUnionGeneralization
} MRT_RelType ;
typedef enum {
    mrtAtMostOne = 0,
    mrtExactlyOne,
    mrtZeroOrMore,
    mrtOneOrMore
} MRT_Cardinality ;
typedef enum {
    mrtSingular,
    mrtArray,
    mrtLinkedList
} MRT_RefStorageType ;
typedef struct mrtarrayref {
    MRT_Instance * const *links ;
    unsigned count ;
} MRT_ArrayRef ;
typedef struct mrtlinkref {
    struct mrtlinkref *next ;
    struct mrtlinkref *prev ;
} MRT_LinkRef ;
struct mrtassociationrole {
    MRT_Class const *classDesc ;
    MRT_Cardinality cardinality ;
    MRT_RefStorageType storageType ;
    MRT_AttrOffset storageOffset ;
    MRT_AttrOffset linkOffset ;
} ;
struct mrtsimpleassociation {
    struct mrtassociationrole source ;
    struct mrtassociationrole target ;
} ;
struct mrtassociatorrole {
    MRT_Class const *classDesc ;
    MRT_AttrOffset forwardOffset ;
    MRT_AttrOffset backwardOffset ;
} ;
struct mrtclassassociation {
    struct mrtassociationrole source ;
    struct mrtassociationrole target ;
    struct mrtassociatorrole associator ;
} ;
struct mrtsuperclassrole {
    MRT_Class const *classDesc ;
    MRT_AttrOffset storageOffset ;
} ;
struct mrtrefsubclassrole {
    MRT_Class const *classDesc ;
    MRT_AttrOffset storageOffset ;
} ;
struct mrtrefgeneralization {
    struct mrtsuperclassrole superclass ;
    unsigned subclassCount ;
    struct mrtrefsubclassrole const *subclasses ;
} ;
struct mrtuniongeneralization {
    struct mrtsuperclassrole superclass ;
    unsigned subclassCount ;
    MRT_Class const * const *subclasses ;
} ;
typedef struct mrtrelationship {
    MRT_RelType relType ;
    union {
        struct mrtsimpleassociation simpleAssociation ;
        struct mrtclassassociation classAssociation ;
        struct mrtrefgeneralization refGeneralization ;
        struct mrtuniongeneralization unionGeneralization ;
    } relInfo ;

#       ifndef MRT_NO_NAMES
    char const *name ;
#       endif /* MRT_NO_NAMES */
} MRT_Relationship ;
typedef struct mrtecb {
    struct mrtecb *next ;
    struct mrtecb *prev ;
    MRT_EventCode eventNumber ;
    MRT_AllocStatus alloc ;
    MRT_Instance *targetInst ;
    MRT_Instance *sourceInst ;
    MRT_DelayTime delay ;
    alignas(max_align_t) MRT_EventParams eventParameters ;
} MRT_ecb ;
typedef struct mrteventdispatchblock {
    MRT_DispatchCount stateCount ;
    MRT_DispatchCount eventCount ;
    MRT_StateCode initialState ;
    MRT_StateCode creationState ;
    MRT_StateCode const *transitionTable ;
    MRT_PtrActivityFunction const *activityTable ;
    bool const *finalStates ;

#       ifndef MRT_NO_NAMES
    char const *const *stateNames ;
#       endif /* MRT_NO_NAMES */
} MRT_edb ;
typedef struct mrtgendispatchblock {
    struct mrtrelationship const *relship ;
    MRT_EventCode const *eventMap ;
} MRT_gdb ;
typedef struct mrtpolydispatchblock {
    MRT_DispatchCount eventCount ;
    MRT_DispatchCount genCount ;
    struct mrtgendispatchblock const *genDispatch ;

#       ifndef MRT_NO_NAMES
    char const *const *genNames ;
#       endif /* MRT_NO_NAMES */
} MRT_pdb ;
typedef struct mrtdomainportal {
    unsigned classCount ;
    MRT_Class const *classes ;
    unsigned assignerCount ;
    MRT_Class const *assigners ;

#       ifndef MRT_NO_NAMES
    char const *name ;
#       endif /* MRT_NO_NAMES */
} MRT_DomainPortal ;
typedef MRT_EventParams MRT_SyncParams ;
typedef void (*MRT_SyncFunc)(MRT_SyncParams const *) ;
typedef void (*MRT_FatalErrorHandler)(MRT_ErrorCode, char const *, va_list) ;

#   ifndef MRT_NO_TRACE
typedef struct mrttraceinfo {
    MRT_EventType eventType ;
    MRT_EventCode eventNumber ;
    MRT_Instance *sourceInst ;
    MRT_Instance *targetInst ;
    union {
        struct transitiontrace {
            MRT_StateCode currentState ;
            MRT_StateCode newState ;
        } transitionTrace ;
        struct polytrace {
            MRT_SubclassCode subcode ;
            MRT_DispatchCount genNumber ;
            MRT_EventCode mappedEvent ;
        } polyTrace ;
        struct creationtrace {
            MRT_Class const *targetClass ;
        } creationTrace ;
    } info ;
} MRT_TraceInfo ;
typedef void (*MRT_TraceHandler)(MRT_TraceInfo const *) ;
#   endif /* MRT_NO_TRACE */

/*
 * Static Inline Functions
 */
static inline
MRT_LinkRef *
mrtLinkRefBegin(
    MRT_LinkRef const *iter)
{
    return iter->next ;
}
static inline
MRT_LinkRef *
mrtLinkRefEnd(
    MRT_LinkRef const *iter)
{
    return (MRT_LinkRef *)iter ;
}
static inline
bool
mrtLinkRefEmpty(
    MRT_LinkRef const *ref)
{
    return ref->next == ref ;
}
static inline
bool
mrtLinkRefNotEmpty(
    MRT_LinkRef const *ref)
{
    return ref->next != ref ;
}

/*
 * External Functions
 */
#   ifndef MRT_NO_TRACE
extern MRT_TraceHandler mrt_RegisterTraceHandler(MRT_TraceHandler) ;
#   endif /* MRT_NO_TRACE */

extern void mrt_Initialize(void) ;
extern void mrt_EventLoop(void) ;
extern bool
mrt_SyncToEventLoop() ;
extern bool mrt_DispatchThreadOfControl(void) ;
extern bool mrt_DispatchSingleEvent(void) ;
extern MRT_iab *
mrt_GetStorageProperties(
    MRT_Class const *classDesc,
    size_t *offsetptr) ;
extern unsigned
mrt_InstanceIndex(
    void *instance) ;
extern void *
mrt_InstanceReference(
    MRT_Class const *classDesc,
    unsigned index) ;
extern void *
mrt_CreateInstance(
    MRT_Class const *classDesc,
    MRT_StateCode initialState) ;
extern void
mrt_DeleteInstance(
    void *instref) ;
extern void
mrt_InstIteratorStart(
    MRT_InstIterator *iter,
    MRT_Class const *classDesc) ;
extern bool
mrt_InstIteratorMore(
    MRT_InstIterator *iter) ;
extern void *
mrt_InstIteratorGet(
    MRT_InstIterator *iter) ;
extern void
mrt_InstIteratorNext(
    MRT_InstIterator *iter) ;
extern void
mrt_InstSetInitialize(
    MRT_InstSet *set,
    MRT_Class const *classDesc) ;
extern void
mrt_InstSetAddInstance(
    MRT_InstSet *set,
    void *instance) ;
extern void
mrt_InstSetRemoveInstance(
    MRT_InstSet *set,
    void *instance) ;
extern bool
mrt_InstSetMember(
    MRT_InstSet *set,
    void *instance) ;
extern bool
mrt_InstSetEmpty(
    MRT_InstSet *set) ;
extern unsigned
mrt_InstSetCardinality(
    MRT_InstSet *set) ;
extern bool
mrt_InstSetEqual(
    MRT_InstSet *set1,
    MRT_InstSet *set2) ;
extern void
mrt_InstSetUnion(
    MRT_InstSet *set1,
    MRT_InstSet *set2,
    MRT_InstSet *result) ;
extern void
mrt_InstSetIntersect(
    MRT_InstSet *set1,
    MRT_InstSet *set2,
    MRT_InstSet *result) ;
extern void
mrt_InstSetMinus(
    MRT_InstSet *set1,
    MRT_InstSet *set2,
    MRT_InstSet *result) ;
extern void
mrt_InstSetIterBegin(
    MRT_InstSet *set,
    MRT_InstSetIterator *iter) ;
extern bool
mrt_InstSetIterMore(
    MRT_InstSetIterator *iter) ;
extern void *
mrt_InstSetIterGet(
    MRT_InstSetIterator *iter) ;
extern void
mrt_InstSetIterNext(
    MRT_InstSetIterator *iter) ;
extern void
mrt_CreateSimpleLinks(
    MRT_Relationship const *rel,
    void *source,
    void *target) ;
extern void
mrt_CreateAssociatorLinks(
    MRT_Relationship const *rel,
    void *assoc,
    void *source,
    void *target) ;
extern void
mrtDeleteLinks(
    struct mrtrelationship const * const *classRels,
    unsigned relCount,
    void *inst) ;
extern void *
mrt_Reclassify(
    MRT_Relationship const *rel,
    void *super,
    MRT_Class const *newSubclass) ;
extern MRT_ecb *mrt_NewEvent(
    MRT_EventCode event,
    void *target,
    void *source) ;
extern void
mrt_PostEvent(
    MRT_ecb *ecb) ;
extern void *
mrt_CreateAsync(
    MRT_Class const *targetClass,
    MRT_EventCode event,
    void const *eventparams,
    size_t paramsize,
    void *sourceInst) ;
extern void
mrt_PostDelayedEvent(
    MRT_ecb *ecb,
    MRT_DelayTime time) ;
extern void
mrt_CancelDelayedEvent(
    MRT_EventCode event,
    void *target,
    void *source) ;
extern MRT_DelayTime
mrt_RemainingDelayTime(
    MRT_EventCode event,
    void *target,
    void *source) ;
/*
 * Must be invoked from interrupt service level only!
 */
extern MRT_DelayTime
mrt_TimerExpireService(void) ;
extern int
mrt_PortalGetAttrRef(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_InstId instId,
    MRT_AttrId attrId,
    void **pref,
    MRT_AttrSize *size) ;
extern int
mrt_PortalReadAttr(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_InstId instId,
    MRT_AttrId attrId,
    void *dst,
    MRT_AttrSize dstSize) ;
extern int
mrt_PortalUpdateAttr(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_InstId instId,
    MRT_AttrId attrId,
    void const *src,
    MRT_AttrSize srcSize) ;
extern int
mrt_PortalSignalEvent(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_InstId instId,
    MRT_EventCode eventNumber,
    void const *eventParameters,
    size_t paramSize) ;
extern int
mrt_PortalSignalDelayedEvent(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_InstId instId,
    MRT_EventCode eventNumber,
    void const *eventParameters,
    size_t paramSize,
    MRT_DelayTime delay) ;
extern int
mrt_PortalCancelDelayedEvent(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_InstId instId,
    MRT_EventCode eventNumber) ;
extern int
mrt_PortalRemainingDelayTime(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_InstId instId,
    MRT_EventCode eventNumber,
    MRT_DelayTime *delayRef) ;
extern int
mrt_PortalCreateInstance(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_StateCode initialState) ;
extern int
mrt_PortalCreateAsync(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_EventCode eventNumber,
    void const *eventParameters,
    size_t paramSize) ;
extern int
mrt_PortalDeleteInstance(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_InstId instId) ;
extern int
mrt_PortalSignalEventToAssigner(
    MRT_DomainPortal const *portal,
    MRT_AssignerId assignerId,
    MRT_InstId instId,
    MRT_EventCode eventNumber,
    void const *eventParameters,
    size_t paramSize) ;
extern int
mrt_PortalInstanceCurrentState(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_InstId instId) ;
extern int
mrt_PortalAssignerCurrentState(
    MRT_DomainPortal const *portal,
    MRT_AssignerId assignerId,
    MRT_InstId instId) ;
extern char const *
mrt_PortalDomainName(
    MRT_DomainPortal const *portal) ;
extern unsigned
mrt_PortalDomainClassCount(
    MRT_DomainPortal const *portal) ;
extern int
mrt_PortalClassName(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    char const **nameRef) ;
extern int
mrt_PortalClassAttributeCount(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId) ;
extern int
mrt_PortalClassInstanceCount(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId) ;
extern int
mrt_PortalClassEventCount(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId) ;
extern int
mrt_PortalClassStateCount(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId) ;
extern int
mrt_PortalClassAttributeName(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_AttrId attrId,
    char const **nameRef) ;
extern int
mrt_PortalClassAttributeSize(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_AttrId attrId) ;
extern int
mrt_PortalClassEventName(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_EventCode eventCode,
    char const **nameRef) ;
extern int
mrt_PortalClassStateName(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_StateCode stateCode,
    char const **nameRef) ;
extern MRT_SyncParams *mrt_SyncRequest(MRT_SyncFunc) ;
extern MRT_FatalErrorHandler
mrt_SetFatalErrorHandler(
    MRT_FatalErrorHandler newHandler) ;
extern bool
mrt_CanCreateInstance(
    MRT_Class const *classDesc) ;
extern bool
mrt_CanSignalEvent(void) ;
MRT_SyncParams *
mrt_TrySyncRequest(
    MRT_SyncFunc f) ;
typedef void (*MRT_SignalFunc)(int) ;

extern void
mrt_RegisterSignal(
    int sigNum,
    MRT_SignalFunc func) ;
typedef void (*MRT_FDServiceFunc)(int) ;
extern void
mrt_RegisterFDService(
    int fd,
    MRT_FDServiceFunc readService,
    MRT_FDServiceFunc writeService,
    MRT_FDServiceFunc exceptService) ;
extern void
mrt_UnregisterFDService(
    int fd,
    bool rmRead,
    bool rmWrite,
    bool rmExcept) ;

#endif /* MICCA_RT_H_ */
