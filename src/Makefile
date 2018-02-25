THIS_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

BRIDGEDOC = $(THIS_DIR)../../../bridgedoc

MAIN = system.adoc
SOURCES = $(wildcard *.bdoc)
ADOCS = $(SOURCES:.bdoc=.adoc)
HTML = index.html

MACROS = $(BRIDGEDOC)/macros.adoc
STYLE_SHEET = $(BRIDGEDOC)/bridgedoc.css
PREPROC = python $(BRIDGEDOC)/bridgedoc.py

.PHONY: all install tidy clean status update pull commit

all: $(HTML)

$(HTML): $(MAIN) $(MACROS) $(ADOCS) $(STYLE_SHEET)
	asciidoctor -a stylesheet=$(STYLE_SHEET) \
		    -a bridgedoc=$(BRIDGEDOC) $(MAIN) -o $@

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
