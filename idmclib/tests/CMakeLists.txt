include_directories (${idmclib_SOURCE_DIR}/include)
link_directories (
${idmclib_BINARY_DIR}/src
${idmclib_BINARY_DIR}/src/idmcblas
${idmclib_BINARY_DIR}/src/idmclapack
)

add_executable ( test_model test_model.c  test_common.c)
add_executable ( test_basin test_basin.c  test_common.c)
add_executable ( test_cycles test_cycles.c  test_common.c)
add_executable ( test_lexp test_lexp.c  test_common.c)
add_executable ( test_raster test_lexp.c  test_common.c)

target_link_libraries (test_model idmclib lua50 lualib50 gsl gslcblas idmcblas idmclapack )
target_link_libraries (test_basin idmclib lua50 lualib50 gsl gslcblas idmcblas idmclapack )
target_link_libraries (test_cycles idmclib lua50 lualib50 gsl gslcblas idmcblas idmclapack )
target_link_libraries (test_lexp idmclib lua50 lualib50 gsl gslcblas idmcblas idmclapack )
target_link_libraries (test_raster idmclib lua50 lualib50 gsl gslcblas idmcblas idmclapack )

SET_TARGET_PROPERTIES(test_model PROPERTIES LINKER_LANGUAGE C)
SET_TARGET_PROPERTIES(test_basin PROPERTIES LINKER_LANGUAGE C)
SET_TARGET_PROPERTIES(test_cycles PROPERTIES LINKER_LANGUAGE C)
SET_TARGET_PROPERTIES(test_lexp PROPERTIES LINKER_LANGUAGE C)
SET_TARGET_PROPERTIES(test_raster PROPERTIES LINKER_LANGUAGE C)

