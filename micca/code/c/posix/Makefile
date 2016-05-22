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

PDF 	=\
     	$(patsubst %.aweb,%.pdf,$(DOCSRC))\
     	$(NULL)

A2XOPTS =\
	--verbose\
	$(NULL)

ATANGLEOPTS =\
	$(NULL)

DBLATEX_PARAMS =\
	bibliography.numbered=0\
	index.numbered=0\
	doc.publisher.show=0\
	doc.lot.show=figure,table\
	toc.section.depth=1\
	doc.section.depth=0\
	$(NULL)

DOCINFO	=\
	$(patsubst %.aweb,%-docinfo.xml,$(DOCSRC))\
	docinfo.xml\
	$(NULL)

ASCIIDOC_ATTRS =\
	docinfo2\
	$(NULL)

DBLATEX_OPTS =\
	--dblatex-opts="$(patsubst %,--param=%,$(DBLATEX_PARAMS))"\
	$(NULL)

ASCIIDOC_OPTS =\
	$(patsubst %,--attribute=%,$(ASCIIDOC_ATTRS))\
	$(NULL)

.PHONY : all doc runtests

all : doc runtests

doc : $(PDF)

tests : micca_rt_test

runtests : tests
	micca_rt_test
	gcov micca_rt_test.c

code : micca_rt.h micca_rt.c

micca_rt_test : CPPFLAGS += -I$(HOME)/local/include \
    	-fprofile-arcs -ftest-coverage

micca_rt_test : LOADLIBES = $(HOME)/local/lib/libcunit.a

micca_rt_test : micca_rt_test.c

micca_rt_test.c : micca_rt.c micca_rt.h testdomain.c

micca_rt_test.c : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root micca_rt_test.c -output $@ $<

micca_rt.h : $(RTSRC)
	cd $(MICCADIR) ; atangle $(ATANGLEOPTS) -root micca_rt_posix.h\
	    	-output $@ micca.aweb
	mv $(MICCADIR)/micca_rt.h .

micca_rt.c : $(RTSRC)
	cd $(MICCADIR) ; atangle $(ATANGLEOPTS) -root micca_rt_posix.c -output $@ micca.aweb
	mv $(MICCADIR)/micca_rt.c .

testdomain.c : testdomain.micca
	tclsh $<

testdomain.micca : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

CLEANFILES =\
	micca_rt_test\
	micca_rt_test.c\
	micca_rt.c\
	micca_rt.h\
	micca_rt.o\
	testdomain.micca\
	testdomain.c\
	testdomain.h\
	testdomain.o\
	$(PDF)\
	*.gcov\
	*.gcda\
	*.gcno\
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
