add_subdirectory(idmcblas)
add_subdirectory(idmclapack)

add_library(idmclib 
basin.c
gsl_rng_lualib.c
lexp.c
model.c
traj.c
cycles.c
lexp_aux.c
matrices.c
raster.c)

