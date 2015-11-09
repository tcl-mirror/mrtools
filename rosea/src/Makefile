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

VERSION=1.4

DOCSRC 	=\
	rosea.aweb\
	$(NULL)

DIAGRAMS =\
	assoc-link.uxf\
	partition-link.uxf\
	correl-link.uxf\
	link-classes.uxf\
	trace-schema.uxf\
	wmc-class-diagram.uxf\
	wm-states.uxf\
	arch-class-diagram.uxf\
	ref-links.uxf\
	assoc-ref-links.uxf\
	gen-links.uxf\
	config-domain.uxf\
	$(NULL)

LSDIAGRAMS =\
	config-classes.uxf\
	config-relation.uxf\
	config-statemodel.uxf\
	config-transition.uxf\
	config-event.uxf\
	ct-states.uxf\
	$(NULL)

SEQDIAG	=\
	wmctrl-seqdiag.diag\
	$(NULL)

IMAGES =\
	$(patsubst %.uxf,$(IMAGEDIR)/%.pdf,$(DIAGRAMS))\
	$(patsubst %.uxf,$(IMAGEDIR)/%.pdf,$(LSDIAGRAMS))\
	$(NULL)

SEQIMAGES=\
	$(patsubst %.diag,$(IMAGEDIR)/%.pdf,$(SEQDIAG))\
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
	$(SEQIMAGES)\
	$(PDF)\
	$(TESTDIR)/$(TESTS)\
	wmctrl-trace.txt\
	wmctrl.tcl\
	runwm.tcl\
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

.PHONY : all doc code tests runtests example clean package

all : doc code tests example manual package

doc : $(PDF)

code : $(TCLSRC) pkgIndex.tcl

tests : code $(TESTS)

example : $(TCLSRC) runwm.tcl

manual : $(MANDOC)

package : $(PKGDIR)/package-rosea-$(VERSION)-tcl.tm

$(PKGDIR)/package-rosea-$(VERSION)-tcl.tm : $(TCLSRC) teapot.txt
	teapot-pkg generate --output $(PKGDIR) .

runtests : tests
	cd $(TESTDIR) ; tclsh $(TESTS) -verbose bet -level info

runexample : example
	tclsh runwm.tcl | tee wmctrl-trace.txt

wmctrl-trace.txt $(IMAGEDIR)/wmctrl-seqdiag.diag : runwm.tcl wmctrl.tcl $(TCLSRC)
	tclsh runwm.tcl | tee wmctrl-trace.txt

clean :
	$(RM) $(CLEANFILES)

$(PDF) : $(DOCSRC) $(EXTRAS) $(IMAGES) wmctrl-trace.txt $(SEQIMAGES)

$(TCLSRC) : $(DOCSRC)

pkgIndex.tcl : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

wmctrl.tcl : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

runwm.tcl : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

$(DOCDIR)/%.pdf : %.aweb
	a2x $(A2XOPTS) --doctype=book  --format=pdf\
	    --destination-dir=$(DOCDIR)\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $<
	$(RM) $(DOCDIR)/*__[0-9].pdf

%.tcl : %.aweb
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

%.test : %.aweb
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $(TESTDIR)/$@ $<

$(IMAGEDIR)/config-domain.pdf : $(IMAGEDIR)/config-domain.uxf
	umlet -action=convert -format=pdf\
		-filename=$< -output=$(basename $@)

$(IMAGEDIR)/config-%.pdf : config-%.uxf
	umlet -action=convert -format=pdf\
		-filename=$< -output=$(basename $@)-cvt
	pdftk $(basename $@)-cvt.pdf cat 1left output $@
	$(RM) $(basename $@)-cvt.pdf

$(IMAGEDIR)/ct-states.pdf : ct-states.uxf
	umlet -action=convert -format=pdf\
		-filename=$< -output=$(basename $@)-cvt
	pdftk $(basename $@)-cvt.pdf cat 1left output $@
	$(RM) $(basename $@)-cvt.pdf

$(IMAGEDIR)/%.pdf : %.uxf
	umlet -action=convert -format=pdf\
		-filename=$< -output=$(basename $@)

$(IMAGEDIR)/%.pdf : $(IMAGEDIR)/%.diag
	seqdiag --antialias -T pdf -o $@ $<

$(MANSRC) : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $@ $<

$(MANDOC) : $(MANSRC)
	dtplite -o $@ html $<
#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
