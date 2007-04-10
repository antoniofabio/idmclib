include_directories (${idmclib_SOURCE_DIR}/include
/usr/local/lib/R/include
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

#TODO: set include dirs (to be searched during configuration in top dir)
SET_TARGET_PROPERTIES(ridmc PROPERTIES LINKER_LANGUAGE C)
TARGET_LINK_LIBRARIES (ridmc idmclib idmcblas idmclapack 
	${LUA_LIBRARY} ${LUALIB_LIBRARY} ${GSL_LIBRARY} ${GSLCBLAS_LIBRARY})

