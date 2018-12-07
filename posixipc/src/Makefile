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
IMAGEDIR = ./images
CODEDIR	= ../tea/generic
BUILDDIR = ../tea/build
TESTDIR = ../test

VERSION=1.0

DOCSRC 	=\
	posixipc.aweb\
	$(NULL)

DOCFILE =\
	  $(DOCDIR)/$(patsubst %.aweb,%.pdf,$(DOCSRC))\
	  $(NULL)

CODEFILE =\
	  $(CODEDIR)/$(patsubst %.aweb,%.c,$(DOCSRC))\
	  $(NULL)

OBJFILE =\
	  $(BUILDDIR)/$(patsubst %.aweb,%.o,$(DOCSRC))\
	  $(NULL)

LIBFILE =\
	  $(BUILDDIR)/$(patsubst %.aweb,lib%$(VERSION).so,$(DOCSRC))\
	  $(NULL)

TESTFILE =\
	  $(TESTDIR)/$(patsubst %.aweb,%.test,$(DOCSRC))\
	  $(NULL)

DOCPARTS=\
	introduction.txt\
	package.txt\
	message_queue.txt\
	semaphore.txt\
	shared_memory.txt\
	codeorg.txt\
	copyright-info.txt\
	edit-warning.txt\
	litprog.txt\
	$(NULL)

DIAGRAMS =\
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
	-level debug\
	$(NULL)

.PHONY : all doc code test coverage

all : doc code

doc : $(PDF)

code : $(CODEFILE)

test : $(TESTFILE) $(LIBFILE)
	cd $(TESTDIR) ; tclsh $(notdir $(TESTFILE)) $(TESTOPTS)

coverage :
	$(RM) $(LIBFILE)
	$(RM) $(OBJFILE)
	$(RM) $(BUILDDIR)/*.gc*
	cd $(BUILDDIR) ; make CFLAGS+=--coverage binaries
	cd $(TESTDIR) ; tclsh $(notdir $(TESTFILE)) $(TESTOPTS)
	cd $(BUILDDIR) ;\
		mkdir --parents coverage ;\
		lcov --quiet --capture --directory .\
			--output-file capture_results.info ;\
		genhtml --quiet --title 'posixipc test coverage'\
			--output-directory coverage capture_results.info

clean :
	$(RM) $(CLEANFILES)

$(LIBFILE) : $(CODEFILE)
	cd $(BUILDDIR) ; make --quiet binaries

$(DOCSRC) : $(DOCPARTS)

$(DOCFILE) : $(DOCSRC) $(DOCPARTS) $(EXTRAS) $(IMAGES)
	a2x $(A2XOPTS) --doctype=article  --format=pdf\
	    --destination-dir=$(DOCDIR)\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $<
	$(RM) $(DOCDIR)/*__[0-9].pdf

$(CODEFILE) : $(DOCSRC) $(DOCPARTS)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $@ $(DOCSRC)

$(TESTFILE) : $(DOCSRC) $(DOCPARTS)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $@ $(DOCSRC)


#
# vim: sw=8 ts=8 sts=8 noexpandtab
#
