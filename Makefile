# define name of LaTex Document (without filename extension)
DOCUMENT = Skript
#BIBFILE = $(DOCUMENT).bib

# you must also decide wheater to use bibtex or not
# and choose the page format (default: use bibtex, DIN A4)


# produce PDF and delete temporary files
all: $(DOCUMENT).pdf clean

# $<	first dependency
# $*	wildcart (%)
%.dvi: %.tex 
	# create latex dvi file with present bibliography
	#latex $< && bibtex $* && latex $< && latex $<
	# create latex dvi file without present bibliography (also clean the BIBFILE variable!!)
	latex $< && latex $<

# $@	target
# $^	all dependencies (doubles eliminated)
# -ta4	DIN A4
%.ps: %.dvi
	dvips -ta4 -o $@ $^

%.pdf: %.ps
	ps2pdf14 $^

diff.tex:
	latexdiff -t CFONT $(DOCUMENT)Old.tex $(DOCUMENT).tex > diff.tex

#.DEFAULT: article.pdf

.PHONY: clean rm pdf ps dvi

# remove all temporary files (without pdf)
# @	suppress output of instruction
clean:
	@rm -f *.aux
	@rm -f *.bbl
	@rm -f *.blg
	@rm -f *.dvi
	@rm -f *.log
	@rm -f *.ps
	@rm -f diff.tex

# remove pdf
rm:
	rm -f $(DOCUMENT).pdf

pdf: $(DOCUMENT).pdf

ps: $(DOCUMENT).ps

dvi: $(DOCUMENT).dvi

