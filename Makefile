PROJNAME=beamerthemetamu
PROJVER=`git describe`
PROJTARBALL=$(PROJNAME)-$(PROJVER).tar.gz

THEMEDIR=themes
SAMPLEDIR=sample
AUXFILES=README.txt

TEXMFHOME=`kpsewhich -var-value TEXMFHOME`

SAMPLE=sample
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
	find ../themes/ \( -name '*tamu.sty' -o -name 'tamu*.pdf' \) -exec cp '{}' ./ \; && \
	$(LATEXMK) -C $(SAMPLE) && \
	$(LATEXMK) $(SAMPLE)

clean:
	cd $(SAMPLEDIR) && \
	$(LATEXMK) -C $(SAMPLE) && \
	rm -rf *tamu.sty tamu*.pdf
	find . \( -name '*~' -o -name '*.swp' \) -delete
	rm -rf *.tar.gz
