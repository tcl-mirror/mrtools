MICCADIR = ../../../src

CC=arm-none-eabi-gcc
CFLAGS	= -std=c11 -g -L$(HOME)/local/lib -Wall
CPPFLAGS =\
	 -D_POSIX_C_SOURCE=200112L\
	 -D_ISOC11_SOURCE\
	 -D_XOPEN_SOURCE=600\
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

micca_rt.c : micca_rt.h

code : micca_rt.h micca_rt.c

micca_rt.h : $(RTSRC)
	cd $(MICCADIR) ; atangle $(ATANGLEOPTS) -root micca_rt_arm7m.h\
	    	-output $@ micca.aweb
	mv $(MICCADIR)/micca_rt.h .

micca_rt.c : $(RTSRC) micca_rt.h
	cd $(MICCADIR) ; atangle $(ATANGLEOPTS) -root micca_rt_arm7m.c -output $@ micca.aweb
	mv $(MICCADIR)/micca_rt.c .

CLEANFILES =\
	micca_rt.c\
	micca_rt.h\
	$(NULL)

clean :
	$(RM) $(CLEANFILES)
#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
