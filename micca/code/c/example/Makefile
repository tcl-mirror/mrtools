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
	$(MICCADIR)/micca.aweb\
	$(MICCADIR)/bibliography.txt\
	$(MICCADIR)/codeorg.txt\
	$(MICCADIR)/configure.txt\
	$(MICCADIR)/example.txt\
	$(MICCADIR)/generate.txt\
	$(MICCADIR)/litprog.txt\
	$(MICCADIR)/platform.txt\
	$(MICCADIR)/preface.txt\
	$(MICCADIR)/runtime.txt\
	$(MICCADIR)/translation.txt\
	$(NULL)

ATANGLEOPTS =\
	$(NULL)

$(MICCADIR)/wmctrl-trace.txt : wmctrl
	./wmctrl | tee $@

wmctrl : wmctrl.o micca_rt.o

wmctrl.o : wmctrl.c wmctrl.h micca_rt.h

wmctrl.c : wmctrl.micca wmctrl_pop.micca build_wmctrl.tcl
	tclsh build_wmctrl.tcl

build_wmctrl.tcl : $(DOCSRC)
	cd $(MICCADIR) ; atangle $(ATANGLEOPTS) -root build_wmctrl.tcl\
	    -output build_wmctrl.tcl micca.aweb
	mv $(MICCADIR)/$@ .

wmctrl.micca : $(DOCSRC)
	cd $(MICCADIR) ; atangle $(ATANGLEOPTS) -root wmctrl.micca\
	    -output wmctrl.micca micca.aweb
	mv $(MICCADIR)/$@ .

wmctrl_pop.micca : $(DOCSRC)
	cd $(MICCADIR) ; atangle $(ATANGLEOPTS) -root wmctrl_pop.micca\
	    -output wmctrl_pop.micca micca.aweb
	mv $(MICCADIR)/$@ .

micca_rt.o : micca_rt.c micca_rt.h

micca_rt.h : $(DOCSRC)
	cd $(MICCADIR) ; atangle $(ATANGLEOPTS) -root micca_rt_posix.h\
	    	-output $@ micca.aweb
	mv $(MICCADIR)/micca_rt.h .

micca_rt.c : $(DOCSRC)
	cd $(MICCADIR) ; atangle $(ATANGLEOPTS) -root micca_rt_posix.c -output $@ micca.aweb
	mv $(MICCADIR)/micca_rt.c .

CLEANFILES =\
	wmctrl\
	*.o\
	wmctrl.c\
	wmctrl.h\
	wmctrl.micca\
	wmctrl_pop.micca\
	build_wmctrl.tcl\
	micca_rt.h\
	micca_rt.c\
	$(NULL)

clean :
	$(RM) $(CLEANFILES)

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
