add_subdirectory(idmcblas)
add_subdirectory(idmclapack)

add_library(idmclib SHARED
basin.c
gsl_rng_lualib.c
lexp.c
model.c
traj.c
cycles.c
lexp_aux.c
matrices.c
raster.c)


SET_TARGET_PROPERTIES(idmclib PROPERTIES LINKER_LANGUAGE C)
TARGET_LINK_LIBRARIES (idmclib idmclapack idmclapack)

