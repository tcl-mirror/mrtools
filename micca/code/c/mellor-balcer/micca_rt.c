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

#define _POSIX_C_SOURCE 200112L

#include "micca_rt.h"
#include <signal.h>
#include <errno.h>
#include <sys/select.h>
#include <sys/time.h>
#include <time.h>

/*
 * Constants
 */
#define MRT_DELAY_EXPIRED  UINT32_MAX

/*
 * Data Types
 */
struct mrtTransaction {
    unsigned count ;
    MRT_Relationship const *relationships[MRT_TRANSACTIONSIZE] ;
} ;
typedef struct mrteventqueue {
    MRT_ecb *next ;
    MRT_ecb *prev ;
} MRT_EventQueue ;
typedef struct mrtsyncblock {
    MRT_SyncFunc function ;
    alignas(max_align_t) MRT_SyncParams params ;
} MRT_SyncBlock ;
typedef struct mrtsyncqueue {
    MRT_SyncBlock *head ;
    MRT_SyncBlock *tail ;
} MRT_SyncQueue ;
typedef struct mrtfdservicemap {
    bool set ;
    MRT_FDServiceFunc read ;
    MRT_FDServiceFunc write ;
    MRT_FDServiceFunc except ;
} MRT_FDServiceMap ;

/*
 * Forward References
 */
static bool mrtProcessOneEvent(MRT_EventQueue *queue) ;
static MRT_Instance *
mrtFindInstSlot(
    MRT_iab *iab) ;
static inline void *
mrtNextInstSlot(
    MRT_iab *iab,
    void *ptr) ;
static inline MRT_AllocStatus mrtIncrAllocCounter(MRT_iab *iab) ;
static void
mrtMarkRelationship(
    MRT_Relationship const *const *rel,
    unsigned relCount) ;
static void mrtEndTransaction(void) ;

static bool mrtCheckRelationship(MRT_Relationship const *rel) ;
static void mrtZeroRefCounts(MRT_Class const *classDesc) ;
static bool
mrtCheckRefCounts(MRT_Class const *classDesc, MRT_Cardinality cardinality) ;
static bool
mrtCheckAssociatorRefs(struct mrtassociatorrole const *associator) ;
static void
mrtCountAssocRefs(
    struct mrtassociationrole const *source,
    struct mrtassociationrole const *target) ;
static void
mrtCountSingularRefs(
    MRT_Class const *sourceClass,
    MRT_AttrOffset offset,
    MRT_Class const *targetClass) ;
static void
mrtCountArrayRefs(
    MRT_Class const *sourceClass,
    MRT_AttrOffset offset,
    MRT_Class const *targetClass) ;
static void
mrtCountLinkedListRefs(
    MRT_Class const *sourceClass,
    MRT_AttrOffset refOffset,
    MRT_Class const *targetClass,
    MRT_AttrOffset linkOffset) ;
static void
mrtCountClassAssocRefs(
    struct mrtassociationrole const *participant,
    MRT_Class const *assocClass,
    MRT_AttrOffset assocOffset) ;
static void
mrtCountGenRefs(
    struct mrtrefgeneralization const *gen) ;
static void
mrtSimpUnlinkForward(
    struct mrtsimpleassociation const *assoc,
    void *source) ;
static void
mrtSimpUnlinkBack(
    struct mrtsimpleassociation const *assoc,
    void *target) ;
static void
mrtUnlinkBackref(
    struct mrtassociationrole const *targetRole,
    void *source,
    void *target) ;
static void mrtRemoveDelayedEvent(MRT_ecb *ecb) ;
static MRT_ecb *mrtExpireDelayedEvents(void) ;
static void mrtStartDelayedQueueTiming(void) ;
static void mrtStopDelayedQueueTiming(void) ;
static bool mrtDispatchEventFromQueue(MRT_EventQueue *queue) ;

static void mrtDispatchTransitionEvent(MRT_ecb *ecb) ;
static void mrtDispatchPolymorphicEvent(MRT_ecb *ecb) ;
static void mrtDispatchCreationEvent(MRT_ecb *ecb) ;
static void mrtDispatchEvent(MRT_ecb *ecb) ;
static inline bool mrtSyncQueueEmpty(void) ;
static inline MRT_SyncParams *mrtSyncQueuePut(MRT_SyncFunc f, bool fatal) ;
static inline MRT_SyncBlock *mrtSyncQueueGet(void) ;
static inline bool mrtInvokeOneSyncFunction(void) ;
#ifndef MRT_NO_TRACE
static char const *mrtTimestamp(void) ;
#endif /* MRT_NO_TRACE */
static void
mrtDefaultFatalErrorHandler(
    MRT_ErrorCode errNum,
    char const *fmt,
    va_list ap) ;
static noreturn void mrtFatalError(MRT_ErrorCode errNum, ...) ;

/*
 * Static Data
 */
#   ifndef MRT_NO_TRACE
static MRT_TraceHandler mrtTraceHandler ;
#   endif /* MRT_NO_TRACE */

static bool mrtExitEventLoop ;
static struct mrtTransaction mrtTransaction ;
static MRT_ecb mrtECBPool[MRT_EVENTPOOLSIZE] ;
static MRT_EventQueue eventQueue ;
static MRT_EventQueue tocEventQueue ;
static MRT_EventQueue delayedEventQueue ;
static MRT_EventQueue freeEventQueue ;
static MRT_SyncBlock mrtSyncQueueStorage[MRT_SYNCQUEUESIZE] ;
static MRT_SyncQueue mrtSyncQueue = {
    .head = mrtSyncQueueStorage,
    .tail = mrtSyncQueueStorage,
} ;
static char const * const errMsgs[] = {
    [0] = "no error",     /* place holder */
    [mrtNoECB] = "no available Event Control Blocks\n",
    [mrtSyncOverflow] = "synchronization queue overflow\n",
    [mrtTransOverflow] = "transaction markings overflow\n",
    [mrtStaticRelationship] = "attempt to modify static relationship\n",
    [mrtRelationshipLinkage] = "invalid instance linkage operation or value\n",

#       ifndef MRT_NO_NAMES
    [mrtCantHappen] = "can't happen transition: %s.%s: %s - %s -> CH\n",
    [mrtEventInFlight] = "event-in-flight error: %s.%s - %s -> %s.%s\n",
    [mrtNoInstSlot] = "no available instance slots: %s\n",
    [mrtUnallocSlot] = "unallocated instance slot: %s\n",
    [mrtRefIntegrity] = "referential integrity check failed: %s\n",
#       else
    [mrtCantHappen] = "can't happen transition: %p: %u - %u -> CH\n",
    [mrtEventInFlight] = "event-in-flight error: %p - %u -> %p\n",
    [mrtNoInstSlot] = "no available instance slots: %p\n",
    [mrtUnallocSlot] = "unallocated instance slot: %p\n",
    [mrtRefIntegrity] = "referential integrity check failed: %p\n",
#       endif /* MRT_NO_NAMES */

#       ifdef _POSIX_C_SOURCE
    [mrtTimerOpFailed] = "interval timer operation failed: %s\n",
    [mrtSignalOpFailed] = "signal operation failed: %s\n",
    [mrtSelectWaitFailed] = "blocking on pselect() failed: %s\n",
#       endif /* _POSIX_C_SOURCE */
} ;
static MRT_FatalErrorHandler mrtErrHandler = mrtDefaultFatalErrorHandler ;
static sigset_t mrtSigMask ;
static struct mrtfdservicemap mrtFDServicePool[FD_SETSIZE] ;
static int mrtMaxFD = -1 ;
static fd_set mrtReadFDS ;
static fd_set mrtWriteFDS ;
static fd_set mrtExceptFDS ;

/*
 * Static Inline Functions
 */
static inline
void
mrtLinkRefInit(
    MRT_LinkRef *ref)
{
    ref->next = ref->prev = ref ;
}
static inline
void
mrtLinkRefRemove(
    MRT_LinkRef *item)
{
    item->prev->next = item->next ;
    item->next->prev = item->prev ;
    item->next = item->prev = NULL ; // <1>
}
static inline
void
mrtLinkRefInsert(
    MRT_LinkRef *item,
    MRT_LinkRef *at)
{
    if (item->next != NULL || item->prev != NULL) { // <2>
        mrtFatalError(mrtRelationshipLinkage) ;
    }
    item->prev = at->prev ;
    item->next = at ;
    at->prev->next = item ;
    at->prev = item ;
}
static inline
MRT_ecb *
mrtEventQueueBegin(
    MRT_EventQueue *queue)
{
    return queue->next ;
}
static inline
MRT_ecb *
mrtEventQueueEnd(
    MRT_EventQueue *queue)
{
    return (MRT_ecb *)queue ;
}
static inline
bool
mrtEventQueueEmpty(
    MRT_EventQueue *queue)
{
    return queue->next == (MRT_ecb *)queue ;
}
static inline
void
mrtEventQueueInsert(
    MRT_ecb *item,
    MRT_ecb *at)
{
    item->prev = at->prev ;
    item->next = at ;
    at->prev->next = item ;
    at->prev = item ;
}
static inline
void
mrtEventQueueRemove(
    MRT_ecb *item)
{
    item->prev->next = item->next ;
    item->next->prev = item->prev ;
    item->prev = item->next = NULL ; // <1>
}

/*
 * Static Functions
 */
#   ifndef MRT_NO_TRACE
static inline 
void
mrtTraceTransitionEvent(
    MRT_EventCode event,
    MRT_Instance *source,
    MRT_Instance *target,
    MRT_StateCode currentState,
    MRT_StateCode newState)
{
    if (mrtTraceHandler) {
        MRT_TraceInfo trace = {
            .eventType = mrtTransitionEvent,
            .eventNumber = event,
            .sourceInst = source,
            .targetInst = target,
            .info.transitionTrace = {
                .currentState = currentState,
                .newState = newState
            }
        } ;
        mrtTraceHandler(&trace) ;
    }
}
static inline 
void
mrtTracePolyEvent(
    MRT_EventCode event,
    MRT_Instance *source,
    MRT_Instance *target,
    MRT_SubclassCode subclass,
    MRT_DispatchCount genNumber,
    MRT_EventCode newEvent)
{
    if (mrtTraceHandler) {
        MRT_TraceInfo trace = {
            .eventType = mrtPolymorphicEvent,
            .eventNumber = event,
            .sourceInst = source,
            .targetInst = target,
            .info.polyTrace = {
                .subcode = subclass,
                .genNumber = genNumber,
                .mappedEvent = newEvent
            }
        } ;
        mrtTraceHandler(&trace) ;
    }
}
static inline 
void
mrtTraceCreationEvent(
    MRT_EventCode event,
    MRT_Instance *source,
    MRT_Instance *target,
    MRT_Class const *class)
{
    if (mrtTraceHandler) {
        MRT_TraceInfo trace = {
            .eventType = mrtCreationEvent,
            .eventNumber = event,
            .sourceInst = source,
            .targetInst = target,
            .info.creationTrace = {
                .targetClass = class
            }
        } ;
        mrtTraceHandler(&trace) ;
    }
}
#ifndef MRT_NO_NAMES
static void
mrtPrintTraceInfo(
    MRT_TraceInfo const *traceInfo)
{
    char const *sourceName ;
    char const *sourceClassName ;
    char sourceIdNum[32] ;

    if (traceInfo->sourceInst == NULL) {
        sourceName = "?" ;
        sourceClassName = "?" ;
    } else {
        sourceClassName = traceInfo->sourceInst->classDesc->name ;
        sourceName = traceInfo->sourceInst->name ;
        if (sourceName == NULL) {
            unsigned instid = mrt_InstanceIndex(traceInfo->sourceInst) ;
            snprintf(sourceIdNum, sizeof(sourceIdNum), "%u", instid) ;
            sourceName = sourceIdNum ;
        }
    }
    
    char const *targetName = traceInfo->targetInst->name ;
    char targetIdNum[32] ;
    if (targetName == NULL) {
        unsigned instid = mrt_InstanceIndex(traceInfo->targetInst) ;
        snprintf(targetIdNum, sizeof(targetIdNum), "%u", instid) ;
        targetName = targetIdNum ;
    }

    switch (traceInfo->eventType) {
    case mrtTransitionEvent: {
        MRT_StateCode newState = traceInfo->info.transitionTrace.newState ;
        char const *newStateName ;
        if (newState == MRT_StateCode_IG) {
            newStateName = "IG" ;
        } else if (newState == MRT_StateCode_CH) {
            newStateName = "CH" ;
        } else {
            newStateName = traceInfo->targetInst->classDesc->edb->stateNames[
                traceInfo->info.transitionTrace.newState] ;
        }

        printf("%s: Transition: %s.%s - %s -> %s.%s: %s ==> %s\n",
            mrtTimestamp(), sourceClassName, sourceName,
            traceInfo->targetInst->classDesc->eventNames[traceInfo->eventNumber],
            traceInfo->targetInst->classDesc->name, targetName,
            traceInfo->targetInst->classDesc->edb->stateNames[
                traceInfo->info.transitionTrace.currentState],
            newStateName) ;
    }
        break ;

    case mrtPolymorphicEvent: {
        MRT_Relationship const *rel = traceInfo->targetInst->classDesc->pdb->
                genDispatch[traceInfo->info.polyTrace.genNumber].relship ;
        MRT_Class const *subclass ;
        char const *subname = NULL ;
        if (rel->relType == mrtRefGeneralization) {
            subclass = rel->relInfo.refGeneralization.
                subclasses[traceInfo->info.polyTrace.subcode].classDesc ;
            subname = subclass->name ;
        } else if (rel->relType == mrtUnionGeneralization) {
            subclass = rel->relInfo.unionGeneralization.
                subclasses[traceInfo->info.polyTrace.subcode] ;
            subname = subclass->name ;
        } else {
            printf("%s: bad relationship type in polymorphic event, %d\n",
                mrtTimestamp(), rel->relType) ;
            break ;
        }
        printf("%s: Polymorphic: %s.%s - %s -> %s.%s: %s - %s -> %s\n",
            mrtTimestamp(), sourceClassName, sourceName,
            traceInfo->targetInst->classDesc->eventNames[traceInfo->eventNumber],
            traceInfo->targetInst->classDesc->name, targetName,
            traceInfo->targetInst->classDesc->pdb->genNames[
                traceInfo->info.polyTrace.genNumber],
            subclass->eventNames[traceInfo->info.polyTrace.mappedEvent],
            subname) ;
    }
        break ;

    case mrtCreationEvent:
        printf("%s: Creation: %s.%s - %s -> %s ==> %s\n",
            mrtTimestamp(), sourceClassName, sourceName,
            traceInfo->targetInst->classDesc->eventNames[traceInfo->eventNumber],
            traceInfo->info.creationTrace.targetClass->name,
            targetName) ;
        break ;

    default:
        printf("%s: Unknown trace event type, \"%u\"",
                mrtTimestamp(), traceInfo->eventType) ;
        break ;
    }
}
#   else  /* MRT_NO_NAMES is defined */
static void
mrtPrintTraceInfo(
    MRT_TraceInfo const *traceInfo)
{
    switch (traceInfo->eventType) {
    case mrtTransitionEvent:
        printf("%s: Transition: %p - %u -> %p: %u ==> %u\n",
                mrtTimestamp(), traceInfo->sourceInst, traceInfo->eventNumber,
                traceInfo->targetInst,
                traceInfo->info.transitionTrace.currentState,
                traceInfo->info.transitionTrace.newState) ;
        break ;

    case mrtPolymorphicEvent:
        printf("%s: Polymorphic: %p - %u -> %p: %u - %u -> %d\n",
                mrtTimestamp(), traceInfo->sourceInst, traceInfo->eventNumber,
                traceInfo->targetInst,traceInfo->info.polyTrace.genNumber,
                traceInfo->info.polyTrace.mappedEvent,
                traceInfo->info.polyTrace.subcode) ;
        break ;

    case mrtCreationEvent:
        printf("%s: Creation: %p - %u -> %p ==> %p\n",
                mrtTimestamp(), traceInfo->sourceInst, traceInfo->eventNumber,
                traceInfo->info.creationTrace.targetClass,
                traceInfo->targetInst) ;
        break ;

    default:
        printf("%s: Unknown trace event type, \"%u\"",
                mrtTimestamp(), traceInfo->eventType) ;
        break ;
    }
}
#endif /* MRT_NO_NAMES */
static char const *
mrtTimestamp(void)
{
    static char timestamp[128] ;

    struct timeval now ;
    if (gettimeofday(&now, NULL) != 0) {
        return "unknown" ;
    }

    struct tm *ltime ;
    ltime = localtime(&now.tv_sec) ;
    if (ltime == NULL) {
        return strerror(errno) ;
    }

    int tlen = strftime(timestamp, sizeof(timestamp), "%FT%T", ltime) ;
    if (tlen == 0) {
        return strerror(errno) ;
    }

    int flen = snprintf(timestamp + tlen, sizeof(timestamp) - tlen,
            ".%03u.%03u", (unsigned)(now.tv_usec / 1000),
            (unsigned)(now.tv_usec % 1000)) ;
    if (flen > (sizeof(timestamp) - tlen)) {
        return "too big" ;
    }

    return timestamp ;
}
#   endif /* MRT_NO_TRACE */

