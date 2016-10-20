#include "micca_tack.h"

extern MTH_DomainHarness const wmctrl__HARNESS ;

int
main(
    int arc,
    char **arv)
{
    mrt_Initialize() ;
    if (!mth_Initialize()) {
        fprintf(stderr, "mth_Initialize() failed\n") ;
        exit(EXIT_FAILURE) ;
    }

    mth_RegisterDomain(&wmctrl__HARNESS) ;

    mth_Run() ;
}
