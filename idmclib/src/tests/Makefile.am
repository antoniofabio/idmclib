EXTRA_DIST = logistic.lua lorenz.lua test1.lua test2.lua
INCLUDES = -I.. -I/usr/include/lua50
LDADD = ../libidmclib.a ../lapack/liblapack.a ../blas/libblas.a $(FLIBS)

bin_PROGRAMS	= test_model test_raster test_cycles test_traj test_basin test_lexp
include_HEADERS = test_common.h minunit.h
test_model_SOURCES = test_model.c test_common.c
test_cycles_SOURCES = test_cycles.c test_common.c
test_traj_SOURCES = test_traj.c test_common.c
test_lexp_SOURCES = test_lexp.c test_common.c
test_raster_SOURCES = test_raster.c test_common.c
test_basin_SOURCES = test_basin.c test_common.c