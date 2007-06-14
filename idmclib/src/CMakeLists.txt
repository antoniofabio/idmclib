add_subdirectory(idmcblas)
add_subdirectory(idmclapack)

SET(SOURCES 
basin.c
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

IF(WIN32 AND NOT UNIX)
add_library(idmclib STATIC ${SOURCES})
ELSE(WIN32 AND NOT UNIX)
add_library(idmclib STATIC ${SOURCES})
ENDIF(WIN32 AND NOT UNIX)


SET_TARGET_PROPERTIES(idmclib PROPERTIES LINKER_LANGUAGE C)
TARGET_LINK_LIBRARIES (idmclib idmcblas idmclapack 
	${LUA_LIBRARY} ${LUALIB_LIBRARY} ${GSL_LIBRARY} ${GSLCBLAS_LIBRARY} ${M_LIBRARY} ${FORTRAN_RUNTIME})

INSTALL(TARGETS idmclib
	RUNTIME DESTINATION lib
	LIBRARY DESTINATION lib
	ARCHIVE DESTINATION lib)

