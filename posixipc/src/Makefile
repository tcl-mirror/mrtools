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
TESTDIR = ../test

VERSION=1.0

vpath %.pdf $(DOCDIR)
vpath %.html $(DOCDIR)
vpath %.uxf $(IMAGEDIR)
vpath %.test $(TESTDIR)

DOCSRC 	=\
	posixipc.aweb\
	$(NULL)

DOCFILE =\
	  $(DOCDIR)/$(patsubst %.aweb,%.pdf,$(DOCSRC))\
	  $(NULL)

CODEFILE =\
	  $(CODEDIR)/$(patsubst %.aweb,%.c,$(DOCSRC))\
	  $(NULL)

LIBFILE =\
	  ../tea/build/$(patsubst %.aweb,lib%$(VERSION).so,$(DOCSRC))\
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
	-line '\#line %l% "%f%"'\
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

.PHONY : all doc code test

all : doc code

doc : $(PDF)

code : $(CODEFILE)

lib : $(LIBFILE)

$(LIBFILE) : $(CODEFILE)
	cd ../tea/build ; make binaries

test : $(TESTFILE) $(LIBFILE)
	cd $(TESTDIR) ; tclsh $(patsubst %.aweb,%.test,$(DOCSRC))

clean :
	$(RM) $(CLEANFILES)

$(DOCSRC) : $(DOCPARTS)

$(DOCFILE) : $(DOCSRC) $(EXTRAS) $(IMAGES)
	a2x $(A2XOPTS) --doctype=article  --format=pdf\
	    --destination-dir=$(DOCDIR)\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $<
	$(RM) $(DOCDIR)/*__[0-9].pdf

$(CODEFILE) : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $@ $(DOCSRC)

$(TESTFILE) : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $@ $(DOCSRC)


#
# vim: sw=8 ts=8 sts=8 noexpandtab
#
