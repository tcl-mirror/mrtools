DOCS =\
    micca\
    config\
    embedded\
    portal\
    $(NULL)

SRCS = $(patsubst %,micca/%.man,$(DOCS))
HTML = $(patsubst %,HTML/files/%,$(DOCS))
NROFF = $(patsubst %,MAN/files/%.n,$(DOCS))

.PHONY : all html man

all : html man

html : $(SRCS)
	dtplite -o HTML html micca

man : $(SRCS)
	dtplite -o MAN -ext n nroff micca

zip : 
	zip -r micca-html.zip HTML
