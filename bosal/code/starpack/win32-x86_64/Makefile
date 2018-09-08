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

BOSALDIR = ../../../src
DOCDIR = ../../../doc
TCLCODEDIR = ../../tcl

ASRC 	=\
	$(BOSALDIR)/bosal.aweb\
	$(BOSALDIR)/*.txt\
	$(NULL)

ATANGLEOPTS =\
	$(NULL)

.PHONY : all doc

all : bosal_main.tcl

bosal.tcl bosal_main.tcl : $(ASRC)
	make --directory $(BOSALDIR) code

doc :
	$(MAKE) --directory $(DOCDIR)

CLEANFILES =\
	$(NULL)

clean :
	$(RM) $(CLEANFILES)

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
