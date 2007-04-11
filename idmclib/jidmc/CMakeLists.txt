INCLUDE_DIRECTORIES(${JAVA_INCLUDE_PATH})
INCLUDE_DIRECTORIES(${JAVA_INCLUDE_PATH2})
include_directories (${idmclib_SOURCE_DIR}/include)
link_directories (
${idmclib_BINARY_DIR}/src
${idmclib_BINARY_DIR}/src/idmcblas
${idmclib_BINARY_DIR}/src/idmclapack
)

#FILE(MAKE_DIRECTORY ${idmclib_BINARY_DIR}/jidmc/org/tsho/jidmclib)
SET(CMAKE_SWIG_OUTDIR org/tsho/jidmclib)
SET(CMAKE_SWIG_FLAGS -package org.tsho.jidmclib)

SWIG_ADD_MODULE(jidmclib java idmc.i)
SWIG_LINK_LIBRARIES( jidmclib 
	idmclib idmcblas idmclapack  
	${LUA_LIBRARY} ${LUALIB_LIBRARY} 
	${GSL_LIBRARY} ${GSLCBLAS_LIBRARY} ${M_LIBRARY} ${FORTRAN_RUNTIME})
IF(WIN32 AND NOT UNIX)
SET_TARGET_PROPERTIES(jidmclib PROPERTIES COMPILE_FLAGS -D_JNI_IMPLEMENTATION)
SET_TARGET_PROPERTIES(jidmclib PROPERTIES LINK_FLAGS -Wl,--kill-at)
ENDIF(WIN32 AND NOT UNIX)


INSTALL(TARGETS jidmclib DESTINATION lib/jidmclib)
INSTALL(DIRECTORY ${idmclib_BINARY_DIR}/jidmc/org DESTINATION lib/jidmclib
#PATTERN ".svn" EXCLUDE
)
FILE(GLOB files "${CMAKE_CURRENT_BIN_DIR}/*.c")
INSTALL(FILES ${files} DESTINATION lib/jidmclib)
FILE(GLOB files "${CMAKE_CURRENT_SOURCE_DIR}/*.i")
INSTALL(FILES ${files} DESTINATION lib/jidmclib)
FILE(GLOB files "${CMAKE_CURRENT_SOURCE_DIR}/*.java")
INSTALL(FILES ${files} DESTINATION lib/jidmclib)
FILE(GLOB files "${CMAKE_CURRENT_SOURCE_DIR}/*.lua")
INSTALL(FILES ${files} DESTINATION lib/jidmclib)

