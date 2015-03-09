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

DOCDIR	= ../doc
TESTDIR = ../tests
IMAGEDIR = ./images

vpath %.pdf $(DOCDIR)
vpath %.html $(DOCDIR)
vpath %.test $(TESTDIR)
vpath %.uxf $(IMAGEDIR)

DOCSRC 	=\
	rash.aweb\
	$(NULL)

DIAGRAMS =\
	classes.uxf\
	$(NULL)

IMAGES =\
	$(patsubst %.uxf,$(IMAGEDIR)/%.pdf,$(DIAGRAMS))\
	$(NULL)

TCLSRC	=\
     	$(patsubst %.aweb,%.tcl,$(DOCSRC))\
	$(NULL)

PDF 	=\
     	$(DOCDIR)/$(patsubst %.aweb,%.pdf,$(DOCSRC))\
     	$(NULL)

MANSRC	=\
     	$(DOCDIR)/$(patsubst %.aweb,%.man,$(DOCSRC))\
     	$(NULL)

MANDOC	=\
     	$(DOCDIR)/$(patsubst %.aweb,%.html,$(DOCSRC))\
     	$(NULL)

TESTS	=\
     	$(TESTDIR)/$(patsubst %.aweb,%.test,$(DOCSRC))\
	$(NULL)

CLEANFILES =\
	$(TCLSRC)\
	$(IMAGES)\
	$(PDF)\
	$(TESTS)\
	$(NULL)

A2XOPTS =\
	--verbose\
	$(NULL)

ATANGLEOPTS =\
	-report\
	$(NULL)

DBLATEX_PARAMS =\
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
	--dblatex-opts="--fig-path=$(IMAGEDIR)"\
	$(NULL)

ASCIIDOC_OPTS =\
	$(patsubst %,--attribute=%,$(ASCIIDOC_ATTRS))\
	$(NULL)

.PHONY : all doc code tests runtests clean

all : doc code tests manual

doc : $(PDF)

code : $(TCLSRC) pkgIndex.tcl

tests : code $(TESTS)

manual : $(MANDOC)

runtests : tests
	cd $(TESTDIR) ; tclsh $(TESTS) -verbose bet -level info

clean :
	$(RM) $(CLEANFILES)

$(PDF) : $(DOCSRC) $(EXTRAS) $(IMAGES)

$(TCLSRC) : $(DOCSRC)

pkgIndex.tcl : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

$(DOCDIR)/%.pdf : %.aweb
	a2x $(A2XOPTS) --doctype=book  --format=pdf\
	    --destination-dir=$(DOCDIR)\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $<
	$(RM) $(DOCDIR)/*__[0-9].pdf

%.tcl : %.aweb
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

$(TESTDIR)/%.test : %.aweb
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $(TESTDIR)/$@ $<

$(IMAGEDIR)/%.pdf : %.uxf
	umlet -action=convert -format=pdf\
		-filename=$< -output=$(basename $@)

$(MANSRC) : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $@ $<

$(MANDOC) : $(MANSRC)
	dtplite -o $@ html $<
#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
