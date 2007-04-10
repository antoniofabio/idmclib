include_directories (${idmclib_SOURCE_DIR}/include)
link_directories (
${idmclib_BINARY_DIR}/src
${idmclib_BINARY_DIR}/src/idmcblas
${idmclib_BINARY_DIR}/src/idmclapack
)
LINK_LIBRARIES( idmclib idmclapack idmcblas
	${LUA_LIBRARY} ${LUALIB_LIBRARY}
	${GSL_LIBRARY} ${GSLCBLAS_LIBRARY} ${M_LIBRARY})

add_executable ( test_model test_model.c  test_common.c)
add_executable ( test_basin test_basin.c  test_common.c)
add_executable ( test_cycles test_cycles.c  test_common.c)
add_executable ( test_lexp test_lexp.c  test_common.c)
add_executable ( test_raster test_lexp.c  test_common.c)

SET_TARGET_PROPERTIES(test_model PROPERTIES LINKER_LANGUAGE C)
SET_TARGET_PROPERTIES(test_basin PROPERTIES LINKER_LANGUAGE C)
SET_TARGET_PROPERTIES(test_cycles PROPERTIES LINKER_LANGUAGE C)
SET_TARGET_PROPERTIES(test_lexp PROPERTIES LINKER_LANGUAGE C)
SET_TARGET_PROPERTIES(test_raster PROPERTIES LINKER_LANGUAGE C)

FILE(GLOB files "${CMAKE_CURRENT_SOURCE_DIR}/*.lua")
INSTALL(FILES ${files} DESTINATION idmclib/tests)
INSTALL(TARGETS test_model test_basin test_cycles test_lexp test_raster
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
)
