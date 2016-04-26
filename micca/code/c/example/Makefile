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

CFLAGS	= -std=c11 -g -Wall -Og
CPPFLAGS = -D_POSIX_C_SOURCE=200112L -D_ISOC11_SOURCE
LDFLAGS = -g

# CFLAGS	= -std=c11 -Wall -O2
# CPPFLAGS = -DNDEBUG -D_POSIX_C_SOURCE=200112L -D_ISOC11_SOURCE
# LDFLAGS =

DOCSRC 	=\
	$(MICCADIR)/example.txt\
	$(NULL)

ATANGLEOPTS =\
	$(NULL)

../../../src/wmctrl-trace.txt : wmctrl
	./wmctrl | tee $@

wmctrl : wmctrl.o micca_rt.o

wmctrl.o : wmctrl.c wmctrl.h micca_rt.h

wmctrl.c : wmctrl.micca wmctrl_pop.micca build_wmctrl.tcl
	tclsh build_wmctrl.tcl

build_wmctrl.tcl : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

wmctrl.micca : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

wmctrl_pop.micca : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

micca_rt.o : micca_rt.c micca_rt.h

CLEANFILES =\
	wmctrl\
	*.o\
	wmctrl.c\
	wmctrl.h\
	wmctrl.micca\
	wmctrl_pop.micca\
	build_wmctrl.tcl\
	../../../src/wmctrl-trace.txt\
	$(NULL)

clean :
	$(RM) $(CLEANFILES)

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
