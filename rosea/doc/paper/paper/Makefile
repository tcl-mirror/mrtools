DIAGRAMS =\
	R4.uxf\
	wm-states.uxf\
	wm-washing-state.uxf\
	$(NULL)

IMAGES =\
	$(patsubst %.uxf,%.eps,$(DIAGRAMS))\
	$(NULL)

all : confpaper.pdf

confpaper.pdf : confpaper.me $(IMAGES)

spell : confpaper.me
	aspell --mode=nroff check confpaper.me

%.pdf : %.me
	pdfroff -spt -dpaper=Letter -me -mpdfmark -f H --no-toc-relocation $< > $@

%.eps : %.uxf
	umlet -action=convert -format=eps\
		-filename=$< -output=$(basename $@)

CLEANFILES =\
	*.pdf\
	$(IMAGES)\
	$(NULL)

clean :
	$(RM) $(CLEANFILES)



# vi: sw=8 ts=8 sts=8 noexpandtab:
