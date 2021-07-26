#
#*++
# PROJECT:
#	micca
# MODULE:
# 	Association tests
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
	--verbose\
	$(NULL)

DBLATEX_PARAMS =\
	bibliography.numbered=0\
	index.numbered=0\
	doc.publisher.show=0\
	doc.lot.show=figure,table\
	toc.section.depth=3\
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

CFLAGS	=\
	 -std=c11\
	 -g\
	 -I$(HOME)/local/include -Wall\
	 $(NULL)

CPPFLAGS =\
	 -DMRT_NO_TRACE\
	 $(NULL)

MICCAFLAGS =\
	 $(NULL)

.PHONY : all doc runtests

all : runtests coverage

runtests : micca_gen_test
	./micca_gen_test

coverage : runtests
	gcovr -r . --html-details -o test_results/micca_gen_test.html

micca_gen_test : LOADLIBES = $(HOME)/local/lib/libcunit.a --coverage

micca_gen_test : micca_gen_test.o gendomain.o micca_rt.o

micca_gen_test.c : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

micca_gen_test.o : micca_gen_test.c micca_rt.h micca_rt_internal.h gendomain.h

gendomain.o : CPPFLAGS += -I$(HOME)/local/include
gendomain.o : gendomain.c gendomain.h micca_rt.h micca_rt_internal.h

gendomain.c gendomain.h : gendomain.micca
	micca $(MICCAFLAGS) $<

gendomain.micca : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

micca_rt.o : CFLAGS += --coverage

doc : $(PDF)

CLEANFILES =\
	core\
	*.gcda\
	*.gcno\
	micca_gen_test\
	micca_gen_test.c\
	gendomain.*\
	*.o\
	$(PDF)\
	$(NULL)

clean :
	$(RM) $(CLEANFILES)

$(PDF) : $(DOCSRC) $(DOCINFO)

%.pdf : %.aweb
	a2x $(A2XOPTS) --doctype=article  --format=pdf\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $<
	$(RM) ./*__[0-9]*.*

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
