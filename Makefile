# LATEX: pdflatex | xelatex | lualatex
LATEX = lualatex
LATEX_FLAGS = -shell-escape
BIBTEX = bibtex

FILES = $(patsubst %.tex, %.pdf, $(wildcard *.tex))

main: rebuild

all: index.pdf

update:
	lualatex -shell-escape main.tex

rebuild:
	lualatex -shell-escape main.tex
	bibtex main.aux
	lualatex -shell-escape main.tex
	lualatex -shell-escape main.tex

%.pdf: %.tex
	$(LATEX) $(LATEX_FLAGS) $<
	-$(BIBTEX) $(patsubst %.tex, %.aux, $<)
	$(LATEX) $(LATEX_FLAGS) $<
	$(LATEX) $(LATEX_FLAGS) $<
	# qpdf --linearize --newline-before-endstream $@ /tmp/$@
	# mv /tmp/$@ $@

clean:
	- echo `cat .gitignore` | xargs rm -f
	- echo `cat .gitignore` | xargs rm -rf

_clean:
	-rm -f *.{log,toc,tac,aux,dvi,ps,bbl,blg,tmp,nav,out,snm,vrb,rel,cut,abs,xmpi,xmpdata,*~}
	-rm -rf out _minted* auto
	for i in $(ALLSUBDIRS); do \
	    (cd $$i; make clean) || exit 1; \
	done
	-rm $(FILES)

cleanall: clean
	-rm -rf out auto
