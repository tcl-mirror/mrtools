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

MICCADIR = ../../../src

ASRC 	=\
	$(MICCADIR)/micca.aweb\
	$(MICCADIR)/*.txt\
	$(NULL)

HARNESS	=\
	micca_tack.h\
	micca_tack.c\
	$(NULL)

.PHONY : all

all : $(HARNESS)

micca_tack.h : $(ASRC)
	cd $(MICCADIR) ; atangle $(ATANGLEOPTS) -root $@ -output $@ micca.aweb
	mv $(MICCADIR)/micca_tack.h .

micca_tack.c : $(ASRC)
	cd $(MICCADIR) ; atangle $(ATANGLEOPTS) -root $@ -output $@ micca.aweb
	mv $(MICCADIR)/micca_tack.c .

CLEANFILES =\
	$(HARNESS)\
	$(NULL)

clean :
	$(RM) $(CLEANFILES)

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
