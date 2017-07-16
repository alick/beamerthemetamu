PROJNAME=beamerthemetamu
PROJVER=`git describe`
PROJTARBALL=$(PROJNAME)-$(PROJVER).tar.gz

THEMEDIR=theme
SAMPLEDIR=sample
THEMEFILES=beamercolorthemetamu.sty beamerfontthemetamu.sty beamerinnerthemetamu.sty beamerouterthemetamu.sty beamerthemetamu.sty tamu-logo.pdf
SAMPLEFILES=beamerthemetamu.tex beamerthemetamu-refs.bib
AUXFILES=README.txt Makefile

TEXMFHOME=`kpsewhich -var-value TEXMFHOME`

SAMPLE=$(PROJNAME)
LATEXMK=latexmk

.PHONY: dist install test clean

dist:
	tar -zcvf $(PROJTARBALL) --exclude='*~' $(THEMEDIR) $(SAMPLEDIR) $(AUXFILES)

install:
	install -d "$(TEXMFHOME)/tex/latex/$(PROJNAME)/"
	cd $(THEMEDIR) && install -t "$(TEXMFHOME)/tex/latex/$(PROJNAME)/" $(THEMEFILES)
	install -d "$(TEXMFHOME)/doc/latex/$(PROJNAME)/"
	cd $(SAMPLEDIR) && install -t "$(TEXMFHOME)/doc/latex/$(PROJNAME)/" $(SAMPLEFILES)
	install -t "$(TEXMFHOME)/doc/latex/$(PROJNAME)/" $(AUXFILES)

test:
	cd $(SAMPLEDIR) && \
	find ../$(THEMEDIR)/ \( -name '*tamu.sty' -o -name 'tamu*.pdf' \) -exec cp '{}' ./ \; && \
	$(LATEXMK) -C $(SAMPLE) && \
	$(LATEXMK) $(SAMPLE)

clean:
	cd $(SAMPLEDIR) && \
	$(LATEXMK) -C $(SAMPLE) && \
	rm -rf *tamu.sty tamu*.pdf
	find . \( -name '*~' -o -name '*.swp' \) -delete
	rm -rf *.tar.gz
