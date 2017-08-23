DIAGRAMS =\
	R4.uxf\
	wm-states.uxf\
	wm-washing-state.uxf\
	$(NULL)

IMAGES =\
	$(patsubst %.uxf,%.pdf,$(DIAGRAMS))\
	$(NULL)

all : confpaper.pdf

confpaper.pdf : confpaper.me $(IMAGES)

spell : confpaper.me
	aspell --mode=nroff check confpaper.me

# Using groff with the PDF driver so we can force the
# embedding of fonts (-P -e), per the Tcl conference request.
%.pdf : %.me
	groff -Tpdf -spt -me -mpdfmark -f H -P -e $< > $@

# Need to process the output of umlet through pdftk to get it
# to load properly. Probably a gropdf issue parsing the
# PDF produced by umlet.
PDFOPTS	=\
	-dEPSCrop\
	$(NULL)
%.pdf : %.uxf
	umlet -action=convert -format=eps -filename=$< -output=$(basename $@)
	ps2pdf $(PDFOPTS) $(basename $@).eps
	$(RM) $(basename $@).eps

CLEANFILES =\
	confpaper.pdf\
	$(IMAGES)\
	*.bak\
	$(NULL)

clean :
	$(RM) $(CLEANFILES)



# vi: sw=8 ts=8 sts=8 noexpandtab:
