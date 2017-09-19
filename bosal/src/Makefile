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

DOCDIR	= ../doc
TESTDIR = ../test
PKGDIR	= ../../packages
IMAGEDIR = ./figures
CODEDIR	= ../code

VERSION=0.1

vpath %.pdf $(DOCDIR)
vpath %.html $(DOCDIR)
vpath %.test $(TESTDIR)
vpath %.uxf $(IMAGEDIR)
vpath %.tcl $(CODEDIR)/tcl

DOCSRC 	=\
	bosal.aweb\
	$(NULL)

CODEFILES =\
	  $(CODEDIR)/tcl/bosal.tcl\
	  $(CODEDIR)/tcl/bosal_main.tcl\
	  $(NULL)

DOCPARTS=\
	intro.txt\
	generate.txt\
	utils.txt\
	codeorg.txt\
	litprog.txt\
	$(NULL)

DIAGRAMS =\
	harness-drawing.uxf\
	$(NULL)

IMAGES =\
	$(patsubst %.uxf,$(IMAGEDIR)/%.pdf,$(DIAGRAMS))\
	$(NULL)

PDF 	=\
     	$(DOCDIR)/$(patsubst %.aweb,%.pdf,$(DOCSRC))\
     	$(NULL)

TESTS	=\
     	$(patsubst %.aweb,%.test,$(DOCSRC))\
	$(NULL)

CLEANFILES =\
	$(TCLSRC)\
	$(IMAGES)\
	$(PDF)\
	$(TESTDIR)/$(TESTS)\
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
	doc.section.depth=1\
	$(NULL)

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

TESTOPTS =\
	-verbose bet\
	-level debug\
	$(NULL)

# -noconfig -nogenerate

.PHONY : all code doc tests runtests

all : doc code

doc : $(PDF)

code : $(CODEFILES)

tests : code $(TESTS)

runtests : tests
	cd $(TESTDIR) ; tclsh $(TESTS) $(TESTOPTS)

clean :
	$(RM) $(CLEANFILES)

$(DOCSRC) : $(DOCPARTS)

$(PDF) : $(DOCSRC) $(DOCPARTS) $(EXTRAS) $(IMAGES)

$(CODEDIR)/tcl/bosal.tcl : $(DOCSRC) $(DOCPARTS)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $@ $(DOCSRC)

$(CODEDIR)/tcl/bosal_main.tcl : $(DOCSRC) $(DOCPARTS)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $@ $(DOCSRC)

$(TESTS) : $(DOCSRC) $(DOCPARTS)

$(DOCDIR)/%.pdf : %.aweb
	a2x $(A2XOPTS) --doctype=article  --format=pdf\
	    --destination-dir=$(DOCDIR)\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $<
	$(RM) $(DOCDIR)/*__[0-9].pdf

$(IMAGEDIR)/%.pdf : %.uxf
	umlet -action=convert -format=pdf\
		-filename=$< -output=$(basename $@)

%.tcl : %.aweb
	atangle $(ATANGLEOPTS) -root $@ -output $(CODEDIR)/tcl/$@ $<

%.test : %.aweb
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $(TESTDIR)/$@ $<

#
# vim: set sw=8 ts=8 sts=8 noexpandtab:
#
