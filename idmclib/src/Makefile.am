SUBDIRS = blas lapack . tests
INCLUDES = -I./idmclib -I/usr/include/lua50
LIBADD = ./lapack/liblapack.la ./blas/libblas.la $(FLIBS)

include_HEADERS = idmclib/basin.h idmclib/defines.h idmclib/lexp_aux.h idmclib/matrices.h idmclib/raster.h idmclib/cycles.h idmclib/gsl_rng_lualib.h idmclib/lexp.h idmclib/model.h idmclib/traj.h
lib_LTLIBRARIES = libidmclib.la

libidmclib_la_SOURCES	= basin.c gsl_rng_lualib.c lexp_aux.c \
	matrices.c raster.c cycles.c lexp.c model.c traj.c
libidmclib_la_DEPENDENCIES = blas lapack
libidmclib_la_LDFLAGS = -static
