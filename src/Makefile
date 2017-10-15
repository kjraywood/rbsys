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
#               : replace leading @ with opening text
#		: insert closing text before final " +" or at EOL

# WRAPPING_LEV1 = -e '/^[[:blank:]]*@[[:blank:]]/{ \
#                  s/@/pass:\[<span class="nobr">\]{nbsp}{bull}{nbsp}/; \
#                  s=( \+)?$$= pass:\[</span>\]\1=}'

WRAPPING_LEV1 = -e '/^[[:blank:]]*@[[:blank:]]/{ \
                 s/@/\[nobr\]\#\#{nbsp}{bull}{nbsp}/; \
                 s/( \+)?$$/ \#\#\1/}'

WRAPPING_LEV2 = -e '/^[[:blank:]]*@@[[:blank:]]/{ \
                 s/@@/\[nobr\]\#\#{nbsp}{nbsp}{tribull}{nbsp}/; \
                 s/( \+)?$$/ \#\#\1/}'

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
