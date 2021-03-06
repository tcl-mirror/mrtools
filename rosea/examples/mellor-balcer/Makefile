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

DOCSRC 	=\
	simplebookstore.aweb\
	$(NULL)

PDF 	=\
     	$(patsubst %.aweb,%.pdf,$(DOCSRC))\
     	$(NULL)

ROOTS	=\
	simplebookstore.tcl\
	sbs_population.tcl\
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

PDFDIAGS =\
     	$(patsubst %.diag,%.pdf,$(DIAGS))\
	$(NULL)

CLEANFILES =\
	$(PDF)\
	$(ROOTS)\
	$(TESTS)\
	$(LOGS)\
	$(DIAGS)\
	$(PDFDIAGS)\
	$(NULL)

A2XOPTS =\
	--verbose\
	$(NULL)

ATANGLEOPTS =\
	-report\
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

EXTRAS =\
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

code : $(ROOTS)

runtests : $(ROOTS) $(TESTS)
	for test in $(TESTS) ; do tclsh $$test ; done

clean :
	$(RM) $(CLEANFILES)

$(PDF) : $(DOCSRC) $(EXTRAS) $(LOGS) $(PDFDIAGS)

simplebookstore.tcl : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

sbs_population.tcl : $(DOCSRC)
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

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
