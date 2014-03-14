PROJNAME=niulab-slides-template
PROJVER=`git describe`
PROJTARBALL=$(PROJNAME)-$(PROJVER).tar.gz

THEMEDIR=themes
SAMPLEDIR=sample
AUXFILES=README.txt

TEXMFHOME=$(HOME)/.texmf

SAMPLE=template-niulab-slides
LATEX=xelatex
BIBTEX=biber
LATEXMK=latexmk

dist:
	tar -zcvf $(PROJTARBALL) --exclude='*~' $(THEMEDIR) $(SAMPLEDIR) $(AUXFILES)

install:
	cp -rp themes "$(TEXMFHOME)/tex/latex/beamer/"

test: install
ifeq ($(LATEXMK),)
	cd $(SAMPLEDIR) && \
	$(LATEX) $(SAMPLE) && \
	$(BIBTEX) $(SAMPLE) && \
	$(LATEX) $(SAMPLE) && \
	$(LATEX) $(SAMPLE)
else
	cd $(SAMPLEDIR) && \
	$(LATEXMK) -c $(SAMPLE) && \
	$(LATEXMK) -pdf -pv $(SAMPLE)
endif
