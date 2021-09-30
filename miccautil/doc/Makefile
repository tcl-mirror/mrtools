DOCS =\
    miccautil\
    $(NULL)

SRCS = $(patsubst %,%.man,$(DOCS))
HTML = $(patsubst %,%.html,$(DOCS))
NROFF = $(patsubst %,%.n,$(DOCS))

.PHONY : all clean

all : $(HTML) $(NROFF)

clean :
	$(RM) $(HTML) $(NROFF)

$(HTML) : $(SRCS)
	dtplite -o . -ext html html $(SRCS)

$(NROFF) : $(SRCS)
	dtplite -o . -ext n nroff $(SRCS)
