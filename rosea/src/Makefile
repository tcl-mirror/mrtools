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
IMAGEDIR = ./images

vpath %.pdf $(DOCDIR)
vpath %.html $(DOCDIR)
vpath %.test $(TESTDIR)
vpath %.uxf $(IMAGEDIR)

DOCSRC 	=\
	rosea.aweb\
	$(NULL)

DIAGRAMS =\
	assoc-link.uxf\
	partition-link.uxf\
	correl-link.uxf\
	link-classes.uxf\
	trace-schema.uxf\
	$(NULL)

LSDIAGRAMS =\
	config-domain.uxf\
	config-classes.uxf\
	config-relation.uxf\
	config-statemodel.uxf\
	config-transition.uxf\
	config-event.uxf\
	$(NULL)

SEQDIAG	=\
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

.PHONY : all doc code tests runtests example clean

all : doc code tests example

doc : $(PDF)

code : $(TCLSRC) pkgIndex.tcl

tests : code $(TESTS)

example : $(TCLSRC) wmctrl.tcl

runtests : tests
	cd $(TESTDIR) ; tclsh $(TESTS) -verbose bet -level info

runexample : example
	tclsh wmctrl.tcl | tee wmctrl-trace.txt

wmctrl-trace.txt : wmctrl.tcl $(TCLSRC)
	tclsh wmctrl.tcl | tee wmctrl-trace.txt

clean :
	$(RM) $(CLEANFILES)

$(PDF) : $(DOCSRC) $(EXTRAS) $(IMAGES)

$(TCLSRC) : $(DOCSRC)

pkgIndex.tcl : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

wmctrl.tcl : $(DOCSRC)
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

$(IMAGEDIR)/config-%.pdf : config-%.uxf
	umlet -action=convert -format=pdf\
		-filename=$< -output=$(basename $@)-cvt
	pdftk $(basename $@)-cvt.pdf cat 1left output $@
	$(RM) $(basename $@)-cvt.pdf

$(IMAGEDIR)/%.pdf : %.uxf
	umlet -action=convert -format=pdf\
		-filename=$< -output=$(basename $@)
#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
