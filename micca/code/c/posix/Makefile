#
#*++
# PROJECT:
#	micca
# MODULE:
# 	micca_rt_test
# ABSTRACT:
# 	Test of the micca run time code
#
#*--
#

MICCADIR = ../../../src

CFLAGS	= -std=c11 -g -L$(HOME)/local/lib -Wall
CPPFLAGS =\
	 -D_ISOC11_SOURCE\
	 -D_XOPEN_SOURCE=600\
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

ATANGLEOPTS =\
	$(NULL)

.PHONY : all code

all : code

code : micca_rt.o

micca_rt.o : micca_rt_internal.h micca_rt.h micca_rt.c

micca_rt_internal.h : $(RTSRC)
	cd $(MICCADIR) ; atangle $(ATANGLEOPTS) -root $@ -output $@ micca.aweb
	mv $(MICCADIR)/micca_rt_internal.h .

micca_rt.h : $(RTSRC)
	cd $(MICCADIR) ; atangle $(ATANGLEOPTS) -root micca_rt_posix.h\
	    	-output $@ micca.aweb
	mv $(MICCADIR)/micca_rt.h .

micca_rt.c : $(RTSRC) micca_rt.h
	cd $(MICCADIR) ; atangle $(ATANGLEOPTS) -root micca_rt_posix.c -output $@ micca.aweb
	mv $(MICCADIR)/micca_rt.c .

CLEANFILES =\
	micca_rt.c\
	micca_rt_internal.h\
	micca_rt.h\
	micca_rt.o\
	$(NULL)

clean :
	$(RM) $(CLEANFILES)

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
