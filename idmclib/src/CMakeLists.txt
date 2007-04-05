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
TARGET_LINK_LIBRARIES (idmclib idmcblas idmclapack 
	${LUA_LIBRARY} ${LUALIB_LIBRARY} ${GSL_LIBRARY} ${GSLCBLAS_LIBRARY} ${M_LIBRARY})

