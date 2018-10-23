#*++
# Project:
#   micca
#
# Module:
#*--
VPATH	=\
	$(NULL)

PROG	=\
	lube-sio-harness\
	$(NULL)

MICCA	=\
	lube.micca\
	sio.micca\
	$(NULL)

MSAVE	=\
	$(patsubst %.micca,%.ral,$(MICCA))\
	$(NULL)

BRIDGES =\
	lube_sio_bridge.c\
	$(NULL)

SRCS	=\
	harness.c\
	$(patsubst %.micca,%.c,$(MICCA))\
	$(BRIDGES)\
	sio_stubs.c\
	lube_stubs.c\
	micca_rt.c\
	$(NULL)

OBJS	=\
	$(patsubst %.c,%.o,$(SRCS))\
	$(NULL)

CPPFLAGS=\
	-D_ISOC11_SOURCE\
	-DMRT_INSTRUMENT\
	-DBOSAL\
	$(NULL)

CFLAGS	=\
	-std=c11\
	-g3\
	-Wall\
	-Og\
	$(NULL)

LDFLAGS	= -g --coverage

all : coverage

runtests : lube-sio-test.tcl $(PROG)
	./lube-sio-test.tcl ./$(PROG)

coverage : runtests
	lcov --quiet --capture --directory .\
	    --output-file test_results.info
	genhtml --quiet --title 'micca rt test coverage'\
	    --output-directory test_results test_results.info

$(PROG) : $(OBJS)
	$(LINK.c) -o $@ $^

harness.c : $(MSAVE)
	bosal -main -output harness.c $(MSAVE)

harness.o : harness.c micca_rt.h micca_rt_internal.h bosal.h

lube.o : CFLAGS += --coverage

lube.o : lube.c lube.h micca_rt.h micca_rt_internal.h

lube.h lube.c lube.ral : lube.micca
	micca -save lube.ral $<

sio.o : CFLAGS += --coverage

sio.o : sio.c sio.h micca_rt.h micca_rt_internal.h

sio.h sio.c sio.ral : sio.micca
	micca -save sio.ral $<

lube_sio_bridge.o : lube_sio_bridge.c sio.h lube.h micca_rt.h

micca_rt.o : micca_rt.c micca_rt.h micca_rt_internal.h

lube_stubs.o : lube_stubs.c lube.h

sio_stubs.o : sio_stubs.c sio.h

micca_rt.c micca_rt.h micca_rt_internal.h :
	micca -posix

bosal.h :
	bosal -header

CLEANFILES	=\
		$(PROG)\
		$(OBJS)\
		lube.c\
		lube.h\
		lube-sio-seq.*\
		sio.c\
		sio.h\
		bosal.h\
		harness.c\
		micca_rt*\
		test_results.info\
		*.ral\
		*.sqlite*\
		*.gcov\
		*.gcno\
		*.gcda\
		$(NULL)

.PHONY : clean
clean :
	-$(RM) $(LIB) $(CLEANFILES)

# vim:set ts=8 sw=8 sts=8 noexpandtab:
