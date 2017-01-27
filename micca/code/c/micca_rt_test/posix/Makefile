# #*++
# PROJECT:
#	Tools
# MODULE:
#
# ABSTRACT:
#
#*--
#

VPATH	= ..

CFLAGS	= -std=c11 -g -L$(HOME)/local/lib -Wall
CPPFLAGS =\
	 -D_POSIX_C_SOURCE=200112L\
	 -D_ISOC11_SOURCE\
	 -D_XOPEN_SOURCE=600\
	 $(NULL)

DOCSRC 	=\
	../micca_rt_test.aweb\
	$(NULL)

POSIXDOCSRC =\
	posix_rt_test.aweb\
	$(NULL)

ATANGLEOPTS =\
	$(NULL)

.PHONY : all runtests

all : runtests

runtests : micca_rt_posixtest
	micca_rt_posixtest

micca_rt_posixtest : CPPFLAGS += -I$(HOME)/local/include -I..

micca_rt_posixtest : LOADLIBES = $(HOME)/local/lib/libcunit.a --coverage

micca_rt_posixtest : micca_rt_posixtest.o posixtestdomain.o ../micca_rt.o

micca_rt_posixtest.c : micca_rt.h micca_rt_internal.h posixtestdomain.h

micca_rt_posixtest.c : $(POSIXDOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

posixtestdomain.c posixtestdomain.h : posixtestdomain.micca
	micca $<

posixtestdomain.micca : $(POSIXDOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

CLEANFILES =\
	micca_rt_posixtest\
	micca_rt_posixtest.c\
	posixtestdomain.micca\
	posixtestdomain.c\
	posixtestdomain.h\
	*.o\
	*.gcov\
	*.gcda\
	*.gcno\
	$(PDF)\
	$(NULL)

clean :
	$(RM) $(CLEANFILES)

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
