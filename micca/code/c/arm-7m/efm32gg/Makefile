MICCADIR = ../../../../src

CC=arm-none-eabi-gcc
CFLAGS	=\
	 -c\
	 -std=c11\
	 -Os\
	 -g\
	 -Wall\
	 -mcpu=cortex-m3\
	 -march=armv7-m\
	 -mthumb\
	 $(NULL)
SSTUDIO=/home/andrewm/opt/silabs/SimplicityStudio_v4/developer/sdks/exx32/v5.0.0.0
CPPFLAGS =\
	 -D_ISOC11_SOURCE\
	 -DMRT_SWO_OUTPUT\
	 -I$(SSTUDIO)/platform/CMSIS/Include\
	 -I$(SSTUDIO)/platform/Device/SiliconLabs/EFM32GG/Include\
	 -I$(SSTUDIO)/platform/emlib/inc\
	 -I$(SSTUDIO)/hardware/kit/common/bsp\
	 -I$(SSTUDIO)/hardware/kit/EFM32GG_STK3700/config\
	 -DEFM32GG990F1024=1\
	 $(NULL)

DOCSRC 	=\
	micca_rt_test.aweb\
	$(NULL)

RTSRC 	=\
	$(MICCADIR)/micca.aweb\
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

code : micca_rt.h micca_rt_internal.h micca_rt.c

micca_rt.h : $(RTSRC)
	cd $(MICCADIR) ; atangle $(ATANGLEOPTS) -root micca_rt_efm32gg.h\
	    	-output $@ micca.aweb
	mv $(MICCADIR)/micca_rt.h .

micca_rt_internal.h : $(RTSRC)
	cd $(MICCADIR) ; atangle $(ATANGLEOPTS) -root $@ -output $@ micca.aweb
	mv $(MICCADIR)/micca_rt_internal.h .

micca_rt.c : $(RTSRC) micca_rt.h
	cd $(MICCADIR) ; atangle $(ATANGLEOPTS) -root micca_rt_efm32gg.c -output $@ micca.aweb
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
