THIS_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

SOURCES = $(wildcard *.bdoc)
MAIN = system.adoc
MACROS = macros.adoc
STYLE_SHEET = bridgedoc.css
ADOCS = $(SOURCES:.bdoc=.adoc)
HTML = index.html

BIDS := -e '/^[^\[]/s/([[:digit:]])([SHDC])/\1{\2}/g'

SUIT_LENGTH := -e '/^[^\[]/s/([[:digit:]])\*([^\*[:blank:]])/\1{xtimes}\2/g'

# lines begin with &, followed by one or more non-&, end with & or "& +"
# replace leading & with [boldbrickred]##
# replace trailing & with ##
BOLD_BRICK = -e '/^&[^&]+&( \+)?$$/{ \
                 s/^&/\[bold-brickred\]\#\#/; \
                 s/&( \+)?$$/ \#\#\1/}'

# wrapping list : on lines beginning with "_ ", "@ " or " @ "
#               : replace leading @ "[nobr]##{isep}"
#		: insert closing " ##" before final " +" or at EOL

WRAPP_LEV0 = -e '/^[[:blank:]]*_[[:blank:]]/{ \
                 s/_/\[nobr\]\#\#{nbsp}/; s/( \+)?$$/ \#\#\1/}'

WRAPP_LEV1 = -e '/^[[:blank:]]*@[[:blank:]]/{ \
                 s/@/\[nobr\]\#\#{isep}/; s/( \+)?$$/ \#\#\1/}'

WRAPP_LEV2 = -e '/^[[:blank:]]*@@[[:blank:]]/{ \
                 s/@@/\[nobr\]\#\#{trisep}/; s/( \+)?$$/ \#\#\1/}'

SED = /usr/bin/sed -E

.PHONY: all install tidy clean status update pull commit

all: $(HTML)

$(HTML): $(MAIN) $(MACROS) $(ADOCS) $(STYLE_SHEET)
	asciidoctor -a stylesheet=$(STYLE_SHEET) $(MAIN) -o $@

%.adoc : %.bdoc
	@$(SED) $(BIDS) $(SUIT_LENGTH) $(BOLD_BRICK) \
	       $(WRAPP_LEV0) $(WRAPP_LEV1) $(WRAPP_LEV2) $< >$@
	@echo $@

install: $(HTML)
	install -m 0664 -t $(THIS_DIR)../ $<

tidy:
	$(RM) $(ADOCS)

clean: tidy
	$(RM) $(HTML) *~

status:
	git status

update pull:
	git pull

commit:
	git commit -a

#	@echo $(shell read -p "Comment: " MSG; svn commit -m "$$MSG" )
