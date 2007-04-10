INCLUDE_DIRECTORIES(${JAVA_INCLUDE_PATH})
INCLUDE_DIRECTORIES(${JAVA_INCLUDE_PATH2})
include_directories (${idmclib_SOURCE_DIR}/include)
link_directories (
${idmclib_BINARY_DIR}/src
${idmclib_BINARY_DIR}/src/idmcblas
${idmclib_BINARY_DIR}/src/idmclapack
)

FILE(MAKE_DIRECTORY ${idmclib_BINARY_DIR}/jidmc/org/tsho/jidmclib)
SET(CMAKE_SWIG_OUTDIR org/tsho/jidmclib)
SET(CMAKE_SWIG_FLAGS "-package org.tsho.jidmclib")

SWIG_ADD_MODULE(jidmclib java idmc.i)
SWIG_LINK_LIBRARIES( jidmclib 
	idmclib idmcblas idmclapack  
	${LUA_LIBRARY} ${LUALIB_LIBRARY} 
	${GSL_LIBRARY} ${GSLCBLAS_LIBRARY} ${M_LIBRARY} )

