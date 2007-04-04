include_directories (${idmclib_SOURCE_DIR}/include)
link_directories (
${idmclib_BINARY_DIR}/src
${idmclib_BINARY_DIR}/src/idmcblas
${idmclib_BINARY_DIR}/src/idmclapack
)

add_executable ( test_model test_model.c  test_common.c)

target_link_libraries ( test_model idmclib lua50 lualib50 gsl gslcblas idmcblas idmclapack )

SET_TARGET_PROPERTIES(test_model PROPERTIES LINKER_LANGUAGE C)
