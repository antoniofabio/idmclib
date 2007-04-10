include_directories (${idmclib_SOURCE_DIR}/include
${R_HOME}/include
)
link_directories (
${idmclib_BINARY_DIR}/src
${idmclib_BINARY_DIR}/src/idmcblas
${idmclib_BINARY_DIR}/src/idmclapack
)

add_library(ridmc SHARED
basin.c  
cycles.c  
lexp.c  
model.c  
ridmc.c  
traj.c
)

SET_TARGET_PROPERTIES(ridmc PROPERTIES LINKER_LANGUAGE C)
TARGET_LINK_LIBRARIES (ridmc idmclib idmcblas idmclapack 
	${LUA_LIBRARY} ${LUALIB_LIBRARY} ${GSL_LIBRARY} ${GSLCBLAS_LIBRARY})

