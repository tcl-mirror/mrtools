#include "sio.h"

typedef struct {
    int valueIndex ;
    int numValues ;
    SioPointValue_t *values ;
} ValueStore ;
static SioPointValue_t
vs_nextValue(
    ValueStore *vs)
{
    if (vs->numValues <= 0) {
        return 0 ;
    }

    SioPointValue_t cval = vs->values[vs->valueIndex] ;
    if (++vs->valueIndex >= vs->numValues) {
        vs->valueIndex = 0 ;
    }

    return cval ;
}
static SioPointValue_t inj1PresValues[] = {20, 21, 22, 26, 27, 16, 15, 14} ;
static SioPointValue_t inj2PresValues[] = {20, 21, 22, 26, 27, 23, 19, 18} ;
static SioPointValue_t inj3PresValues[] = {20, 21, 22, 26, 27, 23, 19, 18} ;

static ValueStore converterValues
        [SIO_SIGNAL_CONVERTER_INSTCOUNT]
        [SIO_CONTINUOUS_INPUT_POINT_INSTCOUNT] = {
    [SIO_SIGNAL_CONVERTER_CVT1_INSTID] = {
        [SIO_IO_POINT_IOP1_INSTID] = {
            .valueIndex = 0,
            .numValues = COUNTOF(inj1PresValues),
            .values = inj1PresValues
        },
        [SIO_IO_POINT_IOP2_INSTID] = {
            .valueIndex = 0,
            .numValues = COUNTOF(inj2PresValues),
            .values = inj2PresValues
        },
        [SIO_IO_POINT_IOP3_INSTID] = {
            .valueIndex = 0,
            .numValues = COUNTOF(inj2PresValues),
            .values = inj3PresValues
        },
    },
} ;
static SioPointValue_t m1LockoutValues[] = {0, 1} ;
static SioPointValue_t m2LockoutValues[] = {0, 1} ;
static SioPointValue_t m3LockoutValues[] = {0, 1} ;
static SioPointValue_t rsv1LevelValues[] = {1, 0} ;
static SioPointValue_t rsv2LevelValues[] = {1, 0} ;

static ValueStore registerValues[SIO_IO_POINT_INSTCOUNT] = {
    [SIO_IO_POINT_IOP7_INSTID] = {
        .valueIndex = 0,
        .numValues = COUNTOF(m1LockoutValues),
        .values = m1LockoutValues
    },
    [SIO_IO_POINT_IOP8_INSTID] = {
        .valueIndex = 0,
        .numValues = COUNTOF(m2LockoutValues),
        .values = m2LockoutValues
    },
    [SIO_IO_POINT_IOP9_INSTID] = {
        .valueIndex = 0,
        .numValues = COUNTOF(m3LockoutValues),
        .values = m3LockoutValues
    },
    [SIO_IO_POINT_IOP10_INSTID] = {
        .valueIndex = 0,
        .numValues = COUNTOF(rsv1LevelValues),
        .values = rsv1LevelValues
    },
    [SIO_IO_POINT_IOP11_INSTID] = {
        .valueIndex = 0,
        .numValues = COUNTOF(rsv2LevelValues),
        .values = rsv2LevelValues
    },
} ;
void
sio_DEVICE_Convert_group__EOP(
    SioConverterID_t converter,
    SioGroupID_t group)
// assert(converter < SIO_SIGNAL_CONVERTER_INSTCOUNT) ;
// int pcode = mrt_PortalSignalDelayedEvent(&sio__PORTAL,
//         SIO_SIGNAL_CONVERTER_CLASSID,
//         converter,
//         SIO_SIGNAL_CONVERTER_CONVERSION_DONE_EVENT,
//         NULL, 0,
//         10) ;
// assert(pcode == 0) ;
{
    assert(converter < SIO_SIGNAL_CONVERTER_INSTCOUNT) ;
    int pcode = mrt_PortalSignalDelayedEvent(&sio__PORTAL,
    SIO_SIGNAL_CONVERTER_CLASSID,
    converter,
    SIO_SIGNAL_CONVERTER_CONVERSION_DONE_EVENT,
    NULL, 0,
    10) ;
    assert(pcode == 0) ;
}
SioPointValue_t
sio_DEVICE_Read_converted_value__EOP(
    SioConverterID_t converter,
    SioPointID_t point)

// assert(converter <= SIO_SIGNAL_CONVERTER_INSTCOUNT) ;
// assert(point < SIO_IO_POINT_INSTCOUNT) ;

// return vs_nextValue(&converterValues[converter][point]) ;
{
    assert(converter <= SIO_SIGNAL_CONVERTER_INSTCOUNT) ;
    assert(point < SIO_IO_POINT_INSTCOUNT) ;

    return vs_nextValue(&converterValues[converter][point]) ;
}
void
sio_DEVICE_Write_reg__EOP(
    SioPointID_t pid,
    SioPointValue_t value)

{
}
SioPointValue_t
sio_DEVICE_Read_reg__EOP(
    SioPointID_t pid)
// assert(pid < SIO_IO_POINT_INSTCOUNT) ;

// return vs_nextValue(&registerValues[pid]) ;
{
    assert(pid < SIO_IO_POINT_INSTCOUNT) ;

    return vs_nextValue(&registerValues[pid]) ;
}
void sio_DEVICE_Enable_signal__EOP(SioPointID_t point)
{
}
void sio_DEVICE_Disable_signal__EOP(SioPointID_t point)
{
}