static inline
void
mrtInitCriticalSection(void)
{
    sigemptyset(&mrtSigMask) ;
}
static inline
void
beginCriticalSection(void)
{
    if (sigprocmask(SIG_BLOCK, &mrtSigMask, NULL) != 0) {
        mrtFatalError(mrtSignalOpFailed, strerror(errno)) ;
    }
}
static inline
void
endCriticalSection(void)
{
    if (sigprocmask(SIG_UNBLOCK, &mrtSigMask, NULL) != 0) {
        mrtFatalError(mrtSignalOpFailed, strerror(errno)) ;
    }
}
static inline
MRT_DelayTime
mrtMsecToTicks(
    MRT_DelayTime msec)
{
    return msec ;
}
static inline
MRT_DelayTime
mrtTicksToMsec(
    MRT_DelayTime ticks)
{
    return ticks ;
}
static void
mrtSysTimerMask(void)
{
    /*
     * Make sure SIGALRM does not go off.
     */
    sigset_t mask ;
    sigemptyset(&mask) ;
    sigaddset(&mask, SIGALRM) ;
    if (sigprocmask(SIG_BLOCK, &mask, NULL) != 0) {
        mrtFatalError(mrtSignalOpFailed, strerror(errno)) ;
    }
}
static void
mrtSysTimerUnmask(void)
{
    /*
     * Allow SIGALRM to notify us.
     */
    sigset_t mask ;
    sigemptyset(&mask) ;
    sigaddset(&mask, SIGALRM) ;
    if (sigprocmask(SIG_UNBLOCK, &mask, NULL) != 0) {
        mrtFatalError(mrtSignalOpFailed, strerror(errno)) ;
    }
}
static void
mrtSysTimerStart(
    MRT_DelayTime time)
{
    struct itimerval delayedEventTimer ;

    delayedEventTimer.it_interval.tv_sec = 0 ;
    delayedEventTimer.it_interval.tv_usec = 0 ;
    delayedEventTimer.it_value.tv_sec = time / 1000 ;
    delayedEventTimer.it_value.tv_usec = (time % 1000) * 1000 ;

    if (setitimer(ITIMER_REAL, &delayedEventTimer, NULL) != 0) {
        mrtFatalError(mrtTimerOpFailed, strerror(errno)) ;
    }
    mrtSysTimerUnmask() ;
}
static MRT_DelayTime
mrtSysTimerStop(void)
{
    mrtSysTimerMask() ;
    /*
     * Fetch the remaining time.
     */
    struct itimerval delayedEventTimer ;
    if (getitimer(ITIMER_REAL, &delayedEventTimer) != 0) {
        mrtFatalError(mrtTimerOpFailed, strerror(errno)) ;
    }
    /*
     * Convert the returned time into milliseconds.
     */
    MRT_DelayTime remain =
            delayedEventTimer.it_value.tv_sec * 1000 +
            delayedEventTimer.it_value.tv_usec / 1000 ;
    /*
     * Set the current timer value to zero to turn it off.
     */
    memset(&delayedEventTimer, 0, sizeof(delayedEventTimer)) ;
    if (setitimer(ITIMER_REAL, &delayedEventTimer, NULL) != 0) {
        mrtFatalError(mrtTimerOpFailed, strerror(errno)) ;
    }

    return remain ;
}
static void
mrtSysTimerExpire(
    int signum)
{
    MRT_DelayTime nextTime = mrt_TimerExpireService() ;
    if (nextTime != 0) {
        mrtSysTimerStart(nextTime) ;
    }
}
static void
mrtInitSysTimer(void)
{
    mrt_RegisterSignal(SIGALRM, mrtSysTimerExpire) ;
}
static void
mrtInitFDService(void)
{
    FD_ZERO(&mrtReadFDS) ;
    FD_ZERO(&mrtWriteFDS) ;
    FD_ZERO(&mrtExceptFDS) ;
}
static void
mrtWait(void)
{
    beginCriticalSection() ;
    if (mrtSyncQueueEmpty()) {
        /*
         * Copy the file descriptor sets since "pselect" modifies them in place
         * upon return.
         */
        fd_set readfds ;
        memcpy(&readfds, &mrtReadFDS, sizeof(readfds)) ;
        fd_set writefds ;
        memcpy(&writefds, &mrtWriteFDS, sizeof(writefds)) ;
        fd_set exceptfds ;
        memcpy(&exceptfds, &mrtExceptFDS, sizeof(exceptfds)) ;
        /*
         * Allow all the signals during the select.
         */
        sigset_t mask ;
        sigemptyset(&mask) ;
        /*
         * "mrtMaxFD" holds the maximum value of any registered file
         * descriptor. We must add one to get the number of file descriptors
         * "pselect" is to consider.
         */
        int r = pselect(mrtMaxFD + 1, &readfds, &writefds,
                &exceptfds, NULL, &mask) ;
        if (r == -1) {
            if (errno != EINTR) {
                mrtFatalError(mrtSelectWaitFailed, strerror(errno)) ;
            }
            /*
             * Got a signal while waiting. We go back to the main loop on the
             * assumption that something has been placed in the sync queue.
             */
        } else {
            /*
             * Dispatch the service functions for the file descriptors.
             */
            MRT_FDServiceMap *s = mrtFDServicePool ;
            for (int fd = 0 ; r > 0 && fd <= mrtMaxFD ;
                    ++fd, ++s) {
                /*
                 * Do exceptions first. This is only important for sockets, but
                 * without going first the OOB data processing won't work.
                 */
                if (FD_ISSET(fd, &exceptfds)) {
                    assert(s->except != NULL) ;
                    s->except(fd) ;
                    --r ;
                }
                if (FD_ISSET(fd, &readfds)) {
                    assert(s->read != NULL) ;
                    s->read(fd) ;
                    --r ;
                }
                if (FD_ISSET(fd, &writefds)) {
                    assert(s->write != NULL) ;
                    s->write(fd) ;
                    --r ;
                }
            }
        }
    }
    endCriticalSection() ;
}
static void
mrtFinishThreadOfControl(void)
{
    while (mrtProcessOneEvent(&eventQueue)) {
        // N.B. empty loop body
    }
    mrtEndTransaction() ;
}
static bool
mrtRunThreadOfControl(void)
{
    assert(mrtEventQueueEmpty(&eventQueue)) ;

    bool rantoc = false ;
    if (mrtProcessOneEvent(&tocEventQueue)) {
        mrtFinishThreadOfControl() ;
        rantoc = true ;
    }

    return rantoc ;
}
static bool
mrtProcessOneEvent(
    MRT_EventQueue *queue)
{
#       ifndef MRT_ARM_ARCH_7M
    while (mrtInvokeOneSyncFunction()) {
        ; /* empty */
    }
#       endif

    return mrtDispatchEventFromQueue(queue) ;
}
static MRT_Instance *
mrtFindInstSlot(
    MRT_iab *iab)
{
    assert(iab != NULL) ;
    assert(iab->storageLast < iab->storageFinish) ;
    /*
     * Search for an empty slot in the pool. Start at the next location after
     * where we last allocated an instance.
     */
    MRT_Instance *inst ;
    for (inst = mrtNextInstSlot(iab, iab->storageLast) ;
            inst->alloc != 0 && inst != iab->storageLast ;
            inst = mrtNextInstSlot(iab, inst)) {
        /* Empty Body */
    }
    /*
     * Check if we ended up on a slot that is free.
     */
    return inst->alloc == 0 ? inst : NULL ; // <1>

}
static inline 
void *
mrtNextInstSlot(
    MRT_iab *iab,
    void *ptr)
{
    ptr = (void *)((uintptr_t)ptr + iab->instanceSize) ; // <1>
    if (ptr >= iab->storageFinish) { // <2>
        ptr = iab->storageStart ;
    }
    return ptr ;
}
static void
mrtInitializeInstance(
    MRT_Instance *inst,
    MRT_Class const *classDesc,
    MRT_StateCode initialState)
{
    assert(inst != NULL) ;
    assert(classDesc != NULL) ;

    MRT_iab *iab = classDesc->iab ;
    assert(iab != NULL) ;
    /*
     * Start with a zeroed out memory space.
     */
    memset(inst, 0, iab->instanceSize) ; // <1>
    inst->classDesc = classDesc ;
    /*
     * Mark the slot as in use.
     */
    inst->alloc = mrtIncrAllocCounter(iab) ;
    if (classDesc->edb != NULL) {
        assert(initialState < classDesc->edb->stateCount) ;

        inst->currentState = (initialState == MRT_StateCode_IG ||
            initialState >= classDesc->edb->stateCount) ?
                classDesc->edb->initialState : initialState ; // <2>
    } else {
        inst->currentState = MRT_StateCode_IG ; // <3>
    }

    MRT_AttrOffset const *offsets = iab->linkOffsets ; // <4>
    for (unsigned count = iab->linkCount ; count != 0 ; count--, offsets++) {
        MRT_LinkRef *link = (MRT_LinkRef *)((uintptr_t) inst + *offsets) ;
        mrtLinkRefInit(link) ;
    }
    /*
     * Run the constructor if there is one.
     */
    if (iab->construct) {
        iab->construct(inst) ;
    }
    mrtMarkRelationship(classDesc->classRels, classDesc->relCount) ; // <5>
}
static inline 
MRT_AllocStatus
mrtIncrAllocCounter(
    MRT_iab *iab)
{
    /*
     * Catch any overflow
     */
    iab->alloc = (iab->alloc == INT16_MAX ? 1 : iab->alloc + 1) ;
    return iab->alloc ;
}
static void
mrtMarkRelationship(
    MRT_Relationship const * const *rel,
    unsigned relCount)
{
    for ( ; relCount != 0 ; --relCount, ++rel) {
        bool found = false ;
        MRT_Relationship const **marked = mrtTransaction.relationships ;
        for (unsigned markedCount = mrtTransaction.count ; markedCount != 0 ;
                --markedCount, ++marked) { // <1>
            if (*marked == *rel) {
                found = true ;
                break ;
            }
        }

        if (!found) {
            if (mrtTransaction.count >= COUNTOF(mrtTransaction.relationships)) {
                mrtFatalError(mrtTransOverflow) ; // <2>
            }
            mrtTransaction.relationships[mrtTransaction.count++] = *rel ;
        }
    }
}
static void
mrtEndTransaction(void)
{
    MRT_Relationship const **rships = mrtTransaction.relationships ;
    for (unsigned count = 0 ; count < mrtTransaction.count ; count++, ++rships) {
        if (!mrtCheckRelationship(*rships)) {
            mrtTransaction.count -= count ;
            memmove(mrtTransaction.relationships, rships,
                mrtTransaction.count * sizeof(*rships)) ; // <1>

#               ifndef MRT_NO_NAMES
            mrtFatalError(mrtRefIntegrity, (*rships)->name) ;
#               else
            mrtFatalError(mrtRefIntegrity, *rships) ;
#               endif /* MRT_NO_NAMES */
        }
    }
    mrtTransaction.count = 0 ;
}
static bool
mrtCheckRelationship(
    MRT_Relationship const *rel)
{
    bool result = false ;

    switch (rel->relType) {
    case mrtSimpleAssoc: {
        struct mrtsimpleassociation const *assoc = &rel->relInfo.simpleAssociation ;
        
        mrtZeroRefCounts(assoc->source.classDesc) ;
        mrtZeroRefCounts(assoc->target.classDesc) ;
        
        mrtCountAssocRefs(&assoc->source, &assoc->target) ;
        
        result =
            mrtCheckRefCounts(assoc->source.classDesc, assoc->source.cardinality) &&
            mrtCheckRefCounts(assoc->target.classDesc, assoc->target.cardinality) ;
    }
        break ;

    case mrtClassAssoc: {
        struct mrtclassassociation const *assoc = &rel->relInfo.classAssociation ;
        
        result = mrtCheckAssociatorRefs(&assoc->associator) ; // <1>
        if (result) {
            /*
             * On the first side, we evaluate the references from the source class
             * to the associator class.
             */
            mrtZeroRefCounts(assoc->source.classDesc) ;
            mrtZeroRefCounts(assoc->associator.classDesc) ;
            mrtCountClassAssocRefs(&assoc->source, assoc->associator.classDesc,
                    assoc->associator.backwardOffset) ;
            result = mrtCheckRefCounts(assoc->source.classDesc,
                        assoc->source.cardinality) &&
                    mrtCheckRefCounts(assoc->associator.classDesc, mrtExactlyOne) ;
        
            /*
             * If the first side is okay, then we can evaluate the references from the
             * target class to the associator class.
             */
            if (result) {
                mrtZeroRefCounts(assoc->target.classDesc) ;
                mrtZeroRefCounts(assoc->associator.classDesc) ;
                mrtCountClassAssocRefs(&assoc->target, assoc->associator.classDesc,
                        assoc->associator.forwardOffset) ;
                result = mrtCheckRefCounts(assoc->target.classDesc,
                        assoc->target.cardinality) &&
                    mrtCheckRefCounts(assoc->associator.classDesc, mrtExactlyOne) ;
            }
        }
    }
        break ;

    case mrtRefGeneralization: {
        struct mrtrefgeneralization const *gen = &rel->relInfo.refGeneralization ;
        
        mrtZeroRefCounts(gen->superclass.classDesc) ;
        
        struct mrtrefsubclassrole const *subclass = gen->subclasses ;
        for (unsigned subcount = gen->subclassCount ; subcount != 0 ;
                --subcount, ++subclass) {
            mrtZeroRefCounts(subclass->classDesc) ;
        }
        
        mrtCountGenRefs(gen) ;
        
        result = mrtCheckRefCounts(gen->superclass.classDesc, mrtExactlyOne) ;
        subclass = gen->subclasses ;
        for (unsigned subcount = gen->subclassCount ; subcount != 0 && result ;
                --subcount, ++subclass) {
            result = mrtCheckRefCounts(subclass->classDesc, mrtExactlyOne) ;
        }
    }
        break ;

    case mrtUnionGeneralization: {
        struct mrtuniongeneralization const *gen = &rel->relInfo.unionGeneralization ;
        
        result = true ;
        MRT_Class const *superClass = gen->superclass.classDesc ;
        MRT_InstIterator iter ;
        for (mrt_InstIteratorStart(&iter, superClass) ; mrt_InstIteratorMore(&iter) ;
                mrt_InstIteratorNext(&iter)) {
            MRT_Instance *instref = mrt_InstIteratorGet(&iter) ;
            MRT_Instance *subInst = (MRT_Instance *)
                    ((uintptr_t)instref + gen->superclass.storageOffset) ;
            if (subInst->alloc <= 0) {
                result = false ;
                break ;
            }
        }
    }
        break ;

    /*
     * N.B. no default case. We will just fail the check if
     * this happens.
     */
    }

    return result ;
}
static void
mrtZeroRefCounts(
    MRT_Class const *classDesc)
{
    MRT_InstIterator iter ;
    for (mrt_InstIteratorStart(&iter, classDesc) ; mrt_InstIteratorMore(&iter) ;
            mrt_InstIteratorNext(&iter)) {
        MRT_Instance *instref = mrt_InstIteratorGet(&iter) ;
        instref->refCount = 0 ;
    }
}
static bool
mrtCompareAtMostOne(
    unsigned refCount)
{
    return refCount <= 1 ;
}

static bool
mrtCompareExactlyOne(
    unsigned refCount)
{
    return refCount == 1 ;
}

static bool
mrtCompareOneOrMore(
    unsigned refCount)
{
    return refCount >= 1 ;
}
static bool
mrtCheckRefCounts(
    MRT_Class const *classDesc,
    MRT_Cardinality cardinality)
{
    if (cardinality == mrtZeroOrMore) { // <1>
        return true ;
    }

    static bool (*const compareFuncs[])(unsigned) = {
        [mrtAtMostOne] = mrtCompareAtMostOne,
        [mrtExactlyOne] = mrtCompareExactlyOne,
        [mrtZeroOrMore] = NULL, // <2>
        [mrtOneOrMore] = mrtCompareOneOrMore
    } ;

    assert(cardinality <= mrtOneOrMore) ;
    bool (*const compareCardinality)(unsigned) = compareFuncs[cardinality] ; // <3>

    MRT_InstIterator iter ;
    for (mrt_InstIteratorStart(&iter, classDesc) ; mrt_InstIteratorMore(&iter) ;
            mrt_InstIteratorNext(&iter)) {
        MRT_Instance *instref = mrt_InstIteratorGet(&iter) ;
        if (!compareCardinality(instref->refCount)) {
            return false ; // <4>
        }
    }

    return true ;
}
static bool
mrtCheckAssociatorRefs(
    struct mrtassociatorrole const *associator)
{
    MRT_InstIterator iter ;
    for (mrt_InstIteratorStart(&iter, associator->classDesc) ;
            mrt_InstIteratorMore(&iter) ; mrt_InstIteratorNext(&iter)) {
        void *inst = mrt_InstIteratorGet(&iter) ;
        MRT_Instance *ref = *(MRT_Instance **)
                ((uintptr_t)inst + associator->forwardOffset) ;
        if (ref == NULL || ref->alloc == 0) { // <1>
            return false ;
        }
        ref = *(MRT_Instance **)((uintptr_t)inst + associator->backwardOffset) ;
        if (ref == NULL || ref->alloc == 0) {
            return false ;
        }
    }

    return true ;
}
static void
mrtCountAssocRefs(
    struct mrtassociationrole const *source,
    struct mrtassociationrole const *target)
{
    switch (source->storageType) {
    case mrtSingular:
        mrtCountSingularRefs(source->classDesc, source->storageOffset,
            target->classDesc) ;
        break ;

    case mrtLinkedList:
    case mrtArray:
    default:
        /*
         * For simple associations, the reference from the referring class to
         * the referenced class is always singular.  If we get here, there is a
         * serious linkage problem.
         */
        mrtFatalError(mrtRelationshipLinkage) ;
        break ;
    }

    switch (target->storageType) {
    case mrtSingular:
        mrtCountSingularRefs(target->classDesc, target->storageOffset,
            source->classDesc) ;
        break ;

    case mrtArray:
        mrtCountArrayRefs(target->classDesc, target->storageOffset,
            source->classDesc) ;
        break ;

    case mrtLinkedList:
        mrtCountLinkedListRefs(target->classDesc, target->storageOffset,
                source->classDesc, target->linkOffset) ;
        break ;

    default:
        mrtFatalError(mrtRelationshipLinkage) ;
        break ;
    }
}
static void
mrtCountSingularRefs(
    MRT_Class const *sourceClass,
    MRT_AttrOffset offset,
    MRT_Class const *targetClass)
{
    MRT_iab *targetiab = mrt_GetStorageProperties(targetClass, NULL) ;

    MRT_InstIterator srciter ;
    for (mrt_InstIteratorStart(&srciter, sourceClass) ;
            mrt_InstIteratorMore(&srciter) ; mrt_InstIteratorNext(&srciter)) {
        MRT_Instance *instref = mrt_InstIteratorGet(&srciter) ;
        MRT_Instance *targetInst =
                *(MRT_Instance **)((uintptr_t)instref + offset) ;
        if ((void *)targetInst >= targetiab->storageStart &&
                (void *)targetInst < targetiab->storageFinish &&
                targetInst->alloc > 0) { // <1>
            targetInst->refCount = targetInst->refCount == UINT8_MAX ?
                    2 : targetInst->refCount + 1 ; // <2>
        }
    }
}
static void
mrtCountArrayRefs(
    MRT_Class const *sourceClass,
    MRT_AttrOffset offset,
    MRT_Class const *targetClass)
{
    MRT_iab *targetiab = mrt_GetStorageProperties(targetClass, NULL) ;

    MRT_InstIterator srciter ;
    for (mrt_InstIteratorStart(&srciter, sourceClass) ;
            mrt_InstIteratorMore(&srciter) ; mrt_InstIteratorNext(&srciter)) {
        MRT_Instance *instref = mrt_InstIteratorGet(&srciter) ;
        MRT_ArrayRef *srcrefs =
                (MRT_ArrayRef *)((uintptr_t)instref + offset) ;
        MRT_Instance *const *iter = srcrefs->links ;
        for (unsigned count = srcrefs->count ; count != 0 ; count--, iter++) {
            MRT_Instance *targetInst = *iter ;
            if ((void *)targetInst >= targetiab->storageStart &&
                    (void *)targetInst < targetiab->storageFinish &&
                    targetInst->alloc > 0) {
                targetInst->refCount = targetInst->refCount == UINT8_MAX ?
                        2 : targetInst->refCount + 1 ;
            }
        }
    }
}
static void
mrtCountLinkedListRefs(
    MRT_Class const *sourceClass,
    MRT_AttrOffset refOffset,
    MRT_Class const *targetClass,
    MRT_AttrOffset linkOffset)
{
    MRT_iab *targetiab = mrt_GetStorageProperties(targetClass, NULL) ;
    MRT_InstIterator srciter ;
    for (mrt_InstIteratorStart(&srciter, sourceClass) ;
            mrt_InstIteratorMore(&srciter) ; mrt_InstIteratorNext(&srciter)) {
        MRT_Instance *srcInst = mrt_InstIteratorGet(&srciter) ;
        MRT_LinkRef *ref = (MRT_LinkRef *)((uintptr_t)srcInst + refOffset) ;
        if (ref->next != NULL) { // <1>
            for (MRT_LinkRef *trgIter = mrtLinkRefBegin(ref) ;
                    trgIter != mrtLinkRefEnd(ref) ; trgIter = trgIter->next) {
                MRT_Instance *targetInst =
                    (MRT_Instance *)((uintptr_t)trgIter - linkOffset) ; // <2>
                if ((void *)targetInst >= targetiab->storageStart &&
                        (void *)targetInst < targetiab->storageFinish &&
                        targetInst->alloc > 0) {
                    targetInst->refCount = targetInst->refCount == UINT8_MAX ?
                            2 : targetInst->refCount + 1 ;
                }
            }
        }
    }
}
static void
mrtCountClassAssocRefs(
    struct mrtassociationrole const *participant,
    MRT_Class const *assocClass,
    MRT_AttrOffset assocOffset)
{
    switch (participant->storageType) {
    case mrtSingular:
        mrtCountSingularRefs(participant->classDesc, participant->storageOffset,
            assocClass) ;
        break ;

    case mrtArray:
        mrtCountArrayRefs(participant->classDesc, participant->storageOffset,
            assocClass) ;
        break ;

    case mrtLinkedList:
        mrtCountLinkedListRefs(participant->classDesc,
                participant->storageOffset, assocClass,
                participant->linkOffset) ;
        break ;

    default:
        mrtFatalError(mrtRelationshipLinkage) ;
        break ;
    }
    mrtCountSingularRefs(assocClass, assocOffset, participant->classDesc) ;
}
static void
mrtCountGenRefs(
    struct mrtrefgeneralization const *gen)
{
    MRT_Class const *superClass = gen->superclass.classDesc ;
    MRT_InstIterator iter ;
    for (mrt_InstIteratorStart(&iter, superClass) ;
            mrt_InstIteratorMore(&iter) ; mrt_InstIteratorNext(&iter)) {
        MRT_Instance *instref = mrt_InstIteratorGet(&iter) ;
        MRT_Instance *subInst = *(MRT_Instance **)
                ((uintptr_t)instref + gen->superclass.storageOffset) ;
        if (subInst != NULL) {
            MRT_Class const *subClass = subInst->classDesc ;

            MRT_iab *subiab = mrt_GetStorageProperties(subClass, NULL) ;
            if ((void *)subInst >= subiab->storageStart &&
                    (void *)subInst < subiab->storageFinish &&
                    subInst->alloc > 0) {
                subInst->refCount = subInst->refCount == UINT8_MAX ?
                        2 : subInst->refCount + 1 ;
            }
        }
    }

