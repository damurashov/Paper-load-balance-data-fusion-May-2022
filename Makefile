main: rebuild

update:
	lualatex -shell-escape main.tex

rebuild:
	lualatex -shell-escape main.tex
	bibtex main.aux
	lualatex -shell-escape main.tex
	lualatex -shell-escape main.tex

clean:
	- echo `cat .gitignore` | xargs rm -f
	- echo `cat .gitignore` | xargs rm -rf
