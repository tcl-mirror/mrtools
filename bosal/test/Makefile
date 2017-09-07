#*++
# Copyright:
#
# Project:
#
# Module:
#*--
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
	-stubexternalops\
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
	main.c\
	harness.c\
	$(patsubst %.micca,%.c,$(MICCA))\
	micca_rt.c\
	$(NULL)

OBJS	=\
	$(patsubst %.c,%.o,$(SRCS))\
	$(NULL)

CPPFLAGS=\
	-DMRT_INSTRUMENT\
	$(NULL)

CFLAGS	=\
	-std=c11\
	-g3\
	-Wall\
	$(NULL)

LDFLAGS = -g --coverage

all : $(PROG) tests runtests

$(PROG) : $(OBJS)
	gcc -o $@ $(LDFLAGS) $(OBJS)

tests : bosal.test

runtests : $(PROG) bosal.test
	tclsh bosal.test -verbose bet -level notice

bosal.test : ../src/bosal.aweb ../src/*.txt
	make -C ../src tests

main.c : bosal.h micca_rt.h

harness.o : harness.c micca_rt.h micca_rt_internal.h

harness.o : CFLAGS+=--coverage

harness.c : $(SAVED) ../src/bosal.aweb ../src/*.txt
	make -C ../src code
	tclsh ../code/tcl/bosal_main.tcl -output $@ $(SAVED)

lube.o : lube.h lube.c micca_rt.h micca_rt_internal.h

sio.o : sio.h sio.c micca_rt.h micca_rt_internal.h

micca_rt.o : micca_rt.c micca_rt.h micca_rt_internal.h

bosal.h :
	make -C ../src code
	tclsh ../code/tcl/bosal_main.tcl -header

micca_rt.c micca_rt.h micca_rt_internal.h :
	micca -posix

CLEANFILES	=\
		$(PROG)\
		$(OBJS)\
		$(GENSRCS)\
		$(GENHDRS)\
		$(SAVED)\
		harness.c\
		micca_rt*\
		bosal.h\
		$(NULL)

.PHONY : clean
clean :
	-$(RM) $(LIB) $(CLEANFILES)

%.c %.h %.ral : %.micca
	micca $(MIFLAGS) -save $(basename $(notdir $<)).ral $<

# vim:set ts=8 sw=8 sts=8 noexpandtab:
