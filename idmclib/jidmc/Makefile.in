CFLAGS += -I../src $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) \
	$(CPPFLAGS) $(AM_CFLAGS)

LDFLAGS := ../src/libidmclib.a ../src/lapack/liblapack.a ../src/blas/libblas.a -lg2c `gsl-config --libs` `lua-config --libs`

MODULES = idmc

SWIG_SRC = $(addsuffix .i, $(MODULES))
SWIG_OPTS = -java -package org.tsho.jidmclib -outdir org/tsho/jidmclib

C_SRCS = $(addsuffix _wrap.c, $(MODULES))

T = $(addsuffix .so, $(MODULES))

all: $(T)

$(C_SRCS): %_wrap.c: %.i idmc_model.i idmc_traj.i idmc_cycles.i idmc_lexp.i idmc_raster.i idmc_basin.i
	swig $(SWIG_OPTS) $<

$(T): idmc_wrap.o
	$(LD) -shared $< $(LDFLAGS) -o $@

clean:	
	rm -f *.o *$(SHLIB_EXT) *.d *wrap.c *.class org/tsho/jidmclib/*
