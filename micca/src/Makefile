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
CODEDIR	= ../code

VERSION=1.0a3

vpath %.pdf $(DOCDIR)
vpath %.html $(DOCDIR)
vpath %.test $(TESTDIR)
vpath %.uxf $(IMAGEDIR)

DOCSRC 	=\
	micca.aweb\
	$(NULL)

CODEFILE =\
	  $(CODEDIR)/tcl/micca.tcl\
	  $(CODEDIR)/tcl/micca_main.tcl\
	  $(NULL)

DOCPARTS=\
	bibliography.txt\
	codeorg.txt\
	configure.txt\
	example.txt\
	generate.txt\
	litprog.txt\
	platform.txt\
	preface.txt\
	runtime.txt\
	translation.txt\
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
	rel-simp-nr-1-1.uxf\
	rel-simp-r-1-1.uxf\
	rel-simp-nr-M-1-dyn.uxf\
	rel-simp-r-M-1-dyn.uxf\
	rel-simp-nr-M-1-static.uxf\
	rel-simp-r-M-1-static.uxf\
	rel-assoc-nr-1-1.uxf\
	rel-assoc-r-1-1.uxf\
	rel-assoc-nr-M-1-dyn.uxf\
	rel-assoc-r-M-1-dyn.uxf\
	rel-assoc-nr-M-1-static.uxf\
	rel-assoc-r-M-1-static.uxf\
	rel-assoc-nr-M-M-dyn.uxf\
	rel-assoc-r-M-M-dyn.uxf\
	rel-assoc-nr-M-M-static.uxf\
	rel-assoc-r-M-M-static.uxf\
	rel-gen-ref.uxf\
	rel-gen-union.uxf\
	assoc-decompose.uxf\
	wmc-class-diagram.uxf\
	wm-states.uxf\
	ct-states.uxf\
	main-loop.uxf\
	auto-translation.uxf\
	micca-translation.uxf\
	$(NULL)

IMAGES =\
	$(patsubst %.uxf,$(IMAGEDIR)/%.pdf,$(DIAGRAMS))\
	$(patsubst %.uxf,$(IMAGEDIR)/%.pdf,$(LSDIAGRAMS))\
	$(NULL)

TCLSRC	=\
     	$(patsubst %.aweb,%.tcl,$(DOCSRC))\
	$(NULL)

POSIXH	= micca_rt.h
POSIXC	= micca_rt.c
POSIXOBJ = micca_rt.o

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

TESTOPTS =\
	-verbose bet\
	-level debug\
	$(NULL)

.PHONY : all doc code tests runtests package

all : doc code tests package

doc : $(PDF)

code : $(CODEFILE)

tests : code $(TESTS)

runtests : tests
	cd $(TESTDIR) ; tclsh $(TESTS) $(TESTOPTS)

package : $(PKGDIR)/package-micca-$(VERSION)-tcl.zip

$(PKGDIR)/package-micca-$(VERSION)-tcl.zip : $(CODEFILE) $(CODEDIR)/tcl/pkgIndex.tcl
	teapot-pkg generate --output $(PKGDIR) $(CODEDIR)/tcl

clean :
	$(RM) $(CLEANFILES)

$(DOCSRC) : $(DOCPARTS)

$(PDF) : $(DOCSRC) $(DOCPARTS) $(EXTRAS) $(IMAGES)

$(TCLSRC) : $(DOCSRC) $(DOCPARTS)

$(TESTS) : $(DOCSRC) $(DOCPARTS)

$(CODEDIR)/tcl/micca.tcl : $(DOCSRC) $(DOCPARTS)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $@ $(DOCSRC)

$(CODEDIR)/tcl/micca_main.tcl : $(DOCSRC) $(DOCPARTS)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $@ $(DOCSRC)

$(DOCDIR)/%.pdf : %.aweb
	a2x $(A2XOPTS) --doctype=book  --format=pdf\
	    --destination-dir=$(DOCDIR)\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $<
	$(RM) $(DOCDIR)/*__[0-9].pdf

%.test : %.aweb
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $(TESTDIR)/$@ $<

$(IMAGEDIR)/platform-%.pdf : platform-%.uxf
	umlet -action=convert -format=pdf\
		-filename=$< -output=$(basename $@)-cvt
	pdftk $(basename $@)-cvt.pdf cat 1left output $@
	$(RM) $(basename $@)-cvt.pdf

$(IMAGEDIR)/%-translation.pdf : %-translation.uxf
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

#atangle $(ATANGLEOPTS) -line '#line %l% "%f%"' -root micca_rt_test.c -output $@ $<
#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
