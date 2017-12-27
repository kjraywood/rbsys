THIS_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

SOURCES = $(wildcard *.bdoc)
MAIN = system.adoc
MACROS = macros.adoc
STYLE_SHEET = bridgedoc.css
PREPROC = python bridgedoc.py
ADOCS = $(SOURCES:.bdoc=.adoc)
HTML = index.html

.PHONY: all install tidy clean status update pull commit

all: $(HTML)

$(HTML): $(MAIN) $(MACROS) $(ADOCS) $(STYLE_SHEET)
	asciidoctor -a stylesheet=$(STYLE_SHEET) $(MAIN) -o $@

%.adoc : %.bdoc
	$(PREPROC) $< $@

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
