#===============================================================================
# Author: Tche L., USTC, seistche@gmail.com
# Created at: Wed 31 Dec 2020 11:05:36 AM CST
#-------------------------------------------------------------------------------

CUDAHOME=/data/software/cuda-10.0

CXX := g++
CCU := $(CUDAHOME)/bin/nvcc
CFLAGS := -O2

SRCDIR := src
OBJDIR := obj
BINDIR := bin

TypeDouble :=
CPPMACRO1 :=
CPPMACRO2 := ON
CPPMACRO3 := ON

DFLAG_LIST = TypeDouble CPPMACRO1 CPPMACRO2 CPPMACRO3

LIBS := 
INCS := 
CUDALIB := -L$(CUDAHOME)/lib64 -lcudart
CUDAINC := -I$(CUDAHOME)/include

LIBFLAGS := $(LIBS) $(CUDALIB)
INCFLAGS := -I$(SRCDIR) $(INCS)

CXXFLAGS := $(INCFLAGS) $(CFLAGS)
CCUFLAGS := $(INCFLAGS) $(CFLAGS) $(CUDAINC)
CCUFLAGS := $(CCUFLAGS) $(if $(TypeDouble),-arch=sm_60,-arch=sm_35)

DFLAGS := $(foreach flag,$(DFLAG_LIST),$(if $($(flag)),-D$(flag),)) $(DFLAGS)
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
	$(CXX) $(LIBFLAGS) $^ -o $@

clear: clean
	-rm -f $(BINDIR)/*

clean:
	-rm -f $(OBJDIR)/cxx/*.o
	-rm -f $(OBJDIR)/cuda/*.o

$(OBJDIR)/cxx/%.o : $(SRCDIR)/%.cpp
	$(CXX) $(DFLAGS) $(CXXFLAGS) -c $< -o $@

$(OBJDIR)/cuda/%.o : $(SRCDIR)/%.cu
	$(CCU) $(DFLAGS) $(CCUFLAGS) -c $< -o $@

# vim:ft=make noet
