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

vpath %.uxf $(IMAGEDIR)

IMAGEDIR = ./figures

DOCSRC 	=\
	rellinks.txt\
	$(NULL)

DIAGRAMS =\
	1to1.uxf\
	0-1to1.uxf\
	1-Mto1.uxf\
	0-Mto1.uxf\
	0-1to0-1.uxf\
	1-Mto0-1.uxf\
	0-Mto0-1.uxf\
	1-Mto1-M.uxf\
	1-Mto0-M.uxf\
	0-Mto0-M.uxf\
	X-Y-1-to-1.uxf\
	1to1-reflex.uxf\
	0-1to0-1-reflex.uxf\
	0-Mto1-reflex.uxf\
	simple-gen.uxf\
	repeat-gen.uxf\
	multi-gen.uxf\
	compound-gen.uxf\
	$(NULL)

IMAGES =\
	$(patsubst %.uxf,$(IMAGEDIR)/%.pdf,$(DIAGRAMS))\
	$(NULL)

PDF 	=\
     	$(patsubst %.txt,%.pdf,$(DOCSRC))\
     	$(NULL)

CLEANFILES =\
	$(IMAGES)\
	$(PDF)\
	$(NULL)

A2XOPTS =\
	$(NULL)

#	--verbose


ATANGLEOPTS =\
	$(NULL)

DBLATEX_PARAMS =\
	bibliography.numbered=0\
	index.numbered=0\
	doc.publisher.show=0\
	doc.toc.show=1\
	doc.lot.show=figure,table\
	toc.section.depth=2\
	doc.section.depth=0\
	$(NULL)

# draft.mode=yes
# draft.watermark=1

DOCINFO	=\
	$(patsubst %.txt,%-docinfo.xml,$(DOCSRC))\
	docinfo.xml\
	$(NULL)

EXTRAS =\
	$(DOCINFO)\
	$(NULL)

ASCIIDOC_ATTRS =\
	docinfo2\
	$(NULL)


DBLATEX_OPTS =\
	--dblatex-opts="$(patsubst %,--param=%,$(DBLATEX_PARAMS))"\
	--dblatex-opts="--fig-path=$(IMAGEDIR)"\
	$(NULL)

ASCIIDOC_OPTS =\
	$(patsubst %,--attribute=%,$(ASCIIDOC_ATTRS))\
	$(NULL)

.PHONY : all doc clean

all : doc

doc : $(PDF)

clean :
	$(RM) $(CLEANFILES)

$(PDF) : $(DOCSRC) $(EXTRAS) $(IMAGES)

%.pdf : %.txt
	a2x $(A2XOPTS) --doctype=article  --format=pdf\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $<

%.pdf : %.uxf
	umlet -action=convert -format=pdf\
		-filename=$< -output=$(basename $@)

#
# vim: sw=8 ts=8 sts=8 noexpandtab
#