    struct mrtrefsubclassrole const *subclass = gen->subclasses ;
    for (unsigned subcount = gen->subclassCount ; subcount != 0 ;
            --subcount, ++subclass) {
        mrtCountSingularRefs(subclass->classDesc, subclass->storageOffset,
                gen->superclass.classDesc) ;
    }
}
static void
mrtLink(
    struct mrtassociationrole const *sourceRole,
    void *source,
    void *target)
{
    switch (sourceRole->storageType) {
    case mrtSingular: {
        void **ref = (void **)((uintptr_t)source +
                sourceRole->storageOffset) ; // <1>
        *ref = target ;
    }
        break ;

    case mrtArray:
        // can't link array types
        mrtFatalError(mrtStaticRelationship) ;
        break ;

    case mrtLinkedList: {
        MRT_LinkRef *targetLinks = (MRT_LinkRef *)((uintptr_t)target +
                sourceRole->linkOffset) ;
        if (targetLinks->next != NULL && targetLinks->prev != NULL) {
            mrtLinkRefRemove(targetLinks) ; // <2>
        }

        // Find the linked list terminus in the source instance and
        // insert the target on the list.
        MRT_LinkRef *sourceList = (MRT_LinkRef *)((uintptr_t)source +
                sourceRole->storageOffset) ; // <3>
        assert(targetLinks->next == NULL && targetLinks->prev == NULL) ;
        mrtLinkRefInsert(targetLinks, sourceList) ;
    }
        break ;

    default:
        mrtFatalError(mrtRelationshipLinkage) ;
        break ;
    }
}
static int
mrtFindRefGenSubclassCode(
    MRT_Class const *subclassClass,
    struct mrtrefsubclassrole const *subclasses,
    unsigned count)
{
    int subcode ;

    for (subcode = 0 ; subcode < count ; ++subcode, ++subclasses) {
        if (subclassClass == subclasses->classDesc) {
            return subcode ;
        }
    }

    mrtFatalError(mrtRelationshipLinkage) ;
}
void
mrtDeleteLinks(
    struct mrtrelationship const * const *classRels,
    unsigned relCount,
    void *inst)
{
    assert(inst != NULL) ;
    /*
     * Mark the transaction since we are updating the reference pointers.
     */
    mrtMarkRelationship(classRels, relCount) ;

    MRT_Instance *instref = inst ;
    MRT_Class const *instclass = instref->classDesc ;

    for ( ; relCount != 0 ; relCount--, classRels++) {
        struct mrtrelationship const * const rel = *classRels ;
        switch (rel->relType) {
        case mrtSimpleAssoc: {
            struct mrtsimpleassociation const *s_assoc = &rel->relInfo.simpleAssociation ;
            
            if (instclass == s_assoc->source.classDesc) {
                mrtSimpUnlinkForward(s_assoc, inst) ;
            } else if (instclass == s_assoc->target.classDesc) {
                mrtSimpUnlinkBack(s_assoc, inst) ;
            } else {
                mrtFatalError(mrtRelationshipLinkage) ;
            }
        }
            break ;

        case mrtClassAssoc: {
            struct mrtclassassociation const *c_assoc = &rel->relInfo.classAssociation ;
            
            if (instclass == c_assoc->associator.classDesc) {
                struct mrtassociatorrole const *assocRole = &c_assoc->associator ;
                struct mrtassociationrole const *sourceRole = &c_assoc->source ;
                struct mrtassociationrole const *targetRole = &c_assoc->target ;
            
                void **p_targetInst = (void **)
                        ((uintptr_t)inst + assocRole->forwardOffset) ; // <1>
                MRT_Instance *targetInst = *p_targetInst ;
                *p_targetInst = NULL ;
                assert(targetInst != NULL) ;
                if (targetInst != NULL && targetInst->alloc > 0) {
                    mrtUnlinkBackref(targetRole, inst, targetInst) ;
                }
            
                void **p_sourceInst = (void **)
                        ((uintptr_t)inst + assocRole->backwardOffset) ;
                MRT_Instance *sourceInst = *p_sourceInst ;
                *p_sourceInst = NULL ;
                assert(sourceInst != NULL) ;
                if (sourceInst != NULL && sourceInst->alloc > 0) {
                    mrtUnlinkBackref(sourceRole, inst, sourceInst) ;
                }
            }
        }
            break ;

        case mrtRefGeneralization: {
            struct mrtrefgeneralization const *gen = &rel->relInfo.refGeneralization ;
            
            if (instclass != gen->superclass.classDesc) {
                // Instance is a subclass instance
                int subclassCode = mrtFindRefGenSubclassCode(instclass, gen->subclasses,
                        gen->subclassCount) ;
                // Obtain the pointer to the superclass instance.
                void **p_superInst = (void **)
                        ((uintptr_t)inst + gen->subclasses[subclassCode].storageOffset) ;
                MRT_Instance *superInst = *p_superInst ;
                *p_superInst = NULL ;
                assert(superInst != NULL) ;
                // NULL out the pointer in the superclass instance pointing to the subclass
                // instance.
                if (superInst != NULL && superInst->alloc > 0) {
                    void **p_subInst = (void **)
                            ((uintptr_t)superInst + gen->superclass.storageOffset) ;
                    *p_subInst = NULL ;
                }
            } else {
                // Instance is a superclass instance
                // NULL out the pointer to the subclass instance only,
                // i.e. only the back reference.
                void **p_subInst = (void **)((uintptr_t)inst + gen->superclass.storageOffset) ;
                *p_subInst = NULL ;
            }
        }
            break ;

        case mrtUnionGeneralization:
            // For a union generalization, there are no pointer links.
            break ;

        default:
            mrtFatalError(mrtRelationshipLinkage) ;
            break ;
        }
    }
}
static void
mrtSimpUnlinkForward(
    struct mrtsimpleassociation const *assoc,
    void *source)
{
    struct mrtassociationrole const *sourceRole = &assoc->source ;

    if (sourceRole->storageType == mrtSingular) {
        void **p_targetInst = (void **)
                ((uintptr_t)source + sourceRole->storageOffset) ;
        MRT_Instance *targetInst = *p_targetInst ;
        *p_targetInst = NULL ; // <1>

        struct mrtassociationrole const *targetRole = &assoc->target ;
        assert(targetInst != NULL) ;
        if (targetInst != NULL && targetInst->alloc > 0 &&
                targetInst->classDesc == targetRole->classDesc) { // <2>
            mrtUnlinkBackref(targetRole, source, targetInst) ;
        }
    } else {
        // Simple forward association links are always singular.
        mrtFatalError(mrtRelationshipLinkage) ;
    }
}
static void
mrtSimpUnlinkBack(
    struct mrtsimpleassociation const *assoc,
    void *target)
{
    struct mrtassociationrole const *targetRole = &assoc->target ;

    if (targetRole->storageType == mrtSingular) {
        void **p_sourceInst = (void **)
                ((uintptr_t)target + targetRole->storageOffset) ;
        *p_sourceInst = NULL ; // <1>
    } else if (targetRole->storageType == mrtLinkedList) { // <2>
        MRT_LinkRef *sourceList = (MRT_LinkRef *)
                ((uintptr_t)target + targetRole->storageOffset) ; // <3>
        assert(sourceList->next != NULL && sourceList->prev != NULL) ;
        for (MRT_LinkRef *iter = mrtLinkRefBegin(sourceList) ;
                iter != mrtLinkRefEnd(sourceList) ; ) {
            MRT_LinkRef *sourceInst = iter ;
            iter = iter->next ; // <4>
            mrtLinkRefRemove(sourceInst) ;
        }
    } else {
        // Can't unlink array type linkages.
        mrtFatalError(mrtStaticRelationship) ;
    }
}
static void
mrtUnlinkBackref(
    struct mrtassociationrole const *targetRole,
    void *source,
    void *target)
{
    assert(source != NULL) ;
    assert(target != NULL) ;
    assert(targetRole != NULL) ;

    if (targetRole->storageType == mrtSingular) {
        void **p_sourceInst = (void **)
                ((uintptr_t)target + targetRole->storageOffset) ; // <1>
        *p_sourceInst = NULL ;
    } else if (targetRole->storageType == mrtLinkedList) {
        MRT_LinkRef *sourcelinks = (MRT_LinkRef *)
                ((uintptr_t)source + targetRole->linkOffset) ; // <2>

        if (sourcelinks->next != NULL && sourcelinks->prev != NULL) { // <3>
            mrtLinkRefRemove(sourcelinks) ;
        }
    } else {
        // Can't unlink array type linkages.
        mrtFatalError(mrtStaticRelationship) ;
    }
}
static int
mrtFindUnionGenSubclassCode(
    MRT_Class const *subclassClass,
    MRT_Class const * const *subclasses,
    unsigned count)
{
    int subcode ;

    for (subcode = 0 ; subcode < count ; ++subcode, ++subclasses) {
        if (subclassClass == *subclasses) {
            return subcode ;
        }
    }

    mrtFatalError(mrtRelationshipLinkage) ;
}
static void
mrtEventPoolInit(void)
{
    assert(MRT_EVENTPOOLSIZE >= 1) ;
    /*
     * Initialize the queue terminus structures.
     */
    eventQueue.next = eventQueue.prev = (MRT_ecb *)&eventQueue ;
    tocEventQueue.next = tocEventQueue.prev = (MRT_ecb *)&tocEventQueue ;
    delayedEventQueue.next = delayedEventQueue.prev = (MRT_ecb *)&delayedEventQueue ;
    freeEventQueue.next = freeEventQueue.prev = (MRT_ecb *)&freeEventQueue ;
    /*
     * Place all the event control blocks on the free event
     * queue.  Allocation occurs from there.
     */
    for (MRT_ecb *ecb = mrtECBPool ;
            ecb < mrtECBPool + MRT_EVENTPOOLSIZE ; ++ecb) {
        mrtEventQueueInsert(ecb, (MRT_ecb *)&freeEventQueue) ;
    }
}
static inline 
MRT_ecb *
mrtAllocEvent(void)
{
    if (mrtEventQueueEmpty(&freeEventQueue)) {
        mrtFatalError(mrtNoECB) ;
    }

    MRT_ecb *ecb = freeEventQueue.next ;
    mrtEventQueueRemove(ecb) ;
    memset(ecb, 0, sizeof(*ecb)) ; // <1>
    return ecb ;
}
static inline
void
mrtFreeEvent(
    MRT_ecb *ecb)
{
    assert(ecb != NULL) ;

    mrtEventQueueInsert(ecb, (MRT_ecb *)&freeEventQueue) ;
}
static MRT_ecb *
mrtFindEvent(
    MRT_EventQueue *queue,
    MRT_Instance *sourceInst,
    MRT_Instance *targetInst,
    MRT_EventCode event)
{
    /*
     * Simple iteration through the list of events in the queue.
     */
    for (MRT_ecb *iter = mrtEventQueueBegin(queue) ;
            iter != mrtEventQueueEnd(queue) ;
            iter = iter->next) {
        if (iter->sourceInst == sourceInst && iter->targetInst == targetInst &&
                iter->eventNumber == event) {
            return iter ;
        }
    }
    return NULL ;
}
static void
mrtRemoveDelayedEvent(
    MRT_ecb *ecb)
{
    /*
     * If we are not at the end of the queue, all the delay from the removed
     * entry is added onto the next entry in the queue.
     */
    if (ecb->next != mrtEventQueueEnd(&delayedEventQueue)) {
        ecb->next->delay += ecb->delay ;
    }
    /*
     * Remove the ECB from the delayed queue.
     */
    mrtEventQueueRemove(ecb) ;
    /*
     * Return the ECB back to the pool.
     */
    mrtFreeEvent(ecb) ;
}
static MRT_ecb *
mrtExpireDelayedEvents(void)
{
    /*
     * Iterate along the delayed event queue.
     */
    for (MRT_ecb *iter = mrtEventQueueBegin(&delayedEventQueue) ;
            iter != mrtEventQueueEnd(&delayedEventQueue) ;
            iter = iter->next) {
        if (iter->delay == 0) {
            /*
             * Mark all the events that have zero delay time as expired.
             */
            iter->delay = MRT_DELAY_EXPIRED ;
        } else if (iter->delay != MRT_DELAY_EXPIRED) {
            /*
             * Stop at the first non-zero delay time.  This marks the boundary
             * of events that need additional delay time.  The first such event
             * is the next amount of time to delay.
             */
            return iter ;
        }
        /*
         * else ... Skip any events that might already be expired.
         */
    }
    /*
     * We have run the queue without finding an unexpired event.
     */
    return NULL ;
}
static void
mrtTransferExpiredEvents(void)
{
    /*
     * Iterate through the delayed event queue looking for those entries that
     * have been marked as expired.
     */
    for (MRT_ecb *iter = mrtEventQueueBegin(&delayedEventQueue) ;
            iter != mrtEventQueueEnd(&delayedEventQueue) &&
            iter->delay == MRT_DELAY_EXPIRED ; /* empty 3rd expression */) {
        /*
         * Advance the iterator here, because we are about to invalidate it by
         * removing the entry from the queue.
         */
        MRT_ecb *ecb = iter ;
        iter = iter->next ;
        /*
         * Remove the ECB from the delayed queue and insert it into the thread
         * of control event queue for dispatch.
         */
        mrtEventQueueRemove(ecb) ;
        mrtEventQueueInsert(ecb, (MRT_ecb *)&tocEventQueue) ;
    }
}
static void
mrtStartDelayedQueueTiming(void)
{
    if (!mrtEventQueueEmpty(&delayedEventQueue)) {
        MRT_ecb *ecb = mrtEventQueueBegin(&delayedEventQueue) ;
        assert(ecb->delay != 0) ;
        mrtSysTimerStart(ecb->delay) ;
        ecb->delay = 0 ;
    }
}
static void
mrtStopDelayedQueueTiming(void)
{
    /*
     * Avoid the whole thing if there is nothing in the delayed event queue.
     */
    if (!mrtEventQueueEmpty(&delayedEventQueue)) {
        /*
         * Stop the timer, obtaining the residual time.
         */
        MRT_DelayTime remain = mrtSysTimerStop() ;
        /*
         * There are two cases here. It is possible for the remaining time
         * returned from mrtSysTimerStop() to be zero. This can happen if the
         * physical timing resource (which might be running asynchronously to
         * the processor) happens to expire within a single tick as we are
         * stopping it.
         */
        if (remain == 0) {
            /*
             * Since the timer has expired we must mark any events with a zero
             * delay time value as expired and, since we are running in the
             * background here, transfer the expired events to be dispatched.
             */
            mrtExpireDelayedEvents() ;
            mrtTransferExpiredEvents() ;
            /*
             * At this point, either the delayed event queue is empty, or the
             * event at the head of the queue has a non-zero delay time.
             */
        } else {
            /*
             * It is possible that the timing resource expired and its
             * interrupt service ran just before we could get the timer
             * stopped. That would mean that there are expired events on the
             * delayed queue at this point and we need to transfer them off the
             * delayed queue to be dispatched.
             */
            mrtTransferExpiredEvents() ;
            /*
             * If any events expired, the delayed event queue might now be
             * empty. However, if the queue is not empty, we must make sure the
             * entry at the head preserves the remaining amount of time that
             * needs to elapse.
             */
            if (!mrtEventQueueEmpty(&delayedEventQueue)) {
                MRT_ecb *ecb = mrtEventQueueBegin(&delayedEventQueue) ;
                assert(ecb->delay == 0) ;
                ecb->delay = remain ;
            }
        }
    }
}
static void
mrtExpiredEventService(
    MRT_SyncParams const *params) /* Not used */
{
    /*
     * Since the expired event queue is accessed here, we must make sure that
     * the timer interrupt does not go off.
     */
    mrtSysTimerMask() ; // <1>
    mrtTransferExpiredEvents() ;
    mrtSysTimerUnmask() ;
}
static bool
mrtDispatchEventFromQueue(
    MRT_EventQueue *queue)
{
    static MRT_ecb *ecb = NULL ;            // <1>

    if (ecb != NULL) {                      // <2>
        mrtFreeEvent(ecb) ;
        ecb = NULL ;
            #ifdef MRT_ARM_ARCH_7M
        __set_BASEPRI(0) ;
            #endif /* MRT_ARM_ARCH_7M */
    }

    bool dispatched = false ;

    if (!mrtEventQueueEmpty(queue)) {
        ecb = queue->next ;
        mrtEventQueueRemove(ecb) ;

            #ifdef MRT_ARM_ARCH_7M
        __set_BASEPRI(MRT_PENDSV_PRIORITY) ;// <3>
            #endif /* MRT_ARM_ARCH_7M */
        mrtDispatchEvent(ecb) ;             // <4>
            #ifdef MRT_ARM_ARCH_7M
        __set_BASEPRI(0) ;
            #endif /* MRT_ARM_ARCH_7M */

        mrtFreeEvent(ecb) ;
        ecb = NULL ;

        dispatched = true ;
    }

    return dispatched ;
}
static void
mrtDispatchEvent(
    MRT_ecb *ecb)
{
    assert(ecb != NULL) ;
    assert(ecb->targetInst != NULL) ;

    MRT_Class const *classDesc = ecb->targetInst->classDesc ;
    assert(classDesc != NULL) ;

    MRT_edb const *edb = classDesc->edb ;
    if (edb == NULL) {
        mrtDispatchPolymorphicEvent(ecb) ;
    } else {
        if (ecb->eventNumber < edb->eventCount) {
            if (ecb->targetInst->currentState == edb->creationState) {
                mrtDispatchCreationEvent(ecb) ;
            } else {
                mrtDispatchTransitionEvent(ecb) ;
            }
        } else {
            assert(classDesc->pdb != NULL) ;
            assert(ecb->eventNumber - edb->eventCount <
                    classDesc->pdb->eventCount) ;
            mrtDispatchPolymorphicEvent(ecb) ;
        }
    }
}
static void
mrtDispatchTransitionEvent(
    MRT_ecb *ecb)
{
    MRT_Instance *targetInst = ecb->targetInst ;
    MRT_edb const *edb = targetInst->classDesc->edb ;
    assert(edb != NULL) ;
    assert(edb->stateCount > targetInst->currentState) ;
    assert(edb->eventCount > ecb->eventNumber) ;
    /*
     * Check for the "event-in-flight" error. This occurs when an instance is
     * deleted while there is an event for that instance in the event queue.
     * For this architecture, such occurrences are considered as run-time
     * detected analysis errors.
     */
    if (targetInst->alloc != ecb->alloc) {
#           ifndef MRT_NO_NAMES
        mrtFatalError(mrtEventInFlight,
                ecb->sourceInst ? ecb->sourceInst->classDesc->name : "?",
                ecb->sourceInst ? ecb->sourceInst->name : "?",
                targetInst->classDesc->eventNames[ecb->eventNumber],
                targetInst->classDesc->name,
                targetInst->name ? targetInst->name : "?") ;
#           else
        mrtFatalError(mrtEventInFlight, ecb->sourceInst, ecb->eventNumber,
                targetInst) ;
#           endif /* MRT_NO_NAMES */
    }
    /*
     * Fetch the new state from the transition table.
     */
    MRT_StateCode newState = *(edb->transitionTable +
            targetInst->currentState * edb->eventCount + ecb->eventNumber) ;

#       ifndef MRT_NO_TRACE
    /*
     * Trace the transition.
     */
    mrtTraceTransitionEvent(ecb->eventNumber, ecb->sourceInst,
            ecb->targetInst, targetInst->currentState, newState) ;
#       endif /* MRT_NO_TRACE */

    /*
     * Check for a can't happen transition.
     */
    if (newState == MRT_StateCode_CH) {
#           ifndef MRT_NO_NAMES
        mrtFatalError(mrtCantHappen, targetInst->classDesc->name,
                targetInst->name ? targetInst->name : "?",
                targetInst->classDesc->edb->stateNames[targetInst->currentState],
                targetInst->classDesc->eventNames[ecb->eventNumber]) ;
#           else
        mrtFatalError(mrtCantHappen, targetInst, targetInst->currentState,
                ecb->eventNumber) ;
#           endif /* MRT_NO_NAMES */
    } else if (newState != MRT_StateCode_IG) {
        assert(newState < edb->stateCount) ;
        /*
         * We update the current state to reflect the transition before
         * executing the activity for the state.
         */
        targetInst->currentState = newState ;
        /*
         * Invoke the state activity if there is one.
         */
        MRT_PtrActivityFunction activity = edb->activityTable[newState] ;
        if (activity) {
            activity(targetInst, &ecb->eventParameters) ;
        }
        /*
         * Check if we have entered a final state. If so, the instance is
         * deleted.
         */
        if (edb->finalStates && edb->finalStates[newState]) {
            mrt_DeleteInstance(targetInst) ; // <1>
        }
    }
}
static void
mrtDispatchPolymorphicEvent(
    MRT_ecb *ecb)
{
    MRT_pdb const *pdb = ecb->targetInst->classDesc->pdb ;
    assert(pdb != NULL) ;
    assert(pdb->genCount > 0) ;
    /*
     * Compute the base offset for polymorphic event numbering.  This base
     * offset will be used to turn the polymorphic event number into an array
     * index.
     */
    MRT_edb const *edb = ecb->targetInst->classDesc->edb ;
    MRT_EventCode eventOffset = edb == NULL ?  0 : edb->eventCount ;
    assert(ecb->eventNumber - eventOffset < pdb->eventCount) ;
    /*
     * Save the original event number and target instance pointer.  We intend
     * to reuse the same ECB for each event we dispatch and will need these
     * values should there be more than one generalization associated with this
     * superclass.
     */
    MRT_EventCode origEvent = ecb->eventNumber ;
    MRT_Instance *origTarget = ecb->targetInst ;
    /*
     * For each generalization that originates at the superclass an event is
     * generated down that generalization to one of the subclasss.
     */
    MRT_gdb const *sdb = pdb->genDispatch ;
    for (unsigned gnum = 0 ; gnum < pdb->genCount ; ++sdb, ++gnum) {
        MRT_Relationship const *rel = sdb->relship ;
        MRT_Instance *targetInst ;
        int subclassCode ;

        /*
         * Find the target instance reference and the class of the target
         * instance. How we do this depends upon how the generalization is
         * stored in the superclass instance.
         */
        if (rel->relType == mrtRefGeneralization) {
            /*
             * When the generalization is implemented via a pointer, we need an
             * extra level of indirection to fetch the address of the subclass.
             */
            struct mrtrefgeneralization const *gen =
                    &rel->relInfo.refGeneralization ;
            targetInst = *(MRT_Instance **)((uintptr_t)origTarget +
                    gen->superclass.storageOffset) ;
            assert(targetInst != NULL) ;
            /*
             * We must also guard against the possibility that the subclass was
             * unrelated from the superclass before the polymorphic event was
             * dispatched.
             */
            if (targetInst == NULL) {
#                   ifndef MRT_NO_NAMES
                mrtFatalError(mrtRefIntegrity, rel->name) ;
#                   else
                mrtFatalError(mrtRefIntegrity, rel) ;
#                   endif /* MRT_NO_NAMES */
            }
            assert(targetInst->classDesc != NULL) ;
            subclassCode = mrtFindRefGenSubclassCode(targetInst->classDesc,
                    gen->subclasses, gen->subclassCount) ;
        } else if (rel->relType == mrtUnionGeneralization) {
            /*
             * When the generalization is implemented by a union, we need only
             * point to the address of the subclass since it is contained
             * within the superclass.
             */
            struct mrtuniongeneralization const *gen =
                    &rel->relInfo.unionGeneralization ;
            targetInst = (MRT_Instance *)((uintptr_t)origTarget +
                    gen->superclass.storageOffset) ;
            assert(targetInst->classDesc != NULL) ;
            subclassCode = mrtFindUnionGenSubclassCode(targetInst->classDesc,
                    gen->subclasses, gen->subclassCount) ;
        } else {
            mrtFatalError(mrtRelationshipLinkage) ;
        }
        /*
         * Check that our subclass instance is indeed allocated and usable.  We
         * are trying to guard against the possiblity that the subclass
         * instance was deleted before the polymorphic event was delivered.
         */
        assert(targetInst->alloc > 0) ;
        if (targetInst->alloc <= 0) {
#               ifndef MRT_NO_NAMES
            mrtFatalError(mrtEventInFlight,
                    ecb->sourceInst ? ecb->sourceInst->classDesc->name : "?",
                    ecb->sourceInst ? ecb->sourceInst->name : "?",
                    targetInst->classDesc->eventNames[origEvent],
                    targetInst->classDesc->name,
                    targetInst->name ? targetInst->name : "?") ;
#            else
            mrtFatalError(mrtEventInFlight, ecb->sourceInst, origEvent,
                    targetInst) ;
#           endif /* MRT_NO_NAMES */
        }
        ecb->targetInst = targetInst ;
        ecb->alloc = targetInst->alloc ;
        /*
         * Fetch the event number for the subclass from the polymorphic
         * mapping.  The class of the subclass related to the superclass
         * determines the mapped value for the event.  Note we must subtract
         * off any offset in the event encoding that was consumed by the
         * transition events.
         */
        ecb->eventNumber = *(sdb->eventMap +
                subclassCode * pdb->eventCount + origEvent - eventOffset) ;

#           ifndef MRT_NO_TRACE
        /*
         * Trace the transition.
         */
        mrtTracePolyEvent(origEvent, ecb->sourceInst, origTarget,
                subclassCode, gnum, ecb->eventNumber) ;
#           endif /* MRT_NO_TRACE */

        mrtDispatchEvent(ecb) ; // <1>
    }
}
static void
mrtDispatchCreationEvent(
    MRT_ecb *ecb)
{
#       ifndef MRT_NO_TRACE
    /*
     * Trace the transition.
     */
    mrtTraceCreationEvent(ecb->eventNumber, ecb->sourceInst, ecb->targetInst,
            ecb->targetInst->classDesc) ;
#       endif /* MRT_NO_TRACE */

    assert(ecb->alloc == ecb->targetInst->alloc) ;
    assert(ecb->alloc < 0) ;
    assert(ecb->targetInst->alloc < 0) ;
    assert(ecb->targetInst->currentState ==
        ecb->targetInst->classDesc->edb->creationState) ;

    ecb->alloc = ecb->targetInst->alloc = -ecb->targetInst->alloc ; // <1>
    mrtDispatchTransitionEvent(ecb) ;
}
static int
mrtPortalGetInstRef(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_InstId instId,
    MRT_Instance **ref)
{
    int result ;

    if (classId < portal->classCount) {
        MRT_Class const *pclass = portal->classes + classId ;
        if (instId < pclass->instCount) {
            void *inst = mrt_InstanceReference(pclass, instId) ;
            if (ref) {
                *ref = inst ;
            }
            result = 0 ;
        } else {
            result = MICCA_PORTAL_NO_INST ;
        }
    } else {
        result = MICCA_PORTAL_NO_CLASS ;
    }

    return result ;
}
static int
mrtPortalNewECB(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_InstId instId,
    MRT_EventCode eventNumber,
    void const *eventParameters,
    size_t paramSize,
    MRT_ecb **ecbRef)
{
    int result ;
    MRT_Instance *instref ;

    result = mrtPortalGetInstRef(portal, classId, instId, &instref) ;
    if (result == 0) {
        if (instref->alloc > 0) {
            MRT_Class const *classDesc = portal->classes + classId ;
            MRT_ecb *ecb = NULL ;
            MRT_DispatchCount eventCount ;

            if (classDesc->edb == NULL) {
                if (classDesc->pdb == NULL) {
                    return MICCA_PORTAL_NO_EVENT ;
                } else {
                    eventCount = classDesc->pdb->eventCount ;
                }
            } else {
                if (classDesc->pdb == NULL) {
                    eventCount = classDesc->edb->eventCount ;
                } else {
                    eventCount = classDesc->edb->eventCount +
                            classDesc->pdb->eventCount ;
                }
            }

            if (eventNumber < eventCount) {
                ecb = mrt_NewEvent(eventNumber, instref, NULL) ;
                if (eventParameters != NULL) {
                    size_t copy = paramSize <= sizeof(ecb->eventParameters) ?
                        paramSize : sizeof(ecb->eventParameters) ;
                    memcpy(ecb->eventParameters, eventParameters, copy) ;
                }
                if (ecbRef) {
                    *ecbRef = ecb ;
                }
                result = 0 ;
            } else {
                result = MICCA_PORTAL_NO_EVENT ;
            }
        } else {
            result = MICCA_PORTAL_UNALLOC ;
        }
    }

    return result ;
}
static inline
bool
mrtSyncQueueEmpty(void)
{
    return mrtSyncQueue.head == mrtSyncQueue.tail ;
}
static inline
MRT_SyncParams *
mrtSyncQueuePut(
    MRT_SyncFunc f,
    bool fatal)
{
    MRT_SyncBlock *tail = mrtSyncQueue.tail ;
    if (++mrtSyncQueue.tail >=
            mrtSyncQueueStorage + MRT_SYNCQUEUESIZE) {
        mrtSyncQueue.tail = mrtSyncQueueStorage ;
    }
    if (mrtSyncQueueEmpty()) {
        if (fatal) {
            mrtFatalError(mrtSyncOverflow) ;
        }
        return NULL ;
    }

    tail->function = f ;
    return &tail->params ;
}
static inline
MRT_SyncBlock *
mrtSyncQueueGet(void)
{
    MRT_SyncBlock *head ;

    beginCriticalSection() ;
    if (mrtSyncQueueEmpty()) {
        head = NULL ;
    } else {
        head = mrtSyncQueue.head ;
        if (++mrtSyncQueue.head >=
                mrtSyncQueueStorage + MRT_SYNCQUEUESIZE) {
            mrtSyncQueue.head = mrtSyncQueueStorage ;
        }
    }
    endCriticalSection() ;

    return head ;
}
static inline
bool
mrtInvokeOneSyncFunction(void)
{
    bool didOne ;

    MRT_SyncBlock const *blk = mrtSyncQueueGet() ;
    if (blk != NULL && blk->function != NULL) {
        blk->function(&blk->params) ;
        didOne = true ;
    } else {
        didOne = false ;
    }

    return didOne ;
}
static void
mrtDefaultFatalErrorHandler(
    MRT_ErrorCode errNum,
    char const *fmt,
    va_list ap)
{
    vfprintf(stderr, errMsgs[errNum], ap) ;
}
static noreturn void
mrtFatalError(
    MRT_ErrorCode errNum,
    ...)
{
    va_list ap ;
    /*
     * All hope is lost here. Make sure we don't
     * execute any asynchronous code.
     */
    beginCriticalSection() ;

    assert(mrtErrHandler != NULL) ;
    assert(errNum < COUNTOF(errMsgs)) ;

    va_start(ap, errNum) ;
    mrtErrHandler(errNum, errMsgs[errNum], ap) ;
    /*
     *  If the handler does return, we insist that all errors
     *  are fatal. So we abort().
     */
    abort() ;
}

