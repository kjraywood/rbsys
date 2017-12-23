THIS_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

SOURCES = $(wildcard *.bdoc)
MAIN = system.adoc
MACROS = macros.adoc
STYLE_SHEET = bridgedoc.css
ADOCS = $(SOURCES:.bdoc=.adoc)
HTML = index.html

E_BIDS = /^[^\[]/s/([[:digit:]])([SHDC])/\1{\2}/g

E_SUIT_LENGTH = /^[^\[]/s/([[:digit:]])\*([^\*[:blank:]])/\1{xtimes}\2/g

# lines begin with &, followed by one or more non-&, end with & or "& +"
# replace leading & with [boldbrickred]##
# replace trailing & with ##
E_BOLD_BRICK = /^&[^&]+&( \+)?$$/{ \
               s/^&/\[bold-brickred\]\#\#/; \
               s/&( \+)?$$/ \#\#\1/}

# wrapping list : on lines beginning with "_ ", "@ " or " @ "
#               : replace leading @ "[nobr]##{isep}"
#		: insert closing " ##" before final " +" or at EOL

E_WL0 = /^[[:blank:]]*_[[:blank:]]/{ \
        s/_/\[nobr\]\#\#{nbsp}/; s/( \+)?$$/ \#\#\1/}

E_WL1 = /^[[:blank:]]*@[[:blank:]]/{ \
        s/@/\[nobr\]\#\#{isep}/; s/( \+)?$$/ \#\#\1/}

E_WL2 = /^[[:blank:]]*@@[[:blank:]]/{ \
        s/@@/\{backspace\}\[nobr\]\#\#{trisep}/; s/( \+)?$$/ \#\#\1/}

# Alerts
E_ALERT = s/\!([[:alnum:]\{\}]+)\!/\[alert\]\#\1\#/g

SED = /usr/bin/sed -E

.PHONY: all install tidy clean status update pull commit

all: $(HTML)

$(HTML): $(MAIN) $(MACROS) $(ADOCS) $(STYLE_SHEET)
	asciidoctor -a stylesheet=$(STYLE_SHEET) $(MAIN) -o $@

%.adoc : %.bdoc
	@$(SED) -e '$(E_BIDS)' -e '$(E_SUIT_LENGTH)' -e '$(E_BOLD_BRICK)' \
	        -e '$(E_WL0)' -e '$(E_WL1)' -e '$(E_WL2)' -e '$(E_ALERT)' \
	        $< >$@
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
