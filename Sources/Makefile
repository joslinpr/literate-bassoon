#################### Misc variables and flags
# SENTINAL depends on everything
.DEFAULT_GOAL : all
	MAKEFLAGS += "-j 4"
	# remove targets if build fails
.DELETE_ON_ERROR:
	# run recipes in a single shell
.ONESHELL:
.PHONY : all clean installclean install testmake list

# Programs and their Options
GLOW := /usr/local/bin/glow
ELINKS := /usr/bin/elinks
GLOWARGS := -w 120
EARGS := -dump -dump-charset UTF-8 --no-references
RSYNC := /usr/bin/rsync
RSYNCARGS := -avc
SHELL := /usr/bin/bash
MD := /usr/local/bin/markdown_py
MDOPTS := -x extra -x smarty -x sane_lists
# MDOPTS := -x extra -x smarty -x sane_lists -x toc
.SHELLFLAGS := -euc

#################### Directories
SRCDIR=./
STAGEDIR=../Staging/
TESTDIR=$(HOME)/Downloads
VPATH=.:$(SRCDIR)

#################### Targets
SENTINAL  := .uptodate
# SRCS      = $(sort $(wildcard *.md))
SRCS      = $(sort $(wildcard $(SRCDIR)*.md))
MDFILES  = $(subst $(SRCDIR),$(STAGEDIR),$(SRCS))
TXTFILES  = $(patsubst %.md,%.txt,$(MDFILES))
HTMLFILES = $(patsubst %.md,%.html,$(MDFILES))
FILES     = $(sort $(MDFILES) $(TXTFILES) $(HTMLFILES))
TOC       = .TOC.header
HEADER    = .header.html
FOOTER    = .footer.html
AUXFILES  = $(TOC) $(HEADER) $(FOOTER) Makefile
AAAPHX=aaaphx.goc.dhl.com:~/BoK

all : $(SENTINAL)

#################### MD2TXT
define MD2TXT =
@printf "\t$< --> $@\n"
@$(ELINKS) $(EARGS) < $< > $@
@chmod 744 $@ $<
endef
%.txt : %.html
#	@printf  "Changed Deps: (%s)\n" "$?"
	$(MD2TXT)

#################### MD2HTML
define MD2HTML =
@printf "\t$< --> $@\n"
@cat $(TOC) $< | $(MD) $(MDOPTS) -f $@.tmp
@printf "<P>Last Update: " > .LastUpdate
@date -R >> .LastUpdate
@printf "</P>\n" >> .LastUpdate
@cat $(HEADER) $@.tmp .LastUpdate $(FOOTER) > $@
@rm -f $@.tmp
@chmod 744 $@ $<
endef
%.html : %.md $(HEADER) $(TOC) $(FOOTER)
#	@printf  "Changed Deps: (%s)\n" "$?"
	$(MD2HTML)

clean :
	rm -f $(FILES)

testmake :
	@printf "SRCS=$(SRCS)\n\n"
	@printf "FILES=$(FILES)\n\n"
	@printf "HTMLFILES=$(HTMLFILES)\n\n"
	@printf "MDFILES=$(MDFILES)\n\n"
	@printf "TXTFILES=$(TXTFILES)\n\n"
	@printf "PATH=$(PATH)\n\n"
	@printf "SENTINAL=$(SENTINAL)\n\n"
#	@printf  "Testing 'clean'\n"
#	make -n clean
#	@printf  "Testing 'all'\n"
#	make -n

Makefile :
	@printf "\t$? --> $@\n"
	@chmod 744 $@ $?
	make clean all

$(SENTINAL) : $(SRCS) Makefile index.html
	touch $(SENTINAL)
	@chmod 600 $(SENTINAL)

#################### Installs
install: all
	@echo Install from Parent Directory

toc:
	@printf "Use bitdowntoc_linux -p GITHUB --no-oneshot --max-level -1 -o Outfile.md  Infile.md\n"


.index.md: $(STAGEDIR)/.index.md
	cp $(STAGEDIR)/.index.md .

index.html:  .index.md
	$(MD2HTML)

list:
	@LC_ALL=C $(MAKE) -pRrq -f $(firstword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/(^|\n)# Files(\n|$$)/,/(^|\n)# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | grep -E -v -e '^[^[:alnum:]]' -e '^$@$$'

#  vim: set ai noet nu cindent sts=0 sw=8 tabstop=8 textwidth=78 filetype=make :
