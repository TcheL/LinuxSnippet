#===============================================================================
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Wed 31 Dec 2020 11:05:36 AM CST
#-------------------------------------------------------------------------------

CUDAHOME := /data/software/cuda-10.0

CXX := g++
CCU := $(CUDAHOME)/bin/nvcc
CFLAGS := -O2
LFLAGS :=

SRCDIR := src
OBJDIR := obj
BINDIR := bin

TypeDouble :=
CPP_MACRO_DEF1 :=
CPP_MACRO_DEF2 := ON
CPP_MACRO_DEF3 := ON

DFLAG_LIST := TypeDouble CPP_MACRO_DEF1 CPP_MACRO_DEF2 CPP_MACRO_DEF3

LIBS := 
INCS := 
CUDALIB := -L$(CUDAHOME)/lib64 -lcudart
CUDAINC := -I$(CUDAHOME)/include

LIBFLAGS := $(LIBS) $(CUDALIB)
INCFLAGS := -I$(SRCDIR) $(INCS)
CCUFLAGS := $(CUDAINC) $(if $(TypeDouble),-arch=sm_60,-arch=sm_35)

DFLAGS := $(foreach f,$(DFLAG_LIST),$(if $($(f)),-D$(f),))
DFLAGS := $(strip $(DFLAGS))

SRC_CXX := class1.cpp class2.cpp class3.cpp
SRC_CCU := class.cu

SRC_PRO := main.cu
EXE_PRO := exe

OBJ_CXX := $(foreach f,$(SRC_CXX),$(OBJDIR)/cxx/$(f:.cpp=.o))
OBJ_CCU := $(foreach f,$(SRC_CCU),$(OBJDIR)/cuda/$(f:.cu=.o))
OBJ_PRO := $(OBJDIR)/cuda/$(SRC_PRO:.cu=.o)

all: prep link

prep:
	@mkdir -p $(BINDIR) $(OBJDIR)
	@mkdir -p $(OBJDIR)/cxx $(OBJDIR)/cuda

link: $(BINDIR)/$(EXE_PRO)

$(BINDIR)/$(EXE_PRO): $(OBJ_CXX) $(OBJ_CCU) $(OBJ_PRO)
	$(CXX) $(LFLAGS) $^ $(LIBFLAGS) -o $@

clear: clean
	-rm -f $(BINDIR)/*

clean:
	-rm -f $(OBJDIR)/cxx/*.o
	-rm -f $(OBJDIR)/cuda/*.o

$(OBJDIR)/cxx/%.o: $(SRCDIR)/%.cpp
	$(CXX) $(CFLAGS) $(DFLAGS) $(INCFLAGS) -c $< -o $@

$(OBJDIR)/cuda/%.o: $(SRCDIR)/%.cu
	$(CCU) $(CFLAGS) $(DFLAGS) $(INCFLAGS) $(CCUFLAGS) -c $< -o $@

# vim:ft=make noet
