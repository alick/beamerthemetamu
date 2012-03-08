NiuLab Slides Template
======================

Dependencies:
-----------
The template is based on beamer, so you should have beamer installed.  To be
able to get Chinese support, ctex package and xelatex engine should be used.

Installation:
-------------
To install you just need to copy the themes directory into your
$TEXMFHOME/tex/latex/beamer/ directory, where $TEXMFHOME stands for your
personal texmf tree directory. As with TeX Live, it defaults to $HOME/texmf
under Unix. For Windows XP, it is C:\Documents and Settings\<username>\texmf,
and under Windows Vista and Windows 7 it is C:\Users\<username>\texmf.

Notes to MikTeX/CTeX users: there is not a default directory equal to
$TEXMFHOME, but you can use an arbitrary directory as your personal texmf tree.
Just set it up with the help of this guide[1], once and for all. Remember
to refresh FNDB after a fresh new install of this theme.

[1] http://tex.stackexchange.com/a/20121

After installation, you will get files such as
`$TEXMFHOME/tex/latex/beamer/themes/theme/beamerthemeniulab.sty`.

How to use:
-----------
You can use the sample file template-niulab-slides.tex to get started. Just
modify it (add your talk stuff) and then compile it using pdflatex or xelatex.
Note the sample file depends on the bib source file refs.bib. To output PDF
file with correct citation info, you need to copy it along with your tex file,
or modify the tex file to use your own bib file, or just delete all bib related
stuff in the tex file.
