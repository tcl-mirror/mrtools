MICCADIR = ../../../../src

CC=arm-none-eabi-gcc
CFLAGS	= -c -std=c11 -Os -g -Wall -mcpu=cortex-m4 -march=armv7e-m -mthumb
CPPFLAGS =\
	 -D_ISOC11_SOURCE\
	 -I/home/andrewm/opt/ti/ccsv6/ccs_base/arm/include\
	 -I/home/andrewm/opt/ti/ccsv6/ccs_base/arm/include/CMSIS\
	 -D__MSP432P401R__\
	 -DNDEBUG\
	 -DMRT_NO_NAMES\
	 -DMRT_NO_TRACE\
	 $(NULL)

DOCSRC 	=\
	micca_rt_test.aweb\
	$(NULL)

RTSRC 	=\
	$(MICCADIR)/micca.aweb\
	$(MICCADIR)/bibliography.txt\
	$(MICCADIR)/codeorg.txt\
	$(MICCADIR)/configure.txt\
	$(MICCADIR)/example.txt\
	$(MICCADIR)/generate.txt\
	$(MICCADIR)/litprog.txt\
	$(MICCADIR)/platform.txt\
	$(MICCADIR)/preface.txt\
	$(MICCADIR)/runtime.txt\
	$(MICCADIR)/translation.txt\
	$(NULL)

.PHONY : all code

all : micca_rt.o

micca_rt.c : micca_rt.h micca_rt_internal.h

code : micca_rt.h micca_rt.c micca_rt_internal.h

micca_rt.h : $(RTSRC)
	cd $(MICCADIR) ; atangle $(ATANGLEOPTS) -root micca_rt_msp432.h\
	    	-output $@ micca.aweb
	mv $(MICCADIR)/micca_rt.h .

micca_rt_internal.h : $(RTSRC)
	cd $(MICCADIR) ; atangle $(ATANGLEOPTS) -root $@ -output $@ micca.aweb
	mv $(MICCADIR)/micca_rt_internal.h .

micca_rt.c : $(RTSRC) micca_rt.h
	cd $(MICCADIR) ; atangle $(ATANGLEOPTS) -root micca_rt_msp432.c -output $@ micca.aweb
	mv $(MICCADIR)/micca_rt.c .

CLEANFILES =\
	micca_rt.c\
	micca_rt.h\
	micca_rt_internal.h\
	$(NULL)

clean :
	$(RM) $(CLEANFILES)
#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
