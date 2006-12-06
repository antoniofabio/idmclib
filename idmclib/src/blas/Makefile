include ../../Makefile.inc

MODULES = $(basename $(wildcard *.f) )
SRCS = $(addsuffix .f, $(MODULES))
OBJS = $(addsuffix .o, $(MODULES))

FFLAGS=-fPIC

all: libblas.a

libblas.a: $(OBJS)
	ar cr $@ $(OBJS)

clean:
	rm -f *.o libblas.a
