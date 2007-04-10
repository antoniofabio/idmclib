add_subdirectory(idmcblas)
add_subdirectory(idmclapack)

IF(WIN32 AND NOT UNIX)
add_library(idmclib STATIC
basin.c
gsl_rng_lualib.c
lexp.c
model.c
traj.c
cycles.c
lexp_aux.c
matrices.c
raster.c)
ELSE(WIN32 AND NOT UNIX)
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
ENDIF(WIN32 AND NOT UNIX)


SET_TARGET_PROPERTIES(idmclib PROPERTIES LINKER_LANGUAGE C)
TARGET_LINK_LIBRARIES (idmclib idmcblas idmclapack 
	${LUA_LIBRARY} ${LUALIB_LIBRARY} ${GSL_LIBRARY} ${GSLCBLAS_LIBRARY} ${M_LIBRARY})

INSTALL(TARGETS idmclib
	RUNTIME DESTINATION idmclib
	LIBRARY DESTINATION idmclib
	ARCHIVE DESTINATION idmclib)
FILE(GLOB files "${CMAKE_CURRENT_SOURCE_DIR}/*.h")
INSTALL(FILES ${files} DESTINATION include)

