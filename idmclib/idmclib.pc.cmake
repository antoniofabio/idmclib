prefix=@CMAKE_INSTALL_PREFIX@
exec_prefix=${prefix}
libdir=${exec_prefix}/lib
includedir=${prefix}/include

Name: idmclib
Description: interactive Dynamical Model Calculator library 
Version: @CPACK_PACKAGE_VERSION_MAJOR@.@CPACK_PACKAGE_VERSION_MINOR@.@CPACK_PACKAGE_VERSION_PATCH@
Libs: ${libdir}/@CMAKE_STATIC_LIBRARY_PREFIX@idmclib@CMAKE_STATIC_LIBRARY_SUFFIX@ @LUA_LIBRARY@ @LUALIB_LIBRARY@ @GSL_LIBRARY@ @GSLCBLAS_LIBRARY@ @M_LIBRARY@
Cflags: -I${includedir} -I@LUA_INCLUDEDIR@
