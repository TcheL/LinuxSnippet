TEXC := xelatex
MAIN := report
OUTDIR := build
LFLAGS := -synctex=1 -interaction=nonstopmode -outdir=$(OUTDIR)
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

all : prep tex2pdf view

prep :
	ln -fs $(OUTDIR)/$(MAIN).pdf
	mkdir -p $(OUTDIR)

tex2pdf :
	$(CPATH)$(TEXC) $(LFLAGS) $(MAIN)

full : prep
	$(CPATH)latexmk $(MKFLAGS) $(LFLAGS) $(MAIN)

view :
	evince $(MAIN).pdf

backup :
	tar -zpcvf Backup.tar.gz $(MAIN).tex $(foreach d,$(DIRS),$(d)/*.tex) figures

clean :
	-rm -f  $(foreach s,$(SUFS),$(OUTDIR)/$(MAIN).$(s))
	-rm -rf $(foreach d,$(DIRS),$(OUTDIR)/$(d))

clear : clean
	-rm -f $(OUTDIR)/$(MAIN).pdf

# vim:ft=make noet
