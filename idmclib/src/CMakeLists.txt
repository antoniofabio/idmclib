SET(SOURCES
attractor.c
attractors_list.c
basin.c
basin_common.c
basin_slow.c
basin_multi.c
gsl_rng_lualib.c
lexp.c
model.c
traj.c
cycles.c
lexp_aux.c
matrices.c
raster.c
version.c
)

INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR}/include/idmclib)

add_library(idmclib STATIC ${SOURCES})

TARGET_LINK_LIBRARIES (idmclib
	${LUA_LIBRARY} ${LUALIB_LIBRARY} ${GSL_LIBRARY} ${GSLCBLAS_LIBRARY} ${M_LIBRARY})

INSTALL(TARGETS idmclib
	RUNTIME DESTINATION lib
	LIBRARY DESTINATION lib
	ARCHIVE DESTINATION lib)
