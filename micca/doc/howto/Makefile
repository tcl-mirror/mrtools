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
	howto.txt\
	$(NULL)

DOCPARTS =\
	intro.txt\
	marking.txt\
	syntax.txt\
	data.txt\
	dynamics.txt\
	processing.txt\
	lesser.txt\
	bridge.txt\
	codeorg.txt\
	bibliography.txt\
	$(NULL)

DIAGRAMS =\
	micca-translation.uxf\
	$(NULL)

IMAGES =\
	$(patsubst %.uxf,$(IMAGEDIR)/%.pdf,$(DIAGRAMS))\
	$(NULL)

GENIMAGES=\
     	$(patsubst %.txt,%__*.png,$(DOCSRC))\
	$(NULL)

PDF 	=\
     	$(patsubst %.txt,%.pdf,$(DOCSRC))\
     	$(NULL)

CLEANFILES =\
	$(IMAGES)\
	$(PDF)\
     	$(GENIMAGES)\
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
	doc.toc.show=1\
	doc.lot.show=figure,table,example\
	toc.section.depth=4\
	doc.section.depth=0\
	draft.mode=yes\
	draft.watermark=1\
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

$(PDF) : $(DOCSRC) $(DOCPARTS) $(EXTRAS) $(IMAGES)

%.pdf : %.txt
	a2x $(A2XOPTS) --doctype=article  --format=pdf\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $<
	$(RM) $(GENIMAGES)

%.pdf : %.uxf
	umlet -action=convert -format=pdf\
		-filename=$< -output=$(basename $@)

#
# vim: sw=8 ts=8 sts=8 noexpandtab
#
