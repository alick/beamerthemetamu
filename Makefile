PROJNAME=beamerthemetamu
PROJVER=`git describe`
PROJTARBALL=$(PROJNAME)-$(PROJVER).tar.gz

THEMEDIR=theme
SAMPLEDIR=sample
THEMEFILES=beamercolorthemetamu.sty beamerinnerthemetamu.sty beamerouterthemetamu.sty beamerthemetamu.sty
SAMPLEFILES=beamerthemetamu.tex
BIBFILES=beamerthemetamu-refs.bib
AUXFILES=README.md Makefile

TEXMFHOME=`kpsewhich -var-value TEXMFHOME`

SAMPLE=$(PROJNAME)
LATEXMK=latexmk

.PHONY: dist install test ctan clean

dist:
	tar -zcvf $(PROJTARBALL) --exclude='*~' $(THEMEDIR) $(SAMPLEDIR) $(AUXFILES)

install:
	install -d "$(TEXMFHOME)/tex/latex/$(PROJNAME)/"
	cd $(THEMEDIR) && install -t "$(TEXMFHOME)/tex/latex/$(PROJNAME)/" $(THEMEFILES)
	install -d "$(TEXMFHOME)/doc/latex/$(PROJNAME)/"
	cd $(SAMPLEDIR) && install -t "$(TEXMFHOME)/doc/latex/$(PROJNAME)/" $(SAMPLEFILES)
	install -t "$(TEXMFHOME)/doc/latex/$(PROJNAME)/" $(AUXFILES)
	install -d "$(TEXMFHOME)/bibtex/bib/$(PROJNAME)/"
	cd $(SAMPLEDIR) && install -t "$(TEXMFHOME)/bibtex/bib/$(PROJNAME)/" $(BIBFILES)

test:
	cd $(SAMPLEDIR) && \
	find ../$(THEMEDIR)/ \( -name '*tamu.sty' -o -name 'tamu*.pdf' \) -exec cp '{}' ./ \; && \
	$(LATEXMK) -C $(SAMPLE) && \
	$(LATEXMK) $(SAMPLE)

$(PROJNAME).pdf: test

ctan: $(PROJNAME).pdf
	ctanify --pkgname=$(PROJNAME) --notds --no-skip README.md $(THEMEDIR)/beamer*themetamu.sty $(SAMPLEDIR)/$(PROJNAME)*.{tex,pdf,bib}

clean:
	cd $(SAMPLEDIR) && \
	$(LATEXMK) -C $(SAMPLE) && \
	rm -rf *tamu.sty tamu*.pdf
	find . \( -name '*~' -o -name '*.swp' \) -delete
	rm -rf *.tar.gz
