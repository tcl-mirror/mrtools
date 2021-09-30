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
TCLCODEDIR = ../../tcl

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

RTSRCS=\
        $(patsubst %,%/micca_rt.h,$(PLATFORMS))\
        $(patsubst %,%/micca_rt.c,$(PLATFORMS))\
	$(NULL)

ATANGLEOPTS =\
	$(NULL)

.PHONY : all doc module

all : micca_main.tcl $(RTSRCS) doc module

micca.tcl micca_main.tcl : $(ASRC)
	make --directory $(MICCADIR) code

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

module :
	$(MAKE) --directory $(MICCADIR) module

CLEANFILES =\
	$(NULL)

clean :
	$(RM) $(CLEANFILES)

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
