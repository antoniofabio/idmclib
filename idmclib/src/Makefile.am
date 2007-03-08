SUBDIRS = blas lapack tests
LDADD = ./blas/libblas.a ./lapack/liblapack.a -llua -llualib -lgsl -lgslcblas -lm

lib_LIBRARIES	= libidmclib.a
check_PROGRAMS	= tests/test_model tests/test_raster tests/test_cycles tests/test_traj tests/test_basin
TESTS		= $(check_PROGRAMS)
include_HEADERS = basin.h defines.h lexp_aux.h matrices.h raster.h cycles.h gsl_rng_lualib.h lexp.h model.h traj.h

libidmclib_a_SOURCES	= basin.c gsl_rng_lualib.c lexp_aux.c matrices.c raster.c cycles.c lexp.c model.c traj.c
libidmclib_a_DEPENDENCIES = blas lapack
