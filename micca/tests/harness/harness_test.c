#include "micca_tack.h"

extern MTH_DomainHarness const wmctrl__HARNESS ;

int
main(
    int arc,
    char **arv)
{
    mrt_Initialize() ;
    int err = mth_Initialize() ;
    if (err == -1) {
        fprintf(stderr, "mth_Initialize() failed\n") ;
        exit(EXIT_FAILURE) ;
    }
    mth_RegisterDomain(&wmctrl__HARNESS) ;

    mrt_EventLoop() ;
}
