#
#*++
# PROJECT:
#	Farfalle
# MODULE:
#
# ABSTRACT:
#*--
#

DOCDIR	= ./doc
IMAGEDIR = ./figures

REQUIRED_DIRS = \
	$(DOCDIR)\
	$(NULL)

_MKDIRS := $(shell for d in $(REQUIRED_DIRS) ;	\
	     do					\
	       [ -d $$d ] || mkdir -p $$d ;	\
	     done)

vpath %.pdf $(DOCDIR)
vpath %.uxf $(IMAGEDIR)

PROGNAME = ee

# These are the files that are included in the main "aweb" file for the
# domain workbook.
DOCPARTS=\
	$(NULL)

# List diagrams here. Include the "uxf" extension. All files listed
# here should be in the "figures" directory. For example:
#	class-diagram.uxf\
#	collaboration.uxf\
#	foo-sm.uxf\

DIAGRAMS =\
	sgroup-attr-bridge.uxf\
	sensor-group-classes.uxf\
	sgroup-ee.uxf\
	attr-ee.uxf\
	semantic-mapping.uxf\
	$(NULL)

DOCSRC 	=\
	$(PROGNAME).adoc\
	$(NULL)

IMAGES =\
	$(patsubst %.uxf,$(IMAGEDIR)/%.pdf,$(DIAGRAMS))\
	$(NULL)

PDF =\
	$(DOCDIR)/$(patsubst %.adoc,%.pdf,$(DOCSRC))\
	$(NULL)

CLEANFILES =\
	$(IMAGES)\
	$(PDF)\
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
	toc.section.depth=2\
	doc.section.depth=0\
	$(NULL)

# Copy and uncomment these lines into the DBLATEX_PARAMS macro to
# produce a draft with a big watermark across the page.
# draft.mode=yes
# draft.watermark=1

DOCINFO	=\
	$(patsubst %.aweb,%-docinfo.xml,$(DOCSRC))\
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

.PHONY : all code doc clean

all : doc

doc : $(PDF)

clean :
	$(RM) $(CLEANFILES)

$(DOCSRC) : $(DOCPARTS)

$(PDF) : $(DOCSRC) $(DOCPARTS) $(EXTRAS) $(IMAGES)
	a2x $(A2XOPTS) --doctype=article  --format=pdf\
	    --destination-dir=$(DOCDIR)\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $<
	$(RM) $(DOCDIR)/*__[0-9].pdf

%.pdf : %.uxf
	umlet -action=convert -format=pdf\
		-filename=$< -output=$(basename $@)

#
# vim: set sw=8 ts=8 sts=8 noexpandtab:
#
