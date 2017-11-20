THIS_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

SOURCES = $(wildcard *.bdoc)
MAIN = system.adoc
MACROS = macros.adoc
ADOCS = $(SOURCES:.bdoc=.adoc)
HTML = index.html

SPADES = {S}
HEARTS = {H}
DIAMS  = {D}
CLUBS  = {C}

BIDS := -e '/^[^\[]/s/([[:digit:]])([SHDC])/\1{\2}/g'

SUIT_LENGTH := -e '/^[^\[]/s/([[:digit:]])\*([^\*[:blank:]])/\1{times}\2/g'

# wrapping list : on lines beginning with "@ " or " @ "
#               : replace leading @ "[nobr]##{isep}"
#		: insert closing " ##" before final " +" or at EOL

WRAPPING_LEV1 = -e '/^[[:blank:]]*@[[:blank:]]/{ \
                 s/@/\[nobr\]\#\#{isep}/; s/( \+)?$$/ \#\#\1/}'

WRAPPING_LEV2 = -e '/^[[:blank:]]*@@[[:blank:]]/{ \
                 s/@@/\[nobr\]\#\#{trisep}/; s/( \+)?$$/ \#\#\1/}'

SED = /usr/bin/sed -E

.PHONY: all install tidy clean status update commit force

all: $(HTML)

$(HTML): $(MAIN) $(MACROS) $(ADOCS)
	asciidoctor -a stylesheet=foundation.css $(MAIN) -o $@

%.adoc : %.bdoc
	$(SED) $(BIDS) $(SUIT_LENGTH) $(WRAPPING_LEV1) $(WRAPPING_LEV2) $< >$@

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
