#===============================================================================
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Wed 30 Dec 2020 09:32:34 PM CST
#-------------------------------------------------------------------------------

FC := gfortran
CFLAGS := 
LFALGS :=

SRCDIR := src
OBJDIR := obj
BINDIR := bin

CPPMACRO1 := ON
CPPMACRO2 :=
CPPMACRO3 :=

DFLAG_LIST := CPPMACRO1 CPPMACRO2 CPPMACRO3

DFLAGS := $(foreach flag, $(DFLAG_LIST), $(if $($(flag)), -D$(flag),)) $(DFLAGS)

ifeq ($(notdir $(FC)), gfortran)
  CFLAGS := $(CFLAGS) -J$(OBJDIR)
else ifeq ($(notdir $(FC)), ifort)
  CFLAGS := $(CFLAGS) -module $(OBJDIR)
endif

CFLAGS := $(CFLAGS) -I$(OBJDIR)
CFLAGS := $(CFLAGS) $(DFLAGS)
CFLAGS := $(strip $(CFLAGS))

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
	$(FC) $(LFLAGS) $^ -o $@

clear: clean
	-rm -f $(BINDIR)/*

clean:
	-rm -f $(OBJDIR)/*

vpath %.F90 $(SRCDIR)
.SUFFIXES: .F90 .o

$(OBJDIR)/%.o : %.F90
	$(FC) $(CFLAGS) $(SRCDIR)/$(<F) -c -o $@

# vim:ft=make noet
