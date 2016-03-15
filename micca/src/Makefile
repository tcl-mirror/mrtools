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
POSIXDIR = $(CODEDIR)/c/posix

CFLAGS	= -std=c11 -g -L$(HOME)/local/lib
CPPFLAGS = -D_POSIX_C_SOURCE=200112L -D_ISOC11_SOURCE

vpath %.pdf $(DOCDIR)
vpath %.html $(DOCDIR)
vpath %.test $(TESTDIR)
vpath %.uxf $(IMAGEDIR)
vpath %.tcl $(CODEDIR)/tcl

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
	pointer-example.uxf\
	pointer-set-example.uxf\
	assoc-decompose.uxf\
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
	toc.section.depth=2\
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
.PHONY : posixcode posixh posixc

all : doc code tests

doc : $(PDF)

code : $(TCLSRC)

tests : code $(TESTS)

runtests : tests
	cd $(TESTDIR) ; tclsh $(TESTS) -verbose bet -level debug

posixcode : $(POSIXOBJ)

$(POSIXOBJ) : posixc posixh

posixc : $(POSIXC)

posixh : $(POSIXH)

$(POSIXOBJ) : $(POSIXH) $(POSIXC)

$(POSIXH) : $(DOCSRC) $(DOCPARTS)
	atangle $(ATANGLEOPTS) -line '#line %l% "%f%"' -root micca_rt_posix.h -output $@ $<
$(POSIXC) : $(DOCSRC) $(DOCPARTS)
	atangle $(ATANGLEOPTS) -line '#line %l% "%f%"' -root micca_rt_posix.c -output $@ $<
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

mrt_interface.h : runtime.txt

mrt_implementation.c : runtime.txt

%.tcl : %.aweb
	atangle $(ATANGLEOPTS) -root $@ -output $(CODEDIR)/tcl/$@ $<

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

rttests : $(POSIXDIR)/micca_rt_test

runrttests : rttests
	$(POSIXDIR)/micca_rt_test
	gcov micca_rt_test.c

$(POSIXDIR)/micca_rt_test : CPPFLAGS += -I$(HOME)/local/include \
    	-fprofile-arcs -ftest-coverage
$(POSIXDIR)/micca_rt_test : LOADLIBES = $(HOME)/local/lib/libcunit.a

$(POSIXDIR)/micca_rt_test : $(POSIXDIR)/micca_rt_test.c

$(POSIXDIR)/micca_rt_test.c : $(POSIXC) $(POSIXH)

$(POSIXDIR)/micca_rt_test.c : $(DOCSRC) $(DOCPARTS)
	atangle $(ATANGLEOPTS) -root micca_rt_test.c -output $@ $<

#atangle $(ATANGLEOPTS) -line '#line %l% "%f%"' -root micca_rt_test.c -output $@ $<
#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
