SOURCES = $(wildcard *.bdoc)
MAIN = system.adoc
MACROS = macros.adoc
ADOCS = $(SOURCES:.bdoc=.adoc)
HTML = $(MAIN:.adoc=.html)

SPADES = {spades}
HEARTS = {hearts}
DIAMS  = {diams}
CLUBS  = {clubs}

BIDS := $(foreach n, 1 2 3 4 5 6 7, \
           $(foreach suit, \
	      S:$(n)$(SPADES) H:$(n)$(HEARTS) D:$(n)$(DIAMS) C:$(n)$(CLUBS), \
	      -e 's:$(n)$(suit):g' \
	   ) \
	)
# wrapping list : on lines beginning with "@ " or " @ "
#               : squeeze multiple blanks & replace leading @
#               : replace " *some string* " with " **some string** "
#		: replace all spaces with {nbsb}

WRAPPING_LIST = -e '/^[[:blank:]]*@[[:blank:]]/{ \
                 s/[[:blank:]]+/ /g; s/^ *@/{nbsp}{bull}{nbsp}/; \
                 s/ \*([^ ])/ \*\*\1/g;s/([^ ])\* /\1\*\* /g; \
                 s/ /{nbsp}/g}'

SED = /usr/bin/sed -E

.PHONY: all tidy clean status update commit force

all: $(HTML)

$(HTML): $(MAIN) $(MACROS) $(ADOCS)

%.html: %.adoc
	asciidoctor -a stylesheet=foundation.css $<
#	asciidoctor -a stylesheet=colony.css $<

%.adoc : %.bdoc
	$(SED) $(BIDS) $(WRAPPING_LIST) $< >$@

tidy:
	$(RM) $(ADOCS)

clean: tidy
	$(RM) $(HTML) *~

status:
	git status

update:
	@svn update

commit:
	git commit -a

#	@echo $(shell read -p "Comment: " MSG; svn commit -m "$$MSG" )
