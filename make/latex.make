TEXC := xelatex
MAIN := report
LFLAGS := -synctex=1 -interaction=nonstopmode
CPATH :=

DIRS := sources

SUFS := aux \
        bbl bcf blg \
        fdb_latexmk fls \
        idx ind ilg \
        listing loc lof log lol los lot ltx \
        nav nlo nls \
        out \
        toc \
        run.xml \
        snm synctex.gz synctex\(busy\) \
        vrb \
        xdv

ifeq ($(TEXC), xelatex)
  MKFLAGS := -pdfxe
else ifeq ($(TEXC), pdflatex)
  MKFLAGS := -pdf
else ifeq ($(TEXC), lualatex)
  MKFLAGS := -pdflua
else
  MKFLAGS :=
endif

all : tex2pdf view

tex2pdf :
	$(CPATH)$(TEXC) $(LFLAGS) $(MAIN)

full :
	$(CPATH)latexmk $(MKFLAGS) $(LFLAGS) $(MAIN)

view :
	evince $(MAIN).pdf

backup :
	tar -zpcvf Backup.tar.gz $(MAIN).tex $(foreach d,$(DIRS),$(d)/*.tex) figures

clean :
	-rm -f $(foreach s,$(SUFS),$(MAIN).$(s))
	-rm -f $(foreach d,$(DIRS),$(foreach s,$(SUFS),$(d)/*.$(s)))

clear : clean
	-rm -f $(MAIN).pdf

# vim:ft=make noet
