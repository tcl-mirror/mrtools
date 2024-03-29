#
#*++
# PROJECT:
#	dbusclient
# MODULE:
#	Make file for dbusclient package
#
# ABSTRACT:
#
#*--
#

DOCDIR	= ../doc
MANDIR	= $(DOCDIR)/man
IMAGEDIR = ./figures
CODEDIR	= ../code
TESTDIR = ../test

VERSION=1.0

vpath %.pdf $(DOCDIR)
vpath %.uxf $(IMAGEDIR)
vpath %.tcl $(CODEDIR)

PKGNAME =\
	dbusclient\
	$(NULL)

DOCSRC 	=\
	$(patsubst %,%.aweb,$(PKGNAME))\
	$(NULL)

DOCFILE =\
	  $(DOCDIR)/$(patsubst %.aweb,%.pdf,$(DOCSRC))\
	  $(NULL)

CODEFILE =\
	  $(CODEDIR)/$(patsubst %.aweb,%.tcl,$(DOCSRC))\
	  $(NULL)

MANFILE =\
	  $(MANDIR)/$(patsubst %.aweb,%.man,$(DOCSRC))\
	  $(NULL)

MODULEFILE =\
	  $(CODEDIR)/$(patsubst %,%-$(VERSION).tm,$(PKGNAME))\
	  $(NULL)

OBJFILE =\
	  $(BUILDDIR)/$(patsubst %.aweb,%.o,$(DOCSRC))\
	  $(NULL)

TESTFILE =\
	  $(TESTDIR)/$(patsubst %.aweb,%.test,$(DOCSRC))\
	  $(NULL)

DOCPARTS=\
	introduction.txt\
	package.txt\
	codeorg.txt\
	copyright-info.txt\
	edit-warning.txt\
	litprog.txt\
	$(NULL)

DIAGRAMS =\
	service-metadata.uxf\
	trace-metadata.uxf\
	$(NULL)

LSDIAGRAMS =\
	$(NULL)

IMAGES =\
	$(patsubst %.uxf,$(IMAGEDIR)/%.pdf,$(DIAGRAMS))\
	$(patsubst %.uxf,$(IMAGEDIR)/%.pdf,$(LSDIAGRAMS))\
	$(NULL)

PDF 	=\
     	$(DOCDIR)/$(patsubst %.aweb,%.pdf,$(DOCSRC))\
     	$(NULL)

CLEANFILES =\
	$(IMAGES)\
	$(PDF)\
	$(NULL)

A2XOPTS =\
	--verbose\
	$(NULL)

# --verbose\

ATANGLEOPTS =\
	$(NULL)

# -line '\#line %l% "%f%"'

DBLATEX_PARAMS =\
	bibliography.numbered=0\
	index.numbered=0\
	doc.publisher.show=0\
	doc.lot.show=figure,table,example\
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
	-level notice\
	$(NULL)

.PHONY : all doc code runtests module man clean

all : doc module man

doc : $(PDF)

code : $(CODEFILE)

module : $(MODULEFILE)

man : $(MANFILE)

$(MODULEFILE) : $(CODEFILE)
	@mkdir -p $(CODEDIR)
	cd $(CODEDIR) ; mkmodule $(PKGNAME) $(VERSION)\
		-script $(notdir $(CODEFILE))

runtests : $(TESTFILE) code $(TESTDIR)/test-server.tcl
	cd $(TESTDIR) ; tclsh $(notdir $(TESTFILE)) $(TESTOPTS)

clean :
	$(RM) $(CLEANFILES)

$(DOCSRC) : $(DOCPARTS)

$(DOCFILE) : $(DOCSRC) $(DOCPARTS) $(EXTRAS) $(IMAGES)
	@mkdir -p $(DOCDIR)
	a2x $(A2XOPTS) --doctype=article  --format=pdf\
	    --destination-dir=$(DOCDIR)\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $<
	$(RM) $(DOCDIR)/*__[0-9].pdf

$(CODEFILE) : $(DOCSRC) $(DOCPARTS)
	@mkdir -p $(CODEDIR)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $@ $(DOCSRC)

$(TESTFILE) : $(DOCSRC) $(DOCPARTS)
	@mkdir -p $(TESTDIR)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $@ $(DOCSRC)

$(TESTDIR)/test-server.tcl : $(DOCSRC) $(DOCPARTS)
	@mkdir -p $(TESTDIR)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $@ $(DOCSRC)
	chmod +x $@

$(MANFILE) : $(DOCSRC) $(DOCPARTS)
	@mkdir -p $(MANDIR)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $@ $(DOCSRC)

$(IMAGEDIR)/%.pdf : %.uxf
	umlet -action=convert -format=pdf\
		-filename=$< -output=$(basename $@)


#
# vim: sw=8 ts=8 sts=8 noexpandtab
#
