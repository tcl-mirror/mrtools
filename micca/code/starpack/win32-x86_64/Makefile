#
#*++
# PROJECT:
#	Tools
# MODULE:
#
# ABSTRACT:
#
#*--
#

MICCADIR = ../../../src
DOCDIR = ../../../doc
TCLCODE = ../../tcl

ASRC 	=\
	$(MICCADIR)/micca.aweb\
	$(MICCADIR)/*.txt\
	$(NULL)

RUNTIME	=\
	micca_rt.h\
	micca_rt.c\
	$(NULL)

PLATFORMS=\
	posix\
	arm-7m/msp432\
	arm-7m/efm32gg\
	msp430\
	$(NULL)

HARNESS	=\
	micca_tack.h\
	micca_tack.c\
	$(NULL)

RTSRCS=\
        $(patsubst %,%/micca_rt.h,$(PLATFORMS))\
        $(patsubst %,%/micca_rt.c,$(PLATFORMS))\
	$(NULL)

ATANGLEOPTS =\
	$(NULL)

.PHONY : all

all : $(TCLCODE)/micca_main.tcl $(RTSRCS)

$(TCLCODE)/micca_main.tcl : $(ASRC)
	make --director $(TCLCODE) micca_main.tcl

posix/micca_rt.h posix/micca_rt_internal.h posix/micca_rt.c : $(ASRC)
	$(MAKE) --directory posix micca_rt.h micca_rt_internal.h micca_rt.c

arm-7m/msp432/micca_rt.h arm-7m/msp432/micca_rt_internal.h arm-7m/msp432/micca_rt.c : $(ASRC)
	$(MAKE) --directory arm-7m/msp432 micca_rt.h micca_rt_internal.h micca_rt.c

arm-7m/efm32gg/micca_rt.h arm-7m/efm32gg/micca_rt_internal.h arm-7m/efm32gg/micca_rt.c : $(ASRC)
	$(MAKE) --directory arm-7m/efm32gg micca_rt.h micca_rt_internal.h micca_rt.c

msp430/micca_rt.h msp430/micca_rt_internal.h msp430/micca_rt.c : $(ASRC)
	$(MAKE) --directory msp430 micca_rt.h micca_rt_internal.h micca_rt.c

doc :
	$(MAKE) --directory $(DOCDIR)

CLEANFILES =\
	micca_main.tcl\
	$(NULL)

clean :
	$(RM) $(CLEANFILES)

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
