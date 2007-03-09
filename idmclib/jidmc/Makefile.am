EXTRA_DIST = invalid.lua  logistic.lua  lorenz.lua  runtimeError.lua  syntaxError.lua main.java
BUILT_SOURCES = idmc_wrap.c
INCLUDES = -I$(JAVA_HOME)/include -I$(JAVA_HOME)/include/$(JNIDIR) -I../src `lua-config50 --include`

lib_LTLIBRARIES	= libjidmclib.la
libjidmclib_la_SOURCES = idmc_wrap.c
libjidmclib_la_LDFLAGS = ../src/libidmclib.a ../src/lapack/liblapack.a ../src/blas/libblas.a $(FLIBS)

idmc_wrap.c: idmc.i idmc_model.i idmc_traj.i idmc_cycles.i idmc_lexp.i idmc_raster.i idmc_basin.i
	swig -java -package org.tsho.jidmclib -outdir org/tsho/jidmclib $<
