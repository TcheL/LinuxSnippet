#===============================================================================
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Wed 30 Dec 2020 09:32:34 PM CST
#-------------------------------------------------------------------------------

FC := gfortran
CLFS := -O2

CFLAGS := 
LFALGS :=

SRCDIR := src
OBJDIR := obj
BINDIR := bin

STATIC :=
DEBUG :=
CPP_MACRO_DEF1 := ON
CPP_MACRO_DEF2 :=
CPP_MACRO_DEF3 :=
CPP_MACRO_VAL1 := _VALUE

DFLAG_LIST := CPP_MACRO_DEF1 CPP_MACRO_DEF2 CPP_MACRO_DEF3
VFLAG_LIST := CPP_MACRO_VAL1

DFLAGS := $(foreach f, $(DFLAG_LIST), $(if $($(f)), -D$(f),))
VFLAGS := $(foreach f, $(VFLAG_LIST), $(if $($(f)), -D$(f)=$($(f)),))
FCEXE := $(notdir $(FC))

ifeq ($(FCEXE), gfortran)
  CFLAGS += -J$(OBJDIR)
else ifeq ($(FCEXE), ifort)
  CFLAGS += -module $(OBJDIR)
endif

ifdef STATIC
  CLFS += -fPIC
  ifeq ($(FCEXE), gfortran)
    LFLAGS += -static-libgfortran
  else ifeq ($(FCEXE), ifort)
    LFLAGS += -static-intel
  endif
endif

ifdef DEBUG
  CFLAGS += -g
  ifeq ($(FCEXE), gfortran)
    CLFS += -Wall -fcheck=all -ffpe-trap=invalid,zero,overflow
  else ifeq ($(FCEXE), ifort)
    CLFS += -warn all -check all -fpe:0
  endif
endif

CFLAGS += -I$(OBJDIR)
CFLAGS += $(DFLAGS) $(VFLAGS)
CFLAGS := $(strip $(CFLAGS))
LFLAGS := $(strip $(LFLAGS))

SRC_MOD := module1.F90 module2.F90
SRC_PRO := program.F90
EXE_PRO := exe

OBJ_MOD := $(foreach f,$(SRC_MOD),$(OBJDIR)/$(f:.F90=.o))
OBJ_PRO := $(OBJDIR)/$(SRC_PRO:.F90=.o)

all : prep link

prep:
	@mkdir -p $(BINDIR) $(OBJDIR)

link: $(BINDIR)/$(EXE_PRO)

$(BINDIR)/$(EXE_PRO): $(OBJ_MOD) $(OBJ_PRO)
	$(FC) $(LFLAGS) $(CLFS) $^ -o $@

clear: clean
	-rm -f $(BINDIR)/*

clean:
	-rm -f $(OBJDIR)/*

vpath %.F90 $(SRCDIR)
.SUFFIXES: .F90 .o

$(OBJDIR)/%.o: %.F90
	$(FC) $(CFLAGS) $(CLFS) $(SRCDIR)/$(<F) -c -o $@

# vim:ft=make noet
