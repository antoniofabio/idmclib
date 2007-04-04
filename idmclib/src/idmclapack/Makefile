include ../../Makefile.inc

MODULES = $(basename $(wildcard *.f) )
SRCS = $(addsuffix .f, $(MODULES))
OBJS = $(addsuffix .o, $(MODULES))

FFLAGS=-fPIC

all: liblapack.a

liblapack.a: $(OBJS)
	ar cr $@ $(OBJS)

clean:
	rm -f *.o libblas.a
