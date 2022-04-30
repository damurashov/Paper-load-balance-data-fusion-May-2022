main: revision

update:
	lualatex -shell-escape main.tex

rebuild:
	lualatex -shell-escape main.tex
	bibtex main.aux
	lualatex -shell-escape main.tex
	lualatex -shell-escape main.tex

revision: rebuild
	cp main.pdf `date +%Y%m%d.%H%M`-PAPER-LoadBalanceDataFusion-`git describe`.pdf

clean:
	- echo `cat .gitignore` | xargs rm -f
	- echo `cat .gitignore` | xargs rm -rf
