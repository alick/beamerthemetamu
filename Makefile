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

.PHONY: dist install test clean

dist:
	tar -zcvf $(PROJTARBALL) --exclude='*~' $(THEMEDIR) $(SAMPLEDIR) $(AUXFILES)

install: dist
	mkdir -p "$(TEXMFHOME)/tex/latex/beamer/"
	tar xvf $(PROJTARBALL) -C "$(TEXMFHOME)/tex/latex/beamer/"

test:
	cd $(SAMPLEDIR) && \
	find ../themes/ \( -name '*niulab.sty' -o -name 'niulab*.pdf' \) -exec cp '{}' ./ \; && \
	$(LATEXMK) -C $(SAMPLE) && \
	$(LATEXMK) -pdf -pv $(SAMPLE)

clean:
	cd $(SAMPLEDIR) && \
	$(LATEXMK) -C $(SAMPLE) && \
	rm -rf *niulab.sty niulab*.pdf
	find . \( -name '*~' -o -name '*.swp' \) -delete
	rm -rf *.tar.gz
