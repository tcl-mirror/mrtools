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
	arm-7m\
	msp430\
	$(NULL)

RTSRCS=\
        $(patsubst %,%/micca_rt.h,$(PLATFORMS))\
        $(patsubst %,%/micca_rt.c,$(PLATFORMS))\
	$(NULL)

ATANGLEOPTS =\
	$(NULL)

.PHONY : all

all : micca_main.tcl $(RTSRCS)

micca_main.tcl : $(ASRC)
	cd $(MICCADIR) ; \
	    atangle $(ATANGLEOPTS) -root micca_main.tcl -output $@ micca.aweb
	mv $(MICCADIR)/micca_main.tcl .

posix/micca_rt.h posix/micca_rt.c : $(ASRC)
	$(MAKE) --directory posix micca_rt.h micca_rt.c

arm-7m/micca_rt.h arm-7m/micca_rt.c : $(ASRC)
	$(MAKE) --directory arm-7m micca_rt.h micca_rt.c

msp430/micca_rt.h msp430/micca_rt.c : $(ASRC)
	$(MAKE) --directory msp430 micca_rt.h micca_rt.c

CLEANFILES =\
	micca_main.tcl\
	$(NULL)

clean :
	$(RM) $(CLEANFILES)

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
