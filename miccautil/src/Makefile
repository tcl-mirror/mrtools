#
#*++
# PROJECT:
#	Tools
# MODULE:
#	Makefile for miccautil package
#
# ABSTRACT:
#
#*--
#

DOCDIR	= ../doc
TESTDIR = ../test
MODULEDIR = ../../modules
IMAGEDIR = ../test
CODEDIR	= ../code

REQUIRED_DIRS = \
	$(DOCDIR)\
	$(TESTDIR)\
	$(MODULEDIR)\
	$(IMAGEDIR)\
	$(CODEDIR)\
	$(NULL)

_MKDIRS := $(shell for d in $(REQUIRED_DIRS) ;	\
	     do					\
	       [ -d $$d ] || mkdir -p $$d ;	\
	     done)

VERSION=1.0a1

vpath %.pdf $(DOCDIR)
vpath %.html $(DOCDIR)
vpath %.test $(TESTDIR)
vpath %.uxf $(IMAGEDIR)

PACKAGE = miccautil

DOCFILE	= $(PACKAGE).aweb
CODEFILE = $(CODEDIR)/$(PACKAGE).tcl
TESTFILE = $(TESTDIR)/$(PACKAGE).test
PDFFILE = $(DOCDIR)/$(PACKAGE).pdf
MANSRC = $(DOCDIR)/$(PACKAGE).man
MANDOC = $(DOCDIR)/$(PACKAGE).html
MODULEFILE = $(MODULEDIR)/$(PACKAGE)-$(VERSION).tm

DOCPARTS =\
	intro.txt\
	implementation.txt\
	code_organization.txt\
	$(NULL)

DIAGRAMS =\
	Sample_Set.pdf\
	Conduit.pdf\
	Discovered_Sensor.pdf\
	$(NULL)

IMAGES =\
	$(patsubst %,$(IMAGEDIR)/%,$(DIAGRAMS))\
	$(NULL)

CLEANFILES =\
	$(CODEFILE)\
	$(TESTFILE)\
	$(IMAGES)\
	$(PDFFILE)\
	$(MANDOC)\
	$(NULL)

A2XOPTS =\
	$(NULL)

# --verbose\

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

# draft.mode=yes
# draft.watermark=1

DOCINFO	=\
	$(PACKAGE)-docinfo.xml\
	docinfo.xml\
	$(NULL)

EXTRAS =\
	$(DOCINFO)\
	litprog.txt\
	copyright_info.txt\
	edit_warning.txt\
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

.PHONY : all doc code test runtests module

all : doc code test module

doc : $(PDFFILE)

code : $(CODEFILE)

test : $(TESTFILE)

module : $(MODULEFILE)

runtests : code test
	cd $(TESTDIR) ; tclsh $(PACKAGE).test $(TESTOPTS)

clean :
	$(RM) $(CLEANFILES)

$(PDFFILE) : $(DOCFILE) $(DOCPARTS) $(EXTRAS) $(IMAGES)
	a2x $(A2XOPTS) --doctype=book  --format=pdf\
	    --destination-dir=$(DOCDIR)\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $(DOCFILE)
	$(RM) $(DOCDIR)/*__[0-9].*

$(CODEFILE) : $(DOCFILE) $(DOCPARTS)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $(CODEFILE) $(DOCFILE)

$(TESTFILE) : $(DOCFILE) $(DOCPARTS)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $(TESTFILE) $(DOCFILE)

$(MODULEFILE) : $(CODEFILE)
	mkmodule $(PACKAGE) $(VERSION) -outdir $(MODULEDIR) -script $(CODEFILE)

$(IMAGES) : runtests

#
# vim: sw=8 ts=8 sts=8 noexpandtab
#
