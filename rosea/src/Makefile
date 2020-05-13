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
MODULEDIR = ../../modules
IMAGEDIR = ./images

vpath %.pdf $(DOCDIR)
vpath %.html $(DOCDIR)
vpath %.test $(TESTDIR)
vpath %.uxf $(IMAGEDIR)

PROGNAME = rosea
VERSION=1.10.1

DOCSRC 	=\
	$(PROGNAME).aweb\
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
	$(patsubst %.diag,$(IMAGEDIR)/%.png,$(SEQDIAG))\
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
	$(NULL)
#	-report\

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

.PHONY : all doc code tests runtests example clean package module

all : doc code tests example manual package module

doc : $(PDF)

code : $(TCLSRC) pkgIndex.tcl

tests : code $(TESTS)

example : $(TCLSRC) runwm.tcl

manual : $(MANDOC)

package : $(PKGDIR)/package-$(PROGNAME)-$(VERSION)-tcl.tm

module : $(MODULEDIR)/$(PROGNAME)-$(VERSION).tm

$(MODULEDIR)/$(PROGNAME)-$(VERSION).tm : $(TCLSRC)
	@mkdir -p $(MODULEDIR)
	mkmodule $(PROGNAME) $(VERSION) -script $^
	mv $(PROGNAME)-$(VERSION).tm $(MODULEDIR)

$(PKGDIR)/package-$(PROGNAME)-$(VERSION)-tcl.tm : $(TCLSRC) teapot.txt
	teapot-pkg generate --output $(PKGDIR) .

runtests : tests
	cd $(TESTDIR) ; tclsh $(TESTS) -verbose bet -level debug

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
	$(RM) $(DOCDIR)/rosea__*

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

$(IMAGEDIR)/%.png : $(IMAGEDIR)/%.diag
	seqdiag --antialias -T png -o $@ $<

$(MANSRC) : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $@ $<

$(MANDOC) : $(MANSRC)
	dtplite -o $@ html $<

builddoc :
	a2x $(A2XOPTS) --doctype=book  --format=pdf\
	    --destination-dir=$(DOCDIR)\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $(PROGNAME).aweb

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
