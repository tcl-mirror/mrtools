# #*++
# PROJECT:
#	Tools
# MODULE:
#
# ABSTRACT:
#
#*--
#

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

runtests : micca_rt_test micca_rt_posixtest
	micca_rt_test
	micca_rt_posixtest
	gcov micca_rt_test.c

micca_rt_test : CPPFLAGS += -I$(HOME)/local/include \
    	-fprofile-arcs -ftest-coverage

micca_rt_test : LOADLIBES = $(HOME)/local/lib/libcunit.a

micca_rt_test : micca_rt_test.c

micca_rt_test.c : micca_rt.c micca_rt.h testdomain.c testdomain.h

micca_rt_test.c : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

micca_rt_posixtest : CPPFLAGS += -I$(HOME)/local/include  --coverage

micca_rt_posixtest : LOADLIBES = $(HOME)/local/lib/libcunit.a

micca_rt_posixtest : micca_rt_posixtest.c

micca_rt_posixtest.c : micca_rt.c micca_rt.h posixtestdomain.c posixtestdomain.h

micca_rt_posixtest.c : $(POSIXDOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

micca_rt.o : CFLAGS+=--coverage

testdomain.c testdomain.h : testdomain.micca
	micca $<

testdomain.micca : $(DOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

posixtestdomain.c posixtestdomain.h : posixtestdomain.micca
	micca $<

posixtestdomain.micca : $(POSIXDOCSRC)
	atangle $(ATANGLEOPTS) -root $@ -output $@ $<

CLEANFILES =\
	micca_rt_test\
	micca_rt_test.c\
	micca_rt_posixtest\
	micca_rt_posixtest.c\
	testdomain.micca\
	testdomain.c\
	testdomain.h\
	testdomain.o\
	posixtestdomain.micca\
	posixtestdomain.c\
	posixtestdomain.h\
	posixtestdomain.o\
	micca_rt.o\
	$(PDF)\
	*.gcov\
	*.gcda\
	*.gcno\
	$(NULL)

clean :
	$(RM) $(CLEANFILES)

#
# vim :set sw=8 ts=8 sts=8 noexpandtab:
#
