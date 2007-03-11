SUBDIRS = idmcblas idmclapack . tests
INCLUDES = -I./idmclib

nobase_include_HEADERS = idmclib/basin.h idmclib/defines.h idmclib/lexp_aux.h \
	idmclib/matrices.h idmclib/raster.h idmclib/cycles.h \
	idmclib/gsl_rng_lualib.h idmclib/lexp.h idmclib/model.h \
	idmclib/traj.h

lib_LTLIBRARIES = libidmclib.la

libidmclib_la_SOURCES	= basin.c gsl_rng_lualib.c lexp_aux.c \
	matrices.c raster.c cycles.c lexp.c model.c traj.c
libidmclib_la_LIBADD = ./idmclapack/libidmclapack.la \
	./idmcblas/libidmcblas.la $(FLIBS)
libidmclib_la_DEPENDENCIES = idmcblas idmclapack

