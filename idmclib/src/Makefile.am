SUBDIRS = blas lapack tests
LDADD = ./blas/libblas.a ./lapack/liblapack.a -llua -llualib -lgsl -lgslcblas -lm

lib_LIBRARIES	= libidmclib.a
check_PROGRAMS	= tests/test_model tests/test_raster tests/test_cycles tests/test_traj tests/test_basin
TESTS		= $(check_PROGRAMS)
include_HEADERS = idmclib/basin.h idmclib/defines.h idmclib/lexp_aux.h idmclib/matrices.h idmclib/raster.h idmclib/cycles.h idmclib/gsl_rng_lualib.h idmclib/lexp.h idmclib/model.h idmclib/traj.h

libidmclib_a_SOURCES	= basin.c gsl_rng_lualib.c lexp_aux.c matrices.c raster.c cycles.c lexp.c model.c traj.c
libidmclib_a_DEPENDENCIES = blas lapack
