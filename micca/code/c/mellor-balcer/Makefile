#
#*++
# PROJECT:
#	Tools
# MODULE:
# 	Mellor/Balcer Example
#
# ABSTRACT:
#
#*--
#

LDFLAGS = -g
CFLAGS	= -std=c11 -g -Og -Wall\
	-Wno-unused-variable\
	-Wno-unused-function\
	-Wno-unused-but-set-variable\
	$(NULL)
CPPFLAGS =\
	 -D_POSIX_C_SOURCE=200112L\
	 -D_ISOC11_SOURCE\
	 -DMRT_ECB_PARAM_SIZE=64\
	 $(NULL)

DOCSRC 	=\
	simplebookstore.aweb\
	$(NULL)

PDF 	=\
     	$(patsubst %.aweb,%.pdf,$(DOCSRC))\
     	$(NULL)

ROOTS	=\
	simplebookstore.micca\
	sbs_population.micca\
	$(NULL)

TESTS	=\
	testscenario.tcl\
	$(NULL)

SCENARIOS =\
	scenario1\
	scenario2\
	scenario3\
	scenario4\
	$(NULL)

LOGS	=\
     	$(patsubst %,%.log,$(SCENARIOS))\
	$(NULL)

DIAGS	=\
     	$(patsubst %,%.diag,$(SCENARIOS))\
	$(NULL)

CLEANFILES =\
	$(PDF)\
	$(ROOTS)\
	$(TESTS)\
	$(LOGS)\
	$(DIAGS)\
	*.o\
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
	toc.section.depth=3\
	doc.section.depth=0\
	$(NULL)

DOCINFO	=\
	$(patsubst %.aweb,%-docinfo.xml,$(DOCSRC))\
	$(NULL)

INFO =\
	docinfo.xml\
	$(DOCINFO)\
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

.PHONY : all doc code runtests clean

all : doc code

doc : $(PDF)

code : bookstore

bookstore : bookstore.o micca_rt.o

bookstore.c : bookstore.h micca_rt.h

micca_rt.c : micca_rt.h

bookstore.c : simplebookstore.micca sbs_population.micca
	micca -stubexternalops simplebookstore.micca sbs_population.micca

runtests : $(ROOTS) $(TESTS)
	for test in $(TESTS) ; do tclsh $$test ; done

clean :
	$(RM) $(CLEANFILES)

$(PDF) : $(DOCSRC) $(INFO)

simplebookstore.micca : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

sbs_population.micca : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

testscenario.tcl : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

$(LOGS) $(DIAGS) : testscenario.tcl $(ROOTS)
	tclsh $<

%.pdf : %.aweb
	a2x $(A2XOPTS) --doctype=article  --format=pdf\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $<

%.tcl : %.aweb
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

%.pdf : %.diag
	seqdiag --antialias -T pdf -o $@ $<

other : simplebookstore.micca sbs_population.micca
	tclsh ../../starpack/x86_64-linux-tcl8.6/micca_main.tcl -stubexternalops simplebookstore.micca sbs_population.micca

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
