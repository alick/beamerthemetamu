PROJNAME=niulab-slides-template
PROJVER=0.3git
PROJTARBALL=$(PROJNAME)-$(PROJVER).tar.gz

THEMEDIR=themes
SAMPLEDIR=sample
AUXFILES=README.txt

TEXMFHOME="$(HOME)/.texmf/"

SAMPLE=template-niulab-slides
LATEX=xelatex
BIBTEX=biber

dist:
	tar -zcvf $(PROJTARBALL) --exclude='*~' $(THEMEDIR) $(SAMPLEDIR) $(AUXFILES)

install:
	cp -rp themes $(TEXMFHOME)/tex/latex/beamer/

test:
	cd $(SAMPLEDIR) && \
	$(LATEX) $(SAMPLE) && \
	$(BIBTEX) $(SAMPLE) && \
	$(LATEX) $(SAMPLE) && \
	$(LATEX) $(SAMPLE)
