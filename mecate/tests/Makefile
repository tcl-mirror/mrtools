#*++
# Copyright:
#
# Project:
#
# Module:
#*--

PROG	=\
	bstore_harness\
	$(NULL)

DOMAINS =\
	simplebookstore\
	sbs_population\
	$(NULL)

MICCA	=\
	$(patsubst %,%.micca,$(DOMAINS))\
	$(NULL)

MSAVE	=\
	bookstore.ral\
	$(NULL)

MIFLAGS	=\
	-stubexternalops\
	-save $(MSAVE)\
	$(NULL)

BFLAGS	=\
	-main\
	-output harness.c\
	$(NULL)

GENSRCS =\
	bookstore.c\
	$(NULL)

GENHDRS =\
	bookstore.h\
	$(NULL)

SAVED	=\
	bookstore.ral\
	$(NULL)

SRCS	=\
	harness.c\
	bookstore.c\
	micca_rt.c\
	$(NULL)

OBJS	=\
	$(patsubst %.c,%.o,$(SRCS))\
	$(NULL)

CPPFLAGS=\
	-DMRT_INSTRUMENT\
	-DBOSAL\
	-DMRT_ECB_PARAM_SIZE=64\
	$(NULL)

CFLAGS	=\
	-std=c11\
	-g3\
	-Wall\
	$(NULL)

LDFLAGS = -g --coverage

all : $(PROG) runtests coverage

runtests :  $(PROG)
	make -C ../src tests
	tclsh mecate.test -verbose bet

coverage : runtests
	lcov --quiet --capture --directory .\
	    --output-file bookstore_results.info
	genhtml --quiet --title 'bookstore test coverage'\
	    --output-directory bookstore_results bookstore_results.info

$(PROG) : $(OBJS)
	gcc -o $@ $(LDFLAGS) $(OBJS)

harness.c : $(MSAVE)
	bosal $(BFLAGS) $(MSAVE)

harness.o : harness.c micca_rt.h micca_rt_internal.h bosal.h

harness.o : CFLAGS+=-DNDEBUG

bookstore.c bookstore.h bookstore.ral : \
	simplebookstore.micca sbs_population.micca
	micca $(MIFLAGS) $^

bookstore.o : CFLAGS+=--coverage

micca_rt.o : micca_rt.c micca_rt.h micca_rt_internal.h

bosal.h :
	bosal -header

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
		scenarios.*\
		scenario-seq.*\
		bookstore_results.info\
		mecate.test\
		*.gcno\
		*.gcda\
		*.gcov\
		core\
		$(NULL)

.PHONY : clean
clean :
	-$(RM) $(LIB) $(CLEANFILES)



# vim:set ts=8 sw=8 sts=8 noexpandtab:
