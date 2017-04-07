#
#*++
# PROJECT:
#	Tools
# MODULE:
#	micca
# ABSTRACT:
#
#*--
#

SRCDIR	= ../../src

VPATH = $(SRCDIR)

DOCSRC 	=\
	$(SRCDIR)/micca.aweb\
	$(NULL)

CODEFILES =\
	  micca.tcl\
	  micca_main.tcl\
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

CLEANFILES =\
	$(CODEFILES)\
	$(NULL)

ATANGLEOPTS =\
	$(NULL)

ifeq ($(OS),Windows_NT)
THISDIR = $(shell cygpath -m $(shell pwd))
else
THISDIR = $(shell pwd)
endif

.PHONY : all

all : $(CODEFILES)

clean :
	$(RM) $(CLEANFILES)

$(DOCSRC) : $(DOCPARTS)

micca.tcl : $(DOCSRC) $(DOCPARTS)
	cd $(SRCDIR) ;\
	atangle $(ATANGLEOPTS) -root $@ -output $(THISDIR)/$@ $(notdir $<)


micca_main.tcl : $(DOCSRC) $(DOCPARTS)
	cd $(SRCDIR) ;\
	atangle $(ATANGLEOPTS) -root $@ -output $(THISDIR)/$@ $(notdir $<)

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
