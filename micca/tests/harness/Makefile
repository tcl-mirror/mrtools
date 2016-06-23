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

MICCADIR = ../../src

CFLAGS	= -std=c11 -g -L$(HOME)/local/lib -Wall
CPPFLAGS =\
	 -D_POSIX_C_SOURCE=200112L\
	 -D_ISOC11_SOURCE\
	 -D_XOPEN_SOURCE=600\
	 -DMRT_HARNESS\
	 -DMRT_INSTRUMENT\
	 $(NULL)
SRCS	=\
	harness_test.c\
	wmctrl_harness.c\
	wmctrl.c\
	micca_tack.c\
	micca_rt.c\
	$(NULL)

.PHONY : all

all : harness_test

harness_test : $(SRCS)

harness_test.c : micca_tack.h micca_rt.h

wmctrl_harness.c : micca_tack.h micca_rt.h wmctrl.h

wmctrl.c wmctrl.h wm_harness.c : wmctrl.micca wmctrl_pop.micca
	tclsh build_wmctrl.tcl

wmctrl.c : wmctrl.h micca_rt.h

micca_tack.c : micca_tack.h micca_rt.h

micca_rt.c : micca_rt.h

micca_rt.h : $(MICCADIR)/runtime.txt
	atangle $(ATANGLEOPTS) -root micca_rt_posix.h\
	    -output $@ $(MICCADIR)/runtime.txt

micca_rt.c : $(MICCADIR)/runtime.txt
	atangle $(ATANGLEOPTS) -root micca_rt_posix.c\
	    -output $@ $(MICCADIR)/runtime.txt

micca_tack.h : $(MICCADIR)/harness.txt
	atangle $(ATANGLEOPTS) -root $@ -output $@ $(MICCADIR)/harness.txt

micca_tack.c : $(MICCADIR)/harness.txt
	atangle $(ATANGLEOPTS) -root $@ -output $@ $(MICCADIR)/harness.txt

CLEANFILES =\
	harness_test\
	wmctrl_harness.c\
	wmctrl.c\
	wmctrl.h\
	micca_tack.c\
	micca_tack.h\
	micca_rt.c\
	micca_rt.h\
	*.o\
	$(NULL)

clean :
	$(RM) $(CLEANFILES)

$(PDF) : $(DOCSRC) $(DOCPARTS) $(EXTRAS) $(IMAGES) $(DOCINFO)

%.pdf : %.aweb
	a2x $(A2XOPTS) --doctype=book  --format=pdf\
	    --destination-dir=$(DOCDIR)\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $<
	$(RM) $(DOCDIR)/*__[0-9].pdf

builddoc :
	a2x $(A2XOPTS) --doctype=book  --format=pdf\
	    --destination-dir=$(DOCDIR)\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) micca.aweb

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
