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
TESTDIR = ../tests
PKGDIR	= ../../packages
IMAGEDIR = ./images

vpath %.pdf $(DOCDIR)
vpath %.html $(DOCDIR)
vpath %.test $(TESTDIR)
vpath %.uxf $(IMAGEDIR)

DOCSRC 	=\
	micca.aweb\
	$(NULL)

DOCPARTS=\
	bibliography.txt\
	codeorg.txt\
	configure.txt\
	generate.txt\
	litprog.txt\
	platform.txt\
	preface.txt\
	runtime.txt\
	$(NULL)

DIAGRAMS =\
	$(NULL)

LSDIAGRAMS =\
	platform-classes.uxf\
	platform-domain.uxf\
	platform-event.uxf\
	platform-population.uxf\
	platform-references.uxf\
	platform-relation.uxf\
	platform-statemodel.uxf\
	platform-transition.uxf\
	$(NULL)

IMAGES =\
	$(patsubst %.uxf,$(IMAGEDIR)/%.pdf,$(DIAGRAMS))\
	$(patsubst %.uxf,$(IMAGEDIR)/%.pdf,$(LSDIAGRAMS))\
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
	docinfo.xml\
	$(NULL)

EXTRAS =\
	$(DOCINFO)\
	bibliography.txt\
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

.PHONY : all doc code tests runtests

all : doc code tests

doc : $(PDF)

code : $(TCLSRC)

tests : code $(TESTS)

runtests : tests
	cd $(TESTDIR) ; tclsh $(TESTS) -verbose bet -level info

clean :
	$(RM) $(CLEANFILES)

$(DOCSRC) : $(DOCPARTS)

$(PDF) : $(DOCSRC) $(DOCPARTS) $(EXTRAS) $(IMAGES)

$(TCLSRC) : $(DOCSRC) $(DOCPARTS)

$(TESTS) : $(DOCSRC) $(DOCPARTS)

$(DOCDIR)/%.pdf : %.aweb
	a2x $(A2XOPTS) --doctype=book  --format=pdf\
	    --destination-dir=$(DOCDIR)\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $<
	$(RM) $(DOCDIR)/*__[0-9].pdf

%.tcl : %.aweb
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

%.test : %.aweb
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $(TESTDIR)/$@ $<

$(IMAGEDIR)/platform-%.pdf : platform-%.uxf
	umlet -action=convert -format=pdf\
		-filename=$< -output=$(basename $@)-cvt
	pdftk $(basename $@)-cvt.pdf cat 1left output $@
	$(RM) $(basename $@)-cvt.pdf

$(IMAGEDIR)/%.pdf : %.uxf
	umlet -action=convert -format=pdf\
		-filename=$< -output=$(basename $@)

$(MANSRC) : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $@ $<

$(MANDOC) : $(MANSRC)
	dtplite -o $@ html $<

builddoc :
	a2x $(A2XOPTS) --doctype=book  --format=pdf\
	    --destination-dir=$(DOCDIR)\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) micca.aweb

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
