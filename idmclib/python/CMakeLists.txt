include_directories (${idmclib_SOURCE_DIR}/include)
link_directories (${idmclib_BINARY_DIR}/src)

SWIG_ADD_MODULE(pyidmclib python idmc.i)
SWIG_LINK_LIBRARIES(pyidmclib
	idmclib ${LUA_LIBRARY} ${LUALIB_LIBRARY}
	${GSL_LIBRARY} ${GSLCBLAS_LIBRARY} ${M_LIBRARY})
SET_TARGET_PROPERTIES(pyidmclib PROPERTIES COMPILE_FLAGS ${PYTHON_CFLAGS})

INSTALL(TARGETS pyidmclib DESTINATION lib/pyidmclib)
INSTALL(DIRECTORY ${idmclib_BINARY_DIR}/pyidmclib DESTINATION lib/pyidmclib)
FILE(GLOB files "${CMAKE_CURRENT_BIN_DIR}/*.c")
INSTALL(FILES ${files} DESTINATION lib/pyidmclib)
FILE(GLOB files "${CMAKE_CURRENT_SOURCE_DIR}/*.i")
INSTALL(FILES ${files} DESTINATION lib/pyidmclib)
FILE(GLOB files "${CMAKE_CURRENT_SOURCE_DIR}/*.py")
INSTALL(FILES ${files} DESTINATION lib/pyidmclib)
FILE(GLOB files "${CMAKE_CURRENT_SOURCE_DIR}/*.lua")
INSTALL(FILES ${files} DESTINATION lib/pyidmclib)