/*
 * External Functions
 */
#   ifndef MRT_NO_TRACE
MRT_TraceHandler
mrt_RegisterTraceHandler(
    MRT_TraceHandler handler)
{
    MRT_TraceHandler oldhandler = mrtTraceHandler ;
    mrtTraceHandler = handler ;
    return oldhandler ;
}
#   endif /* MRT_NO_TRACE */

MRT_SyncParams *
mrt_SyncRequest(
    MRT_SyncFunc f)
{
    return mrtSyncQueuePut(f, true) ;
}
MRT_SyncParams *
mrt_TrySyncRequest(
    MRT_SyncFunc f)
{
    return mrtSyncQueuePut(f, false) ;
}
void
mrt_RegisterSignal(
    int sigNum,
    MRT_SignalFunc func)
{
    assert(sigNum > 0) ;

    struct sigaction action ;
    if (func) {
        action.sa_handler = func ;
        sigaddset(&mrtSigMask, sigNum) ;
    } else {
        action.sa_handler = SIG_DFL ;
        sigdelset(&mrtSigMask, sigNum) ;
    }
    sigfillset(&action.sa_mask) ;
    action.sa_flags = 0 ;

    int sigresult = sigaction(sigNum, &action, NULL) ;
    if (sigresult != 0) {
        mrtFatalError(mrtSignalOpFailed, strerror(errno)) ;
    }
}
void
mrt_RegisterFDService(
    int fd,
    MRT_FDServiceFunc readService,
    MRT_FDServiceFunc writeService,
    MRT_FDServiceFunc exceptService)
{
    assert(fd >= 0 && fd < FD_SETSIZE) ;
    MRT_FDServiceMap *fds = mrtFDServicePool + fd ;

    fds->read = readService ;
    if (readService) {
        FD_SET(fd, &mrtReadFDS) ;
        fds->set = true ;
    } else {
        FD_CLR(fd, &mrtReadFDS) ;
    }

    fds->write = writeService ;
    if (writeService) {
        FD_SET(fd, &mrtWriteFDS) ;
        fds->set = true ;
    } else {
        FD_CLR(fd, &mrtWriteFDS) ;
    }

    fds->except = exceptService ;
    if (exceptService) {
        FD_SET(fd, &mrtExceptFDS) ;
        fds->set = true ;
    } else {
        FD_CLR(fd, &mrtExceptFDS) ;
    }

    if (fds->read == NULL && fds->write == NULL && fds-> except == NULL) {
        if (fds->set && fd >= mrtMaxFD) {
            --mrtMaxFD ;
        }
        fds->set = false ;
    } else if (fds->set && fd > mrtMaxFD) {
        mrtMaxFD = fd ;
    }
}
void
mrt_UnregisterFDService(
    int fd,
    bool rmRead,
    bool rmWrite,
    bool rmExcept)
{
    assert(fd >= 0 && fd < FD_SETSIZE) ;
    MRT_FDServiceMap *fds = mrtFDServicePool + fd ;

    if (rmRead) {
        fds->read = NULL ;
        FD_CLR(fd, &mrtReadFDS) ;
    }

    if (rmWrite) {
        fds->write = NULL ;
        FD_CLR(fd, &mrtWriteFDS) ;
    }

    if (rmExcept) {
        fds->except = NULL ;
        FD_CLR(fd, &mrtExceptFDS) ;
    }

    if (fds->read == NULL && fds->write == NULL && fds-> except == NULL &&
            fd >= mrtMaxFD) {
        mrtMaxFD = fd - 1 ;
    }
}
void
mrt_Initialize(void)
{
    mrtEventPoolInit() ;
    mrtInitCriticalSection() ;
    mrtInitSysTimer() ;
    mrtInitFDService() ;
    setvbuf(stdout, NULL, _IOLBF, 0) ; // set up line buffering on stdout
#       ifndef MRT_NO_TRACE
    mrt_RegisterTraceHandler(mrtPrintTraceInfo) ;
#       endif /* MRT_NO_TRACE */
}
void
mrt_EventLoop(void)
{
    mrtExitEventLoop = false ;

    mrtFinishThreadOfControl() ;                // <1>
    if (mrtExitEventLoop) {
        return ;
    }

    for (;;) {
        bool didtoc = mrtRunThreadOfControl() ; // <2>
        if (!didtoc) {
            mrtWait() ;                         // <3>
        } else if (mrtExitEventLoop) {          // <4>
            break ;
        }
        /*
         * Else we ran a thread of control and weren't requested to exit
         * the event loop.
         */
    }
}
bool
mrt_SyncToEventLoop(void)
{
    bool exitControl = mrtExitEventLoop ;
    mrtExitEventLoop = true ;
    return exitControl ;
}
bool
mrt_DispatchThreadOfControl(void)
{
    mrtFinishThreadOfControl() ;
    if (mrtEventQueueEmpty(&tocEventQueue)) {
        mrtWait() ;
    }
    return mrtRunThreadOfControl() ;
}
bool
mrt_DispatchSingleEvent(void)
{
    bool didOne = mrtProcessOneEvent(&eventQueue) ;

    if (!didOne) {
        didOne = mrtProcessOneEvent(&tocEventQueue) ;
    }
    if (mrtEventQueueEmpty(&eventQueue)) {
        mrtEndTransaction() ;
    }

    return didOne ;
}
MRT_iab *
mrt_GetStorageProperties(
    MRT_Class const *classDesc,
    MRT_AttrOffset *offsetptr)
{
    assert(classDesc != NULL) ;
    MRT_iab *iab = classDesc->iab ;
    MRT_AttrOffset instanceOffset = 0 ; // <1>
    for (struct mrtsuperclassrole const *container = classDesc->containment ;
            container != NULL ;
            container = container->classDesc->containment) {// <2>
        instanceOffset += container->storageOffset ;
        iab = container->classDesc->iab ;
    }
    if (offsetptr) {// <3>
        *offsetptr = instanceOffset ;
    }

    return iab ;
}
unsigned
mrt_InstanceIndex(
    void *instance)
{
    MRT_Instance *instref = instance ;
    assert(instref != NULL) ;
    assert(instref->classDesc != NULL) ;

    MRT_AttrOffset offset ;
    MRT_iab *iab = mrt_GetStorageProperties(instref->classDesc, &offset) ;
    unsigned index = (((uintptr_t)instance - offset) -
            (uintptr_t)iab->storageStart) / iab->instanceSize ;     // <1>
    assert(index < instref->classDesc->instCount) ;
    return index ;
}
void *
mrt_InstanceReference(
    MRT_Class const *classDesc,
    unsigned index)
{
    assert(classDesc != NULL) ;
    MRT_AttrOffset offset ;
    MRT_iab *iab = mrt_GetStorageProperties(classDesc, &offset) ;
    void *instance = (void *)((uintptr_t)iab->storageStart +
            (index * iab->instanceSize) + offset) ;
    assert(instance < iab->storageFinish) ;
    if (instance >= iab->storageFinish) {
#           ifndef MRT_NO_NAMES
        mrtFatalError(mrtNoInstSlot, classDesc->name) ;
#           else
        mrtFatalError(mrtNoInstSlot, classDesc) ;
#           endif /* MRT_NO_NAMES */
    }
    MRT_Instance *instref = instance ;
    if (instref->alloc <= 0) {
#           ifndef MRT_NO_NAMES
        mrtFatalError(mrtUnallocSlot, instref->name) ;
#           else
        mrtFatalError(mrtUnallocSlot, instref) ;
#           endif /* MRT_NO_NAMES */
    }

    return instref ;
}
void *
mrt_CreateInstance(
    MRT_Class const *classDesc,
    MRT_StateCode initialState)
{
    assert(classDesc != NULL) ;

    /*
     * Search for an empty slot in the pool.
     */
    MRT_iab *iab = classDesc->iab ;
    MRT_Instance *inst = mrtFindInstSlot(iab) ;
    if (inst == NULL) {
#           ifndef MRT_NO_NAMES
        mrtFatalError(mrtNoInstSlot, classDesc->name) ;
#           else
        mrtFatalError(mrtNoInstSlot, classDesc) ;
#           endif /* MRT_NO_NAMES */
    }
    /*
     * Record where we left off for the next allocation attempt.
     */
    iab->storageLast = inst ;
    /*
     * Initialize the memory for the instance.
     */
    mrtInitializeInstance(inst, classDesc, initialState) ;

    return inst ;
}
void
mrt_DeleteInstance(
    void *instref)
{
    MRT_Instance *inst = instref ;
    assert(inst != NULL) ;
    if (inst == NULL || inst->alloc == 0) {
        return ;
    }
    MRT_Class const *classDesc = inst->classDesc ;
    assert(classDesc != NULL) ;
    MRT_iab *iab = classDesc->iab ;
    assert(iab != NULL) ;
    /*
     * Run the destructor, if there is one.
     */
    if (iab->destruct) {
        iab->destruct(inst) ;
    }
    /*
     * Unlink the instance from its relationships.
     */
    mrtDeleteLinks(classDesc->classRels, classDesc->relCount, instref) ;
    /*
     * Mark the slot as free.
     */
    inst->alloc = 0 ;
}
void
mrt_InstIteratorStart(
    MRT_InstIterator *iter,
    MRT_Class const *classDesc)
{
    assert(classDesc != NULL) ;
    assert(iter != NULL) ;

    MRT_AttrOffset instanceOffset ;
    MRT_iab *iab = mrt_GetStorageProperties(classDesc, &instanceOffset) ;
    assert(iab != NULL) ;

    iter->iab = iab ;
    iter->instance = (void *)((uintptr_t)iab->storageStart + instanceOffset) ;
    if (((MRT_Instance *)iter->instance)->alloc <= 0) { // <1>
        mrt_InstIteratorNext(iter) ;
    }
    return ;
}
bool
mrt_InstIteratorMore(
    MRT_InstIterator *iter)
{
    assert(iter != NULL) ;
    return iter->instance < iter->iab->storageFinish ;
}
void *
mrt_InstIteratorGet(
    MRT_InstIterator *iter)
{
    assert(iter != NULL) ;
    return iter->instance ;
}
void
mrt_InstIteratorNext(
    MRT_InstIterator *iter)
{
    assert(iter != NULL) ;

    MRT_iab *iab = iter->iab ;
    while (iter->instance < iab->storageFinish) { // <1>
        iter->instance = (void *)((uintptr_t)iter->instance + iab->instanceSize) ;
        if (((MRT_Instance *)iter->instance)->alloc > 0) {
            break ;
        }
    }
    return ;
}
void
mrt_InstSetInitialize(
    MRT_InstSet *set,
    MRT_Class const *classDesc)
{
    assert(classDesc != NULL) ;
    set->classDesc = classDesc ;
    memset(set->instvector, 0, sizeof(set->instvector)) ;
}
void
mrt_InstSetAddInstance(
    MRT_InstSet *set,
    void *instance)
{
    MRT_Instance *instref = instance ;

    assert(instref != NULL) ;
    assert(instref->classDesc == set->classDesc) ;
    if (instref->classDesc != set->classDesc) { // <1>
        return ;
    }
    unsigned instid = mrt_InstanceIndex(instance) ;
    assert(instid < MRT_INSTANCESETSIZE) ;
    set->instvector[instid / MRT_SETWORD_BITS] |=
            (1 << (instid % MRT_SETWORD_BITS)) ; // <2>
}
void
mrt_InstSetRemoveInstance(
    MRT_InstSet *set,
    void *instance)
{
    MRT_Instance *instref = instance ;

    assert(instref != NULL) ;
    assert(instref->classDesc == set->classDesc) ;
    if (instref->classDesc != set->classDesc) {
        return ;
    }
    unsigned instid = mrt_InstanceIndex(instance) ;
    assert(instid < MRT_INSTANCESETSIZE) ;
    set->instvector[instid / MRT_SETWORD_BITS] &=
            ~(1 << (instid % MRT_SETWORD_BITS)) ; // <1>
}
bool
mrt_InstSetMember(
    MRT_InstSet *set,
    void *instance)
{
    MRT_Instance *instref = instance ;

    assert(instref != NULL) ;
    assert(instref->classDesc == set->classDesc) ;

    if (instref->classDesc != set->classDesc) {
        return false ;
    }
    unsigned instid = mrt_InstanceIndex(instance) ;
    assert(instid < MRT_INSTANCESETSIZE) ;
    MRT_SetWord w = set->instvector[instid / MRT_SETWORD_BITS] ;
    MRT_SetWord mask = (1 << (instid % MRT_SETWORD_BITS)) ;

    return (w & mask) != 0 ;
}
bool
mrt_InstSetEmpty(
    MRT_InstSet *set)
{
    assert(set != NULL) ;
    MRT_SetWord *pvect = set->instvector ;
    while (pvect < set->instvector + COUNTOF(set->instvector)) {
        if (*pvect++ != 0) {
            return false ;
        }
    }

    return true ;
}
unsigned
mrt_InstSetCardinality(
    MRT_InstSet *set)
{
    assert(set != NULL) ;
    unsigned card = 0 ;
    for (MRT_SetWord *pvect = set->instvector ;
            pvect < set->instvector + COUNTOF(set->instvector) ; pvect++) {
        MRT_SetWord w = *pvect ;
        MRT_SetWord mask = 1 ;
        for (unsigned bit = MRT_SETWORD_BITS ; w != 0 && bit != 0 ; bit--) {
            if ((w & mask) != 0) {
                card++ ;
                w &= ~mask ; // <1>
            }
            mask <<= 1 ;
        }
    }

    return card ;
}
bool
mrt_InstSetEqual(
    MRT_InstSet *set1,
    MRT_InstSet *set2)
{
    assert(set1 != NULL) ;
    assert(set1->classDesc != NULL) ;
    assert(set2 != NULL) ;
    assert(set2->classDesc != NULL) ;

    if (set1->classDesc != set2->classDesc) {
        return false ;
    }
    MRT_SetWord *src1 = set1->instvector ;
    MRT_SetWord *src2 = set2->instvector ;
    while (src1 < set1->instvector + COUNTOF(set1->instvector)) {
        if (*src1++ != *src2++) {
            return false ;
        }
    }

    return true ;
}
void
mrt_InstSetUnion(
    MRT_InstSet *set1,
    MRT_InstSet *set2,
    MRT_InstSet *result)
{
    assert(set1 != NULL) ;
    assert(set1->classDesc != NULL) ;
    assert(set2 != NULL) ;
    assert(set2->classDesc != NULL) ;
    assert(result != NULL) ;
    assert(set1->classDesc == set2->classDesc) ;

    result->classDesc = set1->classDesc ;
    if (set1->classDesc == set2->classDesc) {
        MRT_SetWord *dst = result->instvector ;
        MRT_SetWord *src1 = set1->instvector ;
        MRT_SetWord *src2 = set2->instvector ;
        while (dst < result->instvector + COUNTOF(result->instvector)) {
            *dst++ = *src1++ | *src2++ ;
        }
    } else {
        memcpy(result->instvector, set1->instvector, sizeof(result->instvector)) ;
    }
}
void
mrt_InstSetIntersect(
    MRT_InstSet *set1,
    MRT_InstSet *set2,
    MRT_InstSet *result)
{
    assert(set1 != NULL) ;
    assert(set1->classDesc != NULL) ;
    assert(set2 != NULL) ;
    assert(set2->classDesc != NULL) ;
    assert(result != NULL) ;
    assert(set1->classDesc == set2->classDesc) ;

    result->classDesc = set1->classDesc ;
    if (set1->classDesc == set2->classDesc) {
        MRT_SetWord *dst = result->instvector ;
        MRT_SetWord *src1 = set1->instvector ;
        MRT_SetWord *src2 = set2->instvector ;
        while (dst < result->instvector + COUNTOF(result->instvector)) {
            *dst++ = *src1++ & *src2++ ;
        }
    } else {
        memset(result->instvector, 0, sizeof(result->instvector)) ;
    }
}
void
mrt_InstSetMinus(
    MRT_InstSet *set1,
    MRT_InstSet *set2,
    MRT_InstSet *result)
{
    assert(set1 != NULL) ;
    assert(set1->classDesc != NULL) ;
    assert(set2 != NULL) ;
    assert(set2->classDesc != NULL) ;
    assert(result != NULL) ;
    assert(set1->classDesc == set2->classDesc) ;

    result->classDesc = set1->classDesc ;
    if (set1->classDesc == set2->classDesc) {
        MRT_SetWord *dst = result->instvector ;
        MRT_SetWord *src1 = set1->instvector ;
        MRT_SetWord *src2 = set2->instvector ;
        while (dst < result->instvector + COUNTOF(result->instvector)) {
            *dst++ = *src1++ & ~*src2++ ;
        }
    } else {
        memcpy(result->instvector, set1->instvector, sizeof(result->instvector)) ;
    }
}
void
mrt_InstSetIterBegin(
    MRT_InstSet *set,
    MRT_InstSetIterator *iter)
{
    assert(set != NULL) ;
    assert(iter != NULL) ;

    iter->set = set ;
    iter->vectorloc = set->instvector ;
    iter->bitoffset = 0 ;
    if ((*iter->vectorloc & 1) == 0) { // <1>
        mrt_InstSetIterNext(iter) ;
    } else {
        iter->instance = mrt_InstanceReference(iter->set->classDesc, 0) ;
        if (((MRT_Instance *)iter->instance)->alloc <= 0) { // <2>
            mrt_InstSetIterNext(iter) ;
        }
    }
}
bool
mrt_InstSetIterMore(
    MRT_InstSetIterator *iter)
{
    assert(iter != NULL) ;
    return iter->instance != NULL ;
}
void *
mrt_InstSetIterGet(
    MRT_InstSetIterator *iter)
{
    assert(iter != NULL) ;
    assert(iter->instance != NULL) ;
    return iter->instance ;
}
void
mrt_InstSetIterNext(
    MRT_InstSetIterator *iter)
{
    assert(iter != NULL) ;
    
    iter->bitoffset++ ; //<1>
    if (iter->bitoffset >= MRT_SETWORD_BITS) {
        iter->vectorloc++ ;
        iter->bitoffset = 0 ;
    }
    while (iter->vectorloc <
            iter->set->instvector + COUNTOF(iter->set->instvector)) {
        if (*iter->vectorloc != 0) { // <2>
            MRT_SetWord mask = 1 << iter->bitoffset ;
            for ( ; iter->bitoffset < MRT_SETWORD_BITS ; iter->bitoffset++) {
                if ((*iter->vectorloc & mask) != 0) { // <3>
                    unsigned instindex =
                        (iter->vectorloc - iter->set->instvector) *
                        MRT_SETWORD_BITS + iter->bitoffset ; // <4>
                    MRT_Instance *instref = mrt_InstanceReference(
                        iter->set->classDesc, instindex) ;
                    if (instref->alloc > 0) { // <5>
                        iter->instance = instref ;
                        return ;
                    }
                }
                mask <<= 1 ;
            }
        }
        iter->vectorloc++ ; // <6>
        iter->bitoffset = 0 ;
    }

    iter->instance = NULL ;
}
void
mrt_CreateSimpleLinks(
    MRT_Relationship const *rel,
    void *source,
    void *target)
{
    assert(rel != NULL) ;
    assert(source != NULL) ;
    assert(target != NULL) ;

    switch (rel->relType) {
    case mrtSimpleAssoc: {
        struct mrtsimpleassociation const *assoc = &rel->relInfo.simpleAssociation ;
        
        if (assoc->source.classDesc != ((MRT_Instance *)source)->classDesc ||
                assoc->target.classDesc != ((MRT_Instance *)target)->classDesc) {
            mrtFatalError(mrtRelationshipLinkage) ;
        }
        
        mrtLink(&assoc->source, source, target) ;
        mrtLink(&assoc->target, target, source) ;
    }
        break ;

    case mrtClassAssoc: {
        struct mrtclassassociation const *cassoc = &rel->relInfo.classAssociation ;
        struct mrtassociatorrole const *arole = &cassoc->associator ;
        struct mrtassociationrole const *srole = &cassoc->source ;
        struct mrtassociationrole const *trole = &cassoc->target ;
        
        if (arole->classDesc != ((MRT_Instance *)source)->classDesc) { // <1>
            mrtFatalError(mrtRelationshipLinkage) ;
        }
        
        if (srole->classDesc == ((MRT_Instance *)target)->classDesc) { // <2>
            void **p_backRef = (void **)((uintptr_t)source + arole->backwardOffset) ;
            *p_backRef = target ;
            mrtLink(srole, target, source) ;
        } else if (trole->classDesc == ((MRT_Instance *)target)->classDesc) { // <3>
            void **p_forwRef = (void **)((uintptr_t)source + arole->forwardOffset) ;
            *p_forwRef = target ;
            mrtLink(trole, target, source) ;
        } else {
            mrtFatalError(mrtRelationshipLinkage) ;
        }
    }
        break ;

    case mrtRefGeneralization: {
        struct mrtrefgeneralization const *gen = &rel->relInfo.refGeneralization ;
        
        MRT_Class const *subclassClass = ((MRT_Instance *)source)->classDesc ; // <1>
        int subclassCode = mrtFindRefGenSubclassCode(subclassClass, gen->subclasses,
                gen->subclassCount) ;
        
        MRT_Class const *superclassClass = ((MRT_Instance *)target)->classDesc ; // <2>
        if (gen->superclass.classDesc != superclassClass) {
            mrtFatalError(mrtRelationshipLinkage) ;
        }
        
        void **p_superRef = (void **)((uintptr_t)source +
                gen->subclasses[subclassCode].storageOffset) ;
        *p_superRef = target ;
        
        void **p_subRef = (void **)((uintptr_t)target + gen->superclass.storageOffset) ;
        *p_subRef = source ;
    }
        break ;

    case mrtUnionGeneralization:
        // There are no pointer linkages for a union generalization.
        // N.B. fall through

    default:
        mrtFatalError(mrtRelationshipLinkage) ;
        break ;
    }

    mrtMarkRelationship(&rel, 1) ;
}
void
mrt_CreateAssociatorLinks(
    MRT_Relationship const *rel,
    void *assoc,
    void *source,
    void *target)
{
    assert(rel != NULL) ;
    assert(assoc != NULL) ;
    assert(source != NULL) ;
    assert(target != NULL) ;

    mrt_CreateSimpleLinks(rel, assoc, source) ; // <1>
    mrt_CreateSimpleLinks(rel, assoc, target) ;

    mrtMarkRelationship(&rel, 1) ;
}
void *
mrt_Reclassify(
    MRT_Relationship const *rel,
    void *super,
    MRT_Class const *newSubclass)
{
    void *newSubInst = NULL ;

    if (rel->relType == mrtRefGeneralization) {
        struct mrtrefgeneralization const *gen = &rel->relInfo.refGeneralization ;
        
        /*
         * Check that we have the correct superclass.
         */
        MRT_Class const *superclassClass = ((MRT_Instance *)super)->classDesc ;
        if (gen->superclass.classDesc != superclassClass) {
            mrtFatalError(mrtRelationshipLinkage) ;
        }
        /*
         * Offset into the superclass instance to where the pointer to the
         * subclass instance is located.
         */
        void **p_subInst = (void **)((uintptr_t)super + gen->superclass.storageOffset) ;
        void *subInst = *p_subInst ;
        if (subInst != NULL) {
            /*
             * Delete the old subclass instance.  Deleting will cause the subclass
             * instance to be unlinked from the generalization.
             */
            mrt_DeleteInstance(subInst) ;
        }
        
        /*
         * Create a new instance of the new subclass.
         */
        newSubInst = mrt_CreateInstance(newSubclass, MRT_StateCode_IG) ;
        /*
         * Create the links to the super class instance.
         */
        mrt_CreateSimpleLinks(rel, newSubInst, super) ;
    } else if (rel->relType == mrtUnionGeneralization) {
        struct mrtuniongeneralization const *gen = &rel->relInfo.unionGeneralization ;
        
        MRT_Class const *superclassClass = ((MRT_Instance *)super)->classDesc ;
        if (gen->superclass.classDesc != superclassClass) {
            mrtFatalError(mrtRelationshipLinkage) ;
        }
        /*
         * Check that the new subclass is one that is part of this generalization.
         * We don't actually need the subclass code itself.
         */
        mrtFindUnionGenSubclassCode(newSubclass, gen->subclasses, gen->subclassCount) ;
        /*
         * Point to where the subclass instance is stored within the superclass.
         */
        newSubInst = (void *)((uintptr_t)super + gen->superclass.storageOffset) ;
        MRT_Instance *subInst = newSubInst ;
        /*
         * Clean up any relationship pointers.
         */
        if (subInst->alloc > 0) {
            MRT_Class const *newSubClass = subInst->classDesc ;
            mrtDeleteLinks(newSubClass->classRels, newSubClass->relCount, subInst) ;
        }
        /*
         * Set up the memory for the subclass instance according to the new subclass.
         */
        mrtInitializeInstance(subInst, newSubclass, MRT_StateCode_IG) ;
    } else {
        mrtFatalError(mrtRelationshipLinkage) ;
    }

    return newSubInst ;
}
MRT_ecb *
mrt_NewEvent(
    MRT_EventCode event,
    void *target,
    void *source)
{
    MRT_Instance *targetInst = target ;
    MRT_Instance *sourceInst = source ;

    assert(targetInst != NULL) ;
    assert(targetInst->alloc != 0) ;
    assert(event < targetInst->classDesc->eventCount) ;

    MRT_ecb *ecb = mrtAllocEvent() ;

    ecb->eventNumber = event ;
    ecb->alloc = targetInst->alloc ;    // <1>
    ecb->targetInst = targetInst ;
    ecb->sourceInst = sourceInst ;
    ecb->delay = 0 ;                    // <2>

    return ecb ;
}
void
mrt_PostEvent(
    MRT_ecb *ecb)
{
    assert(ecb != NULL) ;
    assert(ecb->targetInst != NULL) ;

        /*
         * The place in some event queue where the ECB will be inserted.
         */
    MRT_ecb *place ;

    if (ecb->sourceInst == NULL) { // <1>
        place = (MRT_ecb *)&tocEventQueue ;
    } else {
        place = (MRT_ecb *)&eventQueue ;
        if (ecb->sourceInst == ecb->targetInst) { // <2>
            while (place != mrtEventQueueEnd(&eventQueue) &&
                    place->sourceInst == place->targetInst) {
                place = place->next ;
            }
        }
    }

    mrtEventQueueInsert(ecb, place) ;
}
void *
mrt_CreateAsync(
    MRT_Class const *targetClass,
    MRT_EventCode event,
    void const *eventparams,
    size_t paramsize,
    void *sourceInst)
{
    assert(targetClass != NULL) ;
    assert(targetClass->edb != NULL) ;
    assert(targetClass->edb->creationState >= 0) ;
    assert(event < targetClass->edb->eventCount) ;

    MRT_Instance *targetInst = mrt_CreateInstance(targetClass,
            targetClass->edb->creationState) ; // <1>
    targetInst->alloc = -targetInst->alloc ; // <2>

    MRT_ecb *ecb = mrt_NewEvent(event, targetInst, sourceInst) ;

    assert(paramsize <= sizeof(ecb->eventParameters)) ;
    if (eventparams != NULL) {
        size_t copy = paramsize <= sizeof(ecb->eventParameters) ?
            paramsize : sizeof(ecb->eventParameters) ;
        memcpy(ecb->eventParameters, eventparams, copy) ;
    }

    mrt_PostEvent(ecb) ;

    return targetInst ;
}
void
mrt_PostDelayedEvent(
    MRT_ecb *ecb,
    MRT_DelayTime time)
{
    assert(ecb != NULL) ;

    if (time != 0) {
        ecb->delay = mrtMsecToTicks(time) ;
        /*
         * Stop the timing queue so we may examine it.
         */
        mrtStopDelayedQueueTiming() ;
        /*
         * If the event already exists, remove it.
         */
        MRT_ecb *dupEvent = mrtFindEvent(&delayedEventQueue,
                ecb->sourceInst, ecb->targetInst, ecb->eventNumber) ;
        if (dupEvent) {
            mrtRemoveDelayedEvent(dupEvent) ;
        }
        /*
         * Insert the new event.
         * We walk down the queue to find the correct slot.  That slot is the
         * first place in the queue where our delay value is less than the delay
         * value at that place in the queue.  As we walk the queue, we subtract
         * the delay value of each entry we pass since that entry will have
         * expired before the one being inserted.
         */
        MRT_ecb *iter ;
        for (iter = mrtEventQueueBegin(&delayedEventQueue) ;
                iter != mrtEventQueueEnd(&delayedEventQueue) ;
                iter = iter->next) {
            /*
             * By keeping this comparison to be strictly less than, we preserve
             * the order of event dispatch to match that of event generation.
             */
            if (ecb->delay < iter->delay) {
                /*
                 * We are going to insert before the entry pointed to by "iter".
                 * Therefore, we need to decrease its delay value by the amount of
                 * time that will have elapsed after the entry we are about to
                 * insert expires.
                 */
                iter->delay -= ecb->delay ;
                break ;
            } else {
                ecb->delay -= iter->delay ;
            }
        }
        /*
         * At this point we have found our place in the queue.  Either we are
         * between entries or this delay was longer than the cumulative delays of
         * all the ECB's in the queue. Insert the ECB.
         */
        mrtEventQueueInsert(ecb, iter) ;
        /*
         * Start the timer to expire for the first event on the queue.
         */
        mrtStartDelayedQueueTiming() ;
    } else {
        mrtEventQueueInsert(ecb, (MRT_ecb *)&tocEventQueue) ; // <1>
    }
}
void
mrt_CancelDelayedEvent(
    MRT_EventCode event,
    void *target,
    void *source)
{
    MRT_Instance *targetInst = target ;
    MRT_Instance *sourceInst = source ;
    assert(targetInst != NULL) ;
    /*
     * Stop delayed queue so that we may examine it.
     */
    mrtStopDelayedQueueTiming() ;
    /*
     * Search for the event in the delayed event queue.
     */
    MRT_ecb *foundEvent = mrtFindEvent(&delayedEventQueue, sourceInst,
            targetInst, event) ;
    if (foundEvent) {
        /*
         * Removing from the delayed queue requires additional processing of
         * the delay times.
         */
        mrtRemoveDelayedEvent(foundEvent) ;
    } else {
        /*
         * If the event is not in the delayed queue, then search the thread of
         * control event queue. The timer could have expired and the event
         * placed in the queue.
         */
        foundEvent = mrtFindEvent(&tocEventQueue, sourceInst, targetInst, event) ;
        if (foundEvent) {
            mrtEventQueueRemove(foundEvent) ;
            mrtFreeEvent(foundEvent) ;
        }
        /*
         * We can get here, without finding the event in the delayed queue or
         * the thread of control event queue.  That's okay, it just amounts to
         * an expensive no-op and implies that the event has expired, was
         * queued and has already been dispatched or had never been generated
         * at all.
         */
    }
    mrtStartDelayedQueueTiming() ;
}
MRT_DelayTime
mrt_RemainingDelayTime(
    MRT_EventCode event,
    void *target,
    void *source)
{
    MRT_Instance *targetInst = target ;
    MRT_Instance *sourceInst = source ;
    assert(targetInst != NULL) ;

    mrtStopDelayedQueueTiming() ;
    /*
     * Iterate through the delayed event time and sum all the delay times to
     * give the total amount of time remaining for the found event.
     */
    MRT_DelayTime remain = 0 ;
    MRT_ecb *iter ;
    MRT_ecb *endOfQueue = mrtEventQueueEnd(&delayedEventQueue) ;
    for (iter = mrtEventQueueBegin(&delayedEventQueue) ; iter != endOfQueue ;
            iter = iter->next) {
        remain += iter->delay ;
        if (iter->sourceInst == sourceInst && iter->targetInst == targetInst &&
                iter->eventNumber == event) {
            break ;
        }
    }
    mrtStartDelayedQueueTiming() ;
    /*
     * Return the amount of time remaining for the event.  If we didn't find
     * the event, the just return 0.
     */
    return iter == endOfQueue ? 0 : mrtTicksToMsec(remain) ;
}
MRT_DelayTime
mrt_TimerExpireService(void)
{
    /*
     * Sync to the background to request the expired events be transferred to
     * the event queue.
     */
    mrt_SyncRequest(mrtExpiredEventService) ;
    /*
     * Mark the delayed events as expired, returning a pointer to the first
     * unexpired event.
     */
    MRT_ecb *unexpired = mrtExpireDelayedEvents() ;
    MRT_DelayTime nextTime ;
    if (unexpired) {
        /*
         * If there is an unexpired event, then its delay time is the next time
         * to expire. We return that time and zero out the delay time.
         */
        assert(unexpired->delay != 0) ;
        nextTime = unexpired->delay ;
        unexpired->delay = 0 ;
    } else {
        /*
         * Otherwise, there is nothing else to time.
         */
        nextTime = 0 ;
    }

    return nextTime ;
}
int
mrt_PortalGetAttrRef(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_InstId instId,
    MRT_AttrId attrId,
    void **pref,
    MRT_AttrSize *size)
{
    int result ;
    MRT_Instance *instref ;

    result = mrtPortalGetInstRef(portal, classId, instId, &instref) ;
    if (result == 0) {
        assert(instref != NULL) ;
        if (instref->alloc != 0) {
            MRT_Class const *class = instref->classDesc ;
            if (attrId < class->attrCount) {
                MRT_Attribute const *attr = class->classAttrs + attrId ;
                if (attr->type == mrtIndependentAttr) {
                    if (pref) {
                        *pref = (void *)((uintptr_t)instref + attr->access.offset) ;
                    }
                    if (size) {
                        *size = attr->size ;
                    }
                } else {
                    result = MICCA_PORTAL_DEPENDENT_ATTR ;
                }
            } else {
                result = MICCA_PORTAL_NO_ATTR ;
            }
        } else {
            result = MICCA_PORTAL_UNALLOC ;
        }
    }

    return result ;
}
int
mrt_PortalReadAttr(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_InstId instId,
    MRT_AttrId attrId,
    void *dst,
    MRT_AttrSize dstSize)
{
    assert(dst != NULL) ;

    MRT_Instance *instref ;
    int result ;

    result = mrtPortalGetInstRef(portal, classId, instId, &instref) ;
    if (result == 0) {
        assert(instref != NULL);
        if (instref->alloc != 0) {
            MRT_Class const *class = instref->classDesc ;
            if (attrId < class->attrCount) {
                MRT_Attribute const *attr = class->classAttrs + attrId ;
                MRT_AttrSize srcSize = attr->size ;
                if (dstSize >= srcSize) {
                    result = srcSize ;
                    if (attr->type == mrtIndependentAttr) {
                        void *src = (void *)((uintptr_t)instref +
                                attr->access.offset) ;
                        memcpy(dst, src, srcSize) ;
                    } else {
                        attr->access.formula(instref, dst, srcSize) ;
                    }
                } else {
                    result = MICCA_PORTAL_TRUNCATED ;
                }
            } else {
                result = MICCA_PORTAL_NO_ATTR ;
            }
        } else {
            result = MICCA_PORTAL_UNALLOC ;
        }
    }

    return result ;
}
int
mrt_PortalUpdateAttr(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_InstId instId,
    MRT_AttrId attrId,
    void const *src,
    MRT_AttrSize srcSize)
{
    assert(src != NULL) ;

    void *dst ;
    MRT_AttrSize dstSize ;

    int result = mrt_PortalGetAttrRef(portal, classId, instId, attrId, &dst,
            &dstSize) ;
    if (result == 0) {
        assert(dst != NULL) ;
        int copied ;
        if (srcSize == 0) {
            copied = dstSize ;
        } else {
            copied = dstSize < srcSize ? dstSize : srcSize ;
        }
        memcpy(dst, src, copied) ;
        result = copied ;
    }

    return result ;
}
int
mrt_PortalSignalEvent(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_InstId instId,
    MRT_EventCode eventNumber,
    void const *eventParameters,
    size_t paramSize)
{
    int result ;
    MRT_ecb *ecb ;

    result = mrtPortalNewECB(portal, classId, instId, eventNumber,
            eventParameters, paramSize, &ecb) ;
    if (result == 0) {
        mrt_PostEvent(ecb) ;
    }

    return result ;
}
int
mrt_PortalSignalDelayedEvent(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_InstId instId,
    MRT_EventCode eventNumber,
    void const *eventParameters,
    size_t paramSize,
    MRT_DelayTime delay)
{
    int result ;
    MRT_ecb *ecb ;

    result = mrtPortalNewECB(portal, classId, instId, eventNumber,
            eventParameters, paramSize, &ecb) ;
    if (result == 0) {
        mrt_PostDelayedEvent(ecb, delay) ;
    }

    return result ;
}
int
mrt_PortalCancelDelayedEvent(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_InstId instId,
    MRT_EventCode eventNumber)
{
    int result ;
    MRT_Instance *instref ;

    result = mrtPortalGetInstRef(portal, classId, instId, &instref) ;
    if (result == 0) {
        mrt_CancelDelayedEvent(eventNumber, instref, NULL) ;
    }

    return result ;
}
int
mrt_PortalRemainingDelayTime(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_InstId instId,
    MRT_EventCode eventNumber,
    MRT_DelayTime *delayRef)
{
    int result ;
    MRT_Instance *instref ;

    result = mrtPortalGetInstRef(portal, classId, instId, &instref) ;
    if (result == 0) {
        MRT_DelayTime delay = mrt_RemainingDelayTime(eventNumber, instref, NULL) ;
        if (delayRef) {
            *delayRef = delay ;
        }
    }

    return result ;
}
int
mrt_PortalCreateInstance(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_StateCode initialState)
{
    int result ;

    if (classId < portal->classCount) {
        MRT_Class const *class = portal->classes + classId ;
        if (class->containment == NULL) {
            MRT_Instance *inst = mrt_CreateInstance(class, initialState) ;
            assert(inst != NULL) ;
            MRT_iab *iab = class->iab ;
            assert(iab != NULL) ;
            assert(iab->storageStart != NULL) ;
            result = ((uintptr_t)inst - (uintptr_t)iab->storageStart) /
                    iab->instanceSize ;
        } else {
            result = MICCA_PORTAL_NO_DYNAMIC ;
        }
    } else {
        result = MICCA_PORTAL_NO_CLASS ;
    }

    return result ;
}
int
mrt_PortalCreateAsync(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_EventCode eventNumber,
    void const *eventParameters,
    size_t paramSize)
{
    int result ;

    if (classId < portal->classCount) {
        MRT_Class const *class = portal->classes + classId ;
        if (class->containment == NULL) { // <1>
            MRT_Instance *inst = mrt_CreateAsync(class, eventNumber,
                eventParameters, paramSize, NULL) ;
            result = mrt_InstanceIndex(inst) ;
        } else {
            result = MICCA_PORTAL_NO_DYNAMIC ;
        }
    } else {
        result = MICCA_PORTAL_NO_CLASS ;
    }

    return result ;
}
int
mrt_PortalDeleteInstance(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_InstId instId)
{
    int result ;
    MRT_Instance *inst ;

    result = mrtPortalGetInstRef(portal, classId, instId, &inst) ;
    if (result == 0) {
        mrt_DeleteInstance(inst) ;
    }

    return result ;
}
int
mrt_PortalSignalEventToAssigner(
    MRT_DomainPortal const *portal,
    MRT_AssignerId assignerId,
    MRT_InstId instId,
    MRT_EventCode eventNumber,
    void const *eventParameters,
    size_t paramSize)
{
    assert(portal != NULL) ;
    int result ;

    if (assignerId < portal->assignerCount) {
        MRT_Class const *passigner = portal->assigners + assignerId ;
        if (instId < passigner->instCount) {
            MRT_iab *iab = passigner->iab ;
            assert(iab != NULL) ;
            MRT_Instance *instref = (MRT_Instance *)
                    ((uintptr_t)iab->storageStart + iab->instanceSize * instId) ;
            if (instref->alloc > 0) {
                MRT_edb const *edb = passigner->edb ;
                if (eventNumber < edb->eventCount) {
                    MRT_ecb *ecb = mrt_NewEvent(eventNumber, instref, NULL) ;
                    if (eventParameters != NULL) {
                        size_t copy = paramSize <= sizeof(ecb->eventParameters) ?
                            paramSize : sizeof(ecb->eventParameters) ;
                        memcpy(ecb->eventParameters, eventParameters, copy) ;
                    }
                    mrt_PostEvent(ecb) ;
                    result = 0 ;
                } else {
                    result = MICCA_PORTAL_NO_EVENT ;
                }
            } else {
                result = MICCA_PORTAL_UNALLOC ;
            }
        } else {
            result = MICCA_PORTAL_NO_INST ;
        }
    } else {
        result = MICCA_PORTAL_NO_CLASS ;
    }

    return result ;
}
int
mrt_PortalInstanceCurrentState(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_InstId instId)
{
    MRT_Instance *instref ;
    int result ;

    result = mrtPortalGetInstRef(portal, classId, instId, &instref) ;
    if (result == 0) {
        assert(instref != NULL);
        if (instref->alloc > 0) {
            MRT_Class const *class = instref->classDesc ;
            result = class->edb != NULL ?
                    instref->currentState : MICCA_PORTAL_NO_STATE_MODEL ;
            assert(result >= 0) ;
        } else {
            result = MICCA_PORTAL_UNALLOC ;
        }
    }

    return result ;
}
int
mrt_PortalAssignerCurrentState(
    MRT_DomainPortal const *portal,
    MRT_AssignerId assignerId,
    MRT_InstId instId)
{
    assert(portal != NULL) ;
    int result ;

    if (assignerId < portal->assignerCount) {
        MRT_Class const *passigner = portal->assigners + assignerId ;
        if (instId < passigner->instCount) {
            MRT_iab *iab = passigner->iab ;
            assert(iab != NULL) ;
            MRT_Instance *instref = (MRT_Instance *)
                    ((uintptr_t)iab->storageStart + iab->instanceSize * instId) ;
            if (instref->alloc > 0) {
                assert(instref->classDesc->edb != NULL) ;
                result = instref->currentState ;
            } else {
                result = MICCA_PORTAL_UNALLOC ;
            }
        } else {
            result = MICCA_PORTAL_NO_INST ;
        }
    } else {
        result = MICCA_PORTAL_NO_CLASS ;
    }

    return result ;
}
char const *
mrt_PortalDomainName(
    MRT_DomainPortal const *portal)
{
    assert(portal != NULL) ;

#       ifndef MRT_NO_NAMES
    return portal->name ;
#       else
    return NULL ;
#       endif /* MRT_NO_NAMES */
}
unsigned
mrt_PortalDomainClassCount(
    MRT_DomainPortal const *portal)
{
    assert(portal != NULL) ;
    return portal->classCount ;
}
int
mrt_PortalClassName(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    char const **nameRef)
{
    assert(portal != NULL) ;

    int result ;
    if (classId < portal->classCount) {
#           ifndef MRT_NO_NAMES
        MRT_Class const *class = portal->classes + classId ;
        if (nameRef) {
            *nameRef = class->name ;
        }
#           else
        if (nameRef) {
            *nameRef = NULL ;
        }
#           endif /* MRT_NO_NAMES */
        result = 0 ;
    } else {
        result = MICCA_PORTAL_NO_CLASS ;
    }

    return result ;
}
int
mrt_PortalClassAttributeCount(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId)
{
    assert(portal != NULL) ;

    int result ;
    if (classId < portal->classCount) {
        MRT_Class const *class = portal->classes + classId ;
        result = class->attrCount ;
    } else {
        result = MICCA_PORTAL_NO_CLASS ;
    }

    return result ;
}
int
mrt_PortalClassInstanceCount(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId)
{
    assert(portal != NULL) ;

    int result ;
    if (classId < portal->classCount) {
        MRT_Class const *class = portal->classes + classId ;
        result = class->instCount ;
    } else {
        result = MICCA_PORTAL_NO_CLASS ;
    }

    return result ;
}
int
mrt_PortalClassEventCount(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId)
{
    assert(portal != NULL) ;

    int result ;
    if (classId < portal->classCount) {
        MRT_Class const *class = portal->classes + classId ;
        result = class->eventCount ;
    } else {
        result = MICCA_PORTAL_NO_CLASS ;
    }

    return result ;
}
int
mrt_PortalClassStateCount(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId)
{
    assert(portal != NULL) ;

    int result ;
    if (classId < portal->classCount) {
        MRT_Class const *class = portal->classes + classId ;
        MRT_edb const *edb = class->edb ;
        result = edb != NULL ? edb->stateCount : 0 ;
    } else {
        result = MICCA_PORTAL_NO_CLASS ;
    }

    return result ;
}
int
mrt_PortalClassAttributeName(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_AttrId attrId,
    char const **nameRef)
{
    assert(portal != NULL) ;

    int result ;
    if (classId < portal->classCount) {
        MRT_Class const *class = portal->classes + classId ;
        if (attrId < class->attrCount) {
            if (nameRef) {
#                   ifndef MRT_NO_NAMES
                *nameRef = class->classAttrs[attrId].name ;
#                   else
                *nameRef = NULL ;
#                   endif /* MRT_NO_NAMES */
            }
            result = 0 ;
        } else {
            result = MICCA_PORTAL_NO_ATTR ;
        }
    } else {
        result = MICCA_PORTAL_NO_CLASS ;
    }

    return result ;
}
int
mrt_PortalClassAttributeSize(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_AttrId attrId)
{
    assert(portal != NULL) ;

    int result ;
    if (classId < portal->classCount) {
        MRT_Class const *class = portal->classes + classId ;
        if (attrId < class->attrCount) {
            result = class->classAttrs[attrId].size ;
        } else {
            result = MICCA_PORTAL_NO_ATTR ;
        }
    } else {
        result = MICCA_PORTAL_NO_CLASS ;
    }

    return result ;
}
int
mrt_PortalClassEventName(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_EventCode eventCode,
    char const **nameRef)
{
    assert(portal != NULL) ;

    int result ;
    if (classId < portal->classCount) {
        MRT_Class const *class = portal->classes + classId ;
        if (class->eventCount != 0) {
            if (eventCode < class->eventCount) {
#                   ifndef MRT_NO_NAMES
                char const *const *eventNames = class->eventNames ;
                if (eventNames != NULL && nameRef != NULL) {
                    *nameRef = eventNames[eventCode] ;
                }
#                   else
                if (nameRef != NULL) {
                    *nameRef = NULL ;
                }
#                   endif /* MRT_NO_NAMES */
                result = 0 ;
            } else {
                result = MICCA_PORTAL_NO_EVENT ;
            }
        } else {
            result = MICCA_PORTAL_NO_STATE_MODEL ;
        }
    } else {
        result = MICCA_PORTAL_NO_CLASS ;
    }

    return result ;
}
int
mrt_PortalClassStateName(
    MRT_DomainPortal const *portal,
    MRT_ClassId classId,
    MRT_StateCode stateCode,
    char const **nameRef)
{
    assert(portal != NULL) ;

    int result ;
    if (classId < portal->classCount) {
        MRT_Class const *class = portal->classes + classId ;
        MRT_edb const *edb = class->edb ;
        if (edb != NULL) {
            if (stateCode >= 0 && stateCode < edb->stateCount) {
                if (nameRef) {
#                       ifndef MRT_NO_NAMES
                    *nameRef = edb->stateNames[stateCode] ;
#                       else
                    *nameRef = NULL ;
#                       endif /* MRT_NO_NAMES */
                }
                result = 0 ;
            } else {
                result = MICCA_PORTAL_NO_STATE ;
            }
        } else {
            result = MICCA_PORTAL_NO_STATE_MODEL ;
        }
    } else {
        result = MICCA_PORTAL_NO_CLASS ;
    }

    return result ;
}
MRT_FatalErrorHandler
mrt_SetFatalErrorHandler(
    MRT_FatalErrorHandler newHandler)
{
    MRT_FatalErrorHandler prevHandler = mrtErrHandler ;
    if (newHandler) {
        mrtErrHandler = newHandler ;
    }
    return prevHandler ;
}
bool
mrt_CanCreateInstance(
    MRT_Class const *classDesc)
{
    assert(classDesc != NULL) ;

    /*
     * Search for an empty slot in the pool.
     */
    return mrtFindInstSlot(classDesc->iab) != NULL ;
}
bool
mrt_CanSignalEvent(void)
{
    return !mrtEventQueueEmpty(&freeEventQueue) ;
}
