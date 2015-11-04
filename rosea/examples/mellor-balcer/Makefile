#
#*++
# PROJECT:
#	Tools
# MODULE:
# 	rash
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
	scenario1.tcl\
	$(NULL)

CLEANFILES =\
	$(PDF)\
	$(ROOTS)\
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

runtests : $(ROOTS)
	tclsh scenario1.tcl -verbose bet -level info

clean :
	$(RM) $(CLEANFILES)

$(PDF) : $(DOCSRC) $(EXTRAS)

simplebookstore.tcl : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

sbs_population.tcl : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

scenario1.tcl : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

%.pdf : %.aweb
	a2x $(A2XOPTS) --doctype=article  --format=pdf\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $<
	$(RM) *__[0-9].pdf

%.tcl : %.aweb
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
