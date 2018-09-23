#
#*++
# PROJECT:
#	mrtools
# MODULE:
#
# ABSTRACT:
#
#*--
#

VERSION = 1.0

DOCDIR	= ../doc
CODEDIR	= ../code/tcl
TESTDIR = ../tests
PKGDIR	= ../../packages

vpath %.pdf $(DOCDIR)
vpath %.test $(TESTDIR)
vpath %.tcl $(CODEDIR)

DOCSRC 	=\
	mecate.aweb\
	$(NULL)

TCLSRC	=\
     	$(patsubst %.aweb,%.tcl,$(DOCSRC))\
	$(NULL)

PDF 	=\
     	$(patsubst %.aweb,%.pdf,$(DOCSRC))\
     	$(NULL)

TEMPLATE =\
	 $(patsubst %.aweb,template-%.test,$(DOCSRC))\
     	 $(NULL)

TESTS	=\
     	$(patsubst %.aweb,%.test,$(DOCSRC))\
	$(NULL)

CLEANFILES =\
	$(TCLSRC)\
	$(DOCDIR)/$(PDF)\
	$(TESTDIR)/$(TESTS)\
	$(TEMPLATE)\
	$(CODEDIR)/pkgIndex.tcl\
	$(NULL)

A2XOPTS =\
	--verbose\
	$(NULL)

ATANGLEOPTS	=\
	$(NULL)

DBLATEX_PARAMS	=\
		doc.publisher.show=0\
		glossary.numbered=0\
		index.numbered=0\
		doc.lot.show=figure,table\
		toc.section.depth=3\
		doc.section.depth=0\
		$(NULL)

EXTRAS =\
	docinfo.xml\
	mecate-docinfo.xml\
	$(NULL)

ASCIIDOC_ATTRS	=\
		docinfo2\
		$(NULL)


DBLATEX_OPTS	=\
		--dblatex-opts="$(patsubst %,--param=%,$(DBLATEX_PARAMS))"\
		$(NULL)

ASCIIDOC_OPTS	=\
		$(patsubst %,--attribute=%,$(ASCIIDOC_ATTRS))\
		$(NULL)

.PHONY : all doc code tests runtests package clean

all : doc code tests package template

doc : $(PDF)

code : $(TCLSRC)

tests : code $(TESTS)

package : $(PKGDIR)/package-mecate-$(VERSION)-tcl.tm

template : $(TEMPLATE)

clean :
	$(RM) $(CLEANFILES)

$(PDF) : $(DOCSRC) $(EXTRAS)

$(TCLSRC) : $(DOCSRC)

pkgIndex.tcl : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $(CODEDIR)/$@ $<

$(PKGDIR)/package-mecate-$(VERSION)-tcl.tm : $(TCLSRC) pkgIndex.tcl\
    		$(CODEDIR)/teapot.txt
	cd $(CODEDIR) ; teapot-pkg generate --output ../$(PKGDIR) .

$(MAN) : $(DOCSRC)

%.pdf : %.aweb
	a2x $(A2XOPTS) --doctype=article  --format=pdf\
	    --destination-dir=$(DOCDIR)\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $<
	rm -f $(DOCDIR)/mecate__*.*

%.tcl : %.aweb
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $(CODEDIR)/$@ $<

%.test : %.aweb
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $(TESTDIR)/$@ $<

template-%.test : %.aweb
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $@ $<

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
