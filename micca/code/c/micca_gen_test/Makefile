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
	micca_gen_test.aweb\
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

.PHONY : all doc runtests

all : runtests

runtests : micca_gen_test
	./micca_gen_test

micca_gen_test : LOADLIBES = $(HOME)/local/lib/libcunit.a

micca_gen_test : micca_gen_test.o gendomain.o micca_rt.o

micca_gen_test.c : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

micca_gen_test.o : micca_gen_test.c micca_rt.h micca_rt_internal.h gendomain.h

gendomain.o : CPPFLAGS += -I$(HOME)/local/include
gendomain.o : gendomain.c gendomain.h micca_rt.h micca_rt_internal.h

gendomain.c gendomain.h : gendomain.micca
	micca $<

gendomain.micca : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

doc : $(PDF)

CLEANFILES =\
	core\
	micca_gen_test\
	micca_gen_test.c\
	gendomain.*\
	*.o\
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
