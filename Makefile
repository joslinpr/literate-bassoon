#################### Misc variables and flags
# SENTINAL depends on everything
.DEFAULT_GOAL : all
	MAKEFLAGS += "-j 4"
	# remove targets if build fails
.DELETE_ON_ERROR:
	# run recipes in a single shell
.ONESHELL:
.PHONY : all clean installclean install testmake

# Programs and their Options
GLOW := /usr/local/bin/glow
ELINKS := /usr/bin/elinks
GLOWARGS := -w 120
EARGS := -dump -dump-charset UTF-8 --no-references
RSYNC := /usr/bin/rsync
SHELL := /usr/bin/bash
MD := /usr/local/bin/markdown_py
MDOPTS := -x extra -x smarty -x sane_lists
# MDOPTS := -x extra -x smarty -x sane_lists -x toc
.SHELLFLAGS := -euc

#################### Targets
SENTINAL  := .uptodate
SRCS      = $(sort $(wildcard *.md))
TXTFILES  = $(patsubst %.md,%.txt,$(SRCS))
HTMLFILES = $(patsubst %.md,%.html,$(SRCS))
FILES     = $(sort $(TXTFILES) $(HTMLFILES))
TOC       = .TOC.header
HEADER    = .header.html
FOOTER    = .footer.html
AUXFILES  = $(TOC) $(HEADER) $(FOOTER) Makefile
installdir=$(HOME)/BoK
testdir=$(HOME)/Downloads
AAAPHX=aaaphx.goc.dhl.com:~/BoK

all : $(SENTINAL)

#################### MD2TXT
define MD2TXT =
@printf "\t$< --> $@\n"
@$(ELINKS) $(EARGS) < $< > $@
@chmod 744 $@ $<
endef
%.txt : %.html Makefile
	$(MD2TXT)

#################### MD2HTML
define MD2HTML =
@printf "\t$< --> $@\n"
@cat $(TOC) $< | $(MD) $(MDOPTS) -f tmp-$@
@cat $(HEADER) tmp-$@ $(FOOTER) > $@
@rm -f tmp-$@
@chmod 744 $@ $<
endef
%.html : %.md Makefile $(HEADER) $(TOC) $(FOOTER)
	$(MD2HTML)

clean :
	rm -f $(FILES)

installclean :
	@printf "Removing $(wildcard $(installdir)/*.md) $(wildcard $(installdir)/*.html) $(wildcard $(installdir)/*.txt)\n" \
		| fmt
	@rm -f "$(wildcard $(installdir)/*.md) $(wildcard $(installdir)/*.html) $(wildcard $(installdir)/*.txt)"

testmake :
	@printf  "Changed Deps: (%s)\n" "$?"
	@printf  "SRCS=$(SRCS)\n"
	@printf  "FILES=$(FILES)\n"
	@printf  "SENTINAL=$(SENTINAL)\n"
	@printf  "installdir=$(installdir)\n"
	@printf  "\n"
	@printf  "Testing 'clean'\n"
	make -n clean
	@printf  "Testing 'all'\n"
	make -n

Makefile :
	@printf "\t$? --> $@\n"
	@chmod 744 $@ $?
	make clean all

$(SENTINAL) : $(FILES) Makefile index.html
	touch $(SENTINAL)
	@chmod 600 $(SENTINAL)

install: all
	$(RSYNC) $(FILES) $(SRCS) $(AUXFILES) $(installdir)

testinstall: all
	$(RSYNC) $(FILES) $(SRCS) $(AUXFILES) $(testdir)

aaaphx: all
	$(RSYNC) -ac $(FILES) $(SRCS) $(AUXFILES) $(AAAPHX)

toc:
	@printf "Use bitdowntoc_linux --max-level -1 -o Outfile.md  Infile.md\n"

piway: all
	$(RSYNC) $(FILES) $(SRCS) $(AUXFILES) PiWay:~/BoK/
	$(RSYNC) -avc --delete $(HTMLFILES) MakeIndex index.html PiWay:~/Projects/DockerHTTPD/public-html/

.index.md: $(SRCS) $(FILES)
	./MakeIndex

index.html:  .index.md
	$(MD2HTML)

#  vim: set ai noet nu cindent sts=0 sw=8 tabstop=8 textwidth=78 filetype=make :
