THIS_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

SOURCES = $(wildcard *.bdoc)
MAIN = system.adoc
MACROS = macros.adoc
ADOCS = $(SOURCES:.bdoc=.adoc)
HTML = index.html

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
#		: replace all spaces with {nbsb}, but handle EOL

WRAPPING_LEV1 = -e '/^[[:blank:]]*@[[:blank:]]/{ \
                 s/[[:blank:]]+/ /g; s/^ *@/{nbsp}{bull}{nbsp}/; \
                 s/ \*([^ *])/ \*\*\1/g;s/([^ *])\* /\1\*\* /g; \
                 s/ \+$$/{EOL}/; s/ /{nbsp}/g; s/\{EOL\}$$/ \+/}'

WRAPPING_LEV2 = -e '/^[[:blank:]]*@@[[:blank:]]/{ \
                 s/[[:blank:]]+/ /g; s/^ *@@/{nbsp}{nbsp}{tribull}{nbsp}/; \
                 s/ \*([^ *])/ \*\*\1/g;s/([^ *])\* /\1\*\* /g; \
                 s/ \+$$/{EOL}/; s/ /{nbsp}/g; s/\{EOL\}$$/ \+/}'

SED = /usr/bin/sed -E

.PHONY: all install tidy clean status update commit force

all: $(HTML)

$(HTML): $(MAIN) $(MACROS) $(ADOCS)
	asciidoctor -a stylesheet=foundation.css $(MAIN) -o $@

%.adoc : %.bdoc
	$(SED) $(BIDS) $(WRAPPING_LEV1) $(WRAPPING_LEV2) $< >$@

install: $(HTML)
	install -m 0664 -t $(THIS_DIR)../ $<

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
