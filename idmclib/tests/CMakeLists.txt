include_directories (${idmclib_SOURCE_DIR}/include)
link_directories (
${idmclib_BINARY_DIR}/src
)
LINK_LIBRARIES( idmclib
	${LUA_LIBRARY} ${LUALIB_LIBRARY}
	${GSL_LIBRARY} ${GSLCBLAS_LIBRARY} ${M_LIBRARY})

add_executable ( test_model test_model.c  test_common.c)
add_executable ( test_errors test_errors.c  test_common.c)
add_executable ( test_basin test_basin.c  test_common.c)
add_executable ( test_basin_slow test_basin_slow.c test_common.c)
add_executable ( test_cycles test_cycles.c  test_common.c)
add_executable ( test_lexp test_lexp.c  test_common.c)
add_executable ( test_raster test_lexp.c  test_common.c)

SET_TARGET_PROPERTIES(test_model PROPERTIES LINKER_LANGUAGE C)
SET_TARGET_PROPERTIES(test_errors PROPERTIES LINKER_LANGUAGE C)
SET_TARGET_PROPERTIES(test_basin PROPERTIES LINKER_LANGUAGE C)
SET_TARGET_PROPERTIES(test_basin_slow PROPERTIES LINKER_LANGUAGE C)
SET_TARGET_PROPERTIES(test_cycles PROPERTIES LINKER_LANGUAGE C)
SET_TARGET_PROPERTIES(test_lexp PROPERTIES LINKER_LANGUAGE C)
SET_TARGET_PROPERTIES(test_raster PROPERTIES LINKER_LANGUAGE C)

ADD_TEST(model ${idmclib_BINARY_DIR}/tests/test_model)
ADD_TEST(errors ${idmclib_BINARY_DIR}/tests/test_errors)
ADD_TEST(basin ${idmclib_BINARY_DIR}/tests/test_basin)
ADD_TEST(basin_slow ${idmclib_BINARY_DIR}/tests/test_basin_slow) 
ADD_TEST(raster ${idmclib_BINARY_DIR}/tests/test_raster)
ADD_TEST(lexp ${idmclib_BINARY_DIR}/tests/test_lexp)
ADD_TEST(cycles ${idmclib_BINARY_DIR}/tests/test_cycles)

FILE(GLOB files "${CMAKE_CURRENT_SOURCE_DIR}/*.lua")
INSTALL(FILES ${files} DESTINATION lib/idmclib/tests)
INSTALL(TARGETS test_model test_errors test_basin test_basin_slow test_cycles test_lexp test_raster
  RUNTIME DESTINATION lib/idmclib/tests
  LIBRARY DESTINATION lib/idmclib/tests
  ARCHIVE DESTINATION lib/idmclib/tests
)

