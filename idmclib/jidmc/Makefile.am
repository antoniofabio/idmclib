EXTRA_DIST = invalid.lua  logistic.lua  lorenz.lua  runtimeError.lua  syntaxError.lua \
	idmc_basin.i  idmc_cycles.i  idmc.i  idmc_lexp.i  idmc_model.i  idmc_raster.i  idmc_traj.i \
	main.java org
BUILT_SOURCES = idmc_wrap.c
INCLUDES = -D_JNI_IMPLEMENTATION_ -I$(JAVA_HOME)/include -I$(JAVA_HOME)/include/$(JNIDIR) -I../src

if !ISWIN
lib_LTLIBRARIES	= libjidmclib.la
libjidmclib_la_SOURCES = idmc_wrap.c
libjidmclib_la_LIBADD = ../src/libidmclib.a ../src/lapack/liblapack.a ../src/blas/libblas.a $(FLIBS)
else ISWIN
all: jidmclib.dll
jidmclib.dll: idmc_wrap.o
	gcc -shared -static $< $(LDFLAGS) $(CFLAGS) -Wl,--kill-at \
		../src/libidmclib.a ../src/lapack/liblapack.a ../src/blas/libblas.a $(LIBS)\
		$(FLIBS) -o $@
endif ISWIN

idmc_wrap.c: idmc.i idmc_model.i idmc_traj.i idmc_cycles.i idmc_lexp.i idmc_raster.i idmc_basin.i
	swig -java -package org.tsho.jidmclib -outdir org/tsho/jidmclib $<
