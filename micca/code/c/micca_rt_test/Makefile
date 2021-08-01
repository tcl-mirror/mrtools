#
#*++
# PROJECT:
#	micca
# MODULE:
# 	Run time tests
#
# ABSTRACT:
#
#*--
#

DOCSRC 	=\
	micca_rt_test.aweb\
	$(NULL)

PDF 	=\
     	$(patsubst %.aweb,%.pdf,$(DOCSRC))\
     	$(NULL)

A2XOPTS =\
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

CFLAGS	= -std=c11 -g -I$(HOME)/local/include -Wall
CPPFLAGS =\
	 $(NULL)

.PHONY : all doc runtests coverage

all : runtests coverage

runtests : micca_rt_test
	./micca_rt_test
	$(MAKE) --directory posix runtests

coverage : runtests
	gcovr --print-summary --html-details --html-title "Runtime Test Coverage"\
	    --output test_results/micca_rt_test.html

micca_rt_test : LOADLIBES = $(HOME)/local/lib/libcunit.a --coverage

micca_rt_test : micca_rt_test.o testdomain.o micca_rt.o

micca_rt_test.c : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

micca_rt_test.o : micca_rt_test.c micca_rt.h micca_rt_internal.h testdomain.h

testdomain.o : CPPFLAGS += -I$(HOME)/local/include
testdomain.o : testdomain.c testdomain.h micca_rt.h micca_rt_internal.h

testdomain.c testdomain.h : testdomain.micca
	micca $<

testdomain.micca : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

micca_rt.o : CFLAGS += --coverage

doc : $(PDF)

CLEANFILES =\
	core\
	micca_rt_test\
	micca_rt_test.c\
	testdomain.c\
	testdomain.h\
	testdomain.micca\
	*.o\
	*.info\
	*.gcno\
	*.gcda\
	$(PDF)\
	$(NULL)

clean :
	$(RM) $(CLEANFILES)
	$(RM) -r test_results/*

$(PDF) : $(DOCSRC) $(DOCINFO)

%.pdf : %.aweb
	a2x $(A2XOPTS) --doctype=book  --format=pdf\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $<
	$(RM) ./*__[0-9].*

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
