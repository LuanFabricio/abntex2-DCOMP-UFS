############################################################################
#
# Makefile for abntex2-DCOMP-UFS
#
# ddantas 22/10/2020
#
############################################################################


FILENAME = TCC
#FILENAME = Modelo-Mestrado-PROCC


all: $(FILENAME).pdf

dvi: $(FILENAME).dvi

ps: $(FILENAME).ps

pimg.ps: $(FILENAME).dvi
	dvips -o $(FILENAME).ps $(FILENAME).dvi

$(FILENAME).pdf: $(FILENAME).tex
	pdflatex $(FILENAME).tex
	bibtex $(FILENAME)
	pdflatex $(FILENAME).tex
	pdflatex $(FILENAME).tex

$(FILENAME).dvi: clean $(FILENAME).tex
	echo "Running latex..."
	latex $(FILENAME).tex
	echo "Running makeindex..."
	#makeindex $(FILENAME).idx
	echo "Rerunning latex...."
	latex $(FILENAME).tex
	latex_count=5 ; \
	while egrep -s 'Rerun (LaTeX|to get cross-references right)' refman.log && [ $$latex_count -gt 0 ] ;\
	    do \
	      echo "Rerunning latex...." ;\
	      latex $(FILENAME).tex ;\
	      latex_count=`expr $$latex_count - 1` ;\
	    done

web: $(FILENAME).pdf
	mv TCC.pdf web

clean:
	rm -f *.ps *.dvi *.aux *.toc *.idx *.ind *.ilg *.log *.out *.brf *.blg *.bbl *.bbl *.loa *.loc *.loq *.lot *.lof *.fdb_latexmk *.fls *.synctex.gz # $(FILENAME).pdf
