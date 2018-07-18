#*++
# Copyright:
#
# Project:
#
# Module:
#*--

DOCDIR	= ../doc

vpath %.pdf $(DOCDIR)

VPATH	=\
	./domains\
	$(NULL)

PROG	=\
	ls_harness\
	$(NULL)

DOMAINS =\
	lube\
	sio\
	$(NULL)

MICCA	=\
	$(patsubst %,%.micca,$(DOMAINS))\
	$(NULL)

MIFLAGS	=\
	$(NULL)

GENSRCS =\
	$(patsubst %,%.c,$(DOMAINS))\
	$(NULL)

GENHDRS =\
	$(patsubst %,%.h,$(DOMAINS))\
	$(NULL)

SAVED	=\
	$(patsubst %,%.ral,$(DOMAINS))\
	$(NULL)

SRCS	=\
	harness.c\
	$(patsubst %.micca,%.c,$(MICCA))\
	micca_rt.c\
	lube_sio_bridge.c\
	lube_stubs.c\
	sio_stubs.c\
	$(NULL)

OBJS	=\
	$(patsubst %.c,%.o,$(SRCS))\
	$(NULL)

TEST_SRC	=\
	bosal-test.aweb\
	$(NULL)

TEST_SCRIPT	=\
	$(patsubst %.aweb,%.test,$(TEST_SRC))\
	$(NULL)

CPPFLAGS=\
	-DMRT_INSTRUMENT\
	-DBOSAL\
	$(NULL)

CFLAGS	=\
	-std=c11\
	-g3\
	-Wall\
	$(NULL)

LDFLAGS = -g --coverage

PDF 	=\
     	$(DOCDIR)/$(patsubst %.aweb,%.pdf,$(TEST_SRC))\
     	$(NULL)

DOCINFO	=\
	$(patsubst %.aweb,%-docinfo.xml,$(TEST_SRC))\
	docinfo.xml\
	$(NULL)

EXTRAS =\
	$(DOCINFO)\
	$(NULL)

ASCIIDOC_ATTRS =\
	docinfo2\
	$(NULL)

DBLATEX_PARAMS =\
	bibliography.numbered=0\
	index.numbered=0\
	doc.publisher.show=0\
	doc.lot.show=figure,table\
	toc.section.depth=3\
	doc.section.depth=0\
	$(NULL)

DBLATEX_OPTS =\
	--dblatex-opts="$(patsubst %,--param=%,$(DBLATEX_PARAMS))"\
	$(NULL)

ASCIIDOC_OPTS =\
	$(patsubst %,--attribute=%,$(ASCIIDOC_ATTRS))\
	$(NULL)

all : $(PROG) tests runtests doc

$(PROG) : $(OBJS)
	gcc -o $@ $(LDFLAGS) $(OBJS)

tests : $(TEST_SCRIPT)

runtests : $(PROG) $(TEST_SCRIPT)
	./$(TEST_SCRIPT) -verbose bet -level notice

$(TEST_SCRIPT) : bosal-test.aweb
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $@ $<
	chmod +x $@

harness.o : harness.c micca_rt.h micca_rt_internal.h bosal.h

harness.o : CFLAGS+=--coverage

harness.c : $(SAVED) ../src/bosal.aweb ../src/*.txt
	make -C ../src code
	tclsh ../code/tcl/bosal_main.tcl -output $@ -main $(SAVED)

lube.o : lube.h lube.c micca_rt.h micca_rt_internal.h

sio.o : sio.h sio.c micca_rt.h micca_rt_internal.h

micca_rt.o : micca_rt.c micca_rt.h micca_rt_internal.h

lube_sio_bridge.o : lube_sio_bridge.c lube.h sio.h

lube_stubs.o : lube_stubs.c lube.h

sio_stubs.o : sio_stubs.c sio.h

bosal.h :
	make -C ../src code
	tclsh ../code/tcl/bosal_main.tcl -header

micca_rt.c micca_rt.h micca_rt_internal.h :
	micca -posix

doc : $(PDF)

$(PDF) : $(TEST_SRC) $(EXTRAS)

CLEANFILES	=\
		$(PROG)\
		$(OBJS)\
		$(GENSRCS)\
		$(GENHDRS)\
		$(SAVED)\
		$(TEST_SCRIPT)\
		harness.c\
		micca_rt*\
		bosal.h\
		*.gcno\
		*.gcda\
		*.gcov\
		core\
		$(NULL)

.PHONY : clean
clean :
	-$(RM) $(LIB) $(CLEANFILES)

%.c %.h %.ral : %.micca
	micca $(MIFLAGS) -save $(basename $(notdir $<)).ral $<

$(DOCDIR)/%.pdf : %.aweb
	a2x $(A2XOPTS) --doctype=article  --format=pdf\
	    --destination-dir=$(DOCDIR)\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $<

# vim:set ts=8 sw=8 sts=8 noexpandtab:
