CMAKE_MINIMUM_REQUIRED(VERSION 2.4.5 FATAL_ERROR)

PROJECT(idmclib C)
FIND_PACKAGE(SWIG)
IF(SWIG_FOUND)
INCLUDE(${SWIG_USE_FILE})
INCLUDE(FindJNI)
INCLUDE(FindPythonInterp)
ENDIF(SWIG_FOUND)
FIND_PROGRAM(TEXI2HTML texi2html)
FIND_PROGRAM(TEXI2PDF texi2pdf)

SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "idmc: The iDMC C support library")
SET(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/README")
SET(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/license")
SET(CPACK_PACKAGE_VERSION_MAJOR 0)
SET(CPACK_PACKAGE_VERSION_MINOR 9)
SET(CPACK_PACKAGE_VERSION_PATCH 0)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/include/idmclib/version.h.cmake ${CMAKE_CURRENT_SOURCE_DIR}/include/idmclib/version.h)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/doc/version.texinfo.cmake ${CMAKE_CURRENT_SOURCE_DIR}/doc/version.texinfo)
SET(CMAKE_C_FLAGS --std=c99)

SET(CPACK_SOURCE_IGNORE_FILES "/\\\\.;~$;/_;build/;CMakeFiles/;CMakeCache;gz$;Makefile\\\\.;trace;Testing/;foo;autom4te;cmake_install;CPack;\\\\.pem;ltmain.sh;configure;libtool;/config\\\\.;missing;SCons;autogen.sh;install-sh;Dart;\\\\.svn/;aclocal;log$;Makefile$;\\\\.git$;pdf$")
INCLUDE(CPack)

FIND_PATH(LUA_INCLUDEDIR lua.h
  PATHS /usr/include /usr/local/include /usr/include/lua50 c:/mingw/include)
INCLUDE_DIRECTORIES(${LUA_INCLUDEDIR})
FIND_LIBRARY(LUA_LIBRARY NAMES lua50 lua
  PATHS  /usr/lib /usr/local/lib c:/mingw/lib)
FIND_LIBRARY(LUALIB_LIBRARY NAMES lualib50 lualib
  PATHS  /usr/lib /usr/local/lib c:/mingw/lib)
FIND_LIBRARY(GSL_LIBRARY gsl
  PATHS  /usr/lib /usr/local/lib c:/mingw/lib)
FIND_LIBRARY(GSLCBLAS_LIBRARY gslcblas
  PATHS  /usr/lib /usr/local/lib c:/mingw/lib)
FIND_LIBRARY(M_LIBRARY m
  PATHS  /usr/lib /usr/local/lib c:/mingw/lib)

CONFIGURE_FILE(${PROJECT_SOURCE_DIR}/idmclib.pc.cmake ${PROJECT_BINARY_DIR}/idmclib.pc @ONLY)

EXECUTE_PROCESS(
   COMMAND ${CMAKE_COMMAND} -E copy_directory
   ${PROJECT_SOURCE_DIR}/tests
   ${PROJECT_BINARY_DIR}/tests
)
ENABLE_TESTING()

add_subdirectory (src)

IF(SWIG_FOUND)
IF(JAVA_INCLUDE_PATH AND JAVA_INCLUDE_PATH2)
add_subdirectory(java)
ENDIF(JAVA_INCLUDE_PATH AND JAVA_INCLUDE_PATH2)
IF(PYTHON_EXECUTABLE)
#add_subdirectory(python)
ENDIF(PYTHON_EXECUTABLE)
ENDIF(SWIG_FOUND)

add_subdirectory (doc)
add_subdirectory (tests)

INSTALL(FILES AUTHORS BUGS ChangeLog license README DESTINATION lib/idmclib)
INSTALL(FILES ${PROJECT_BINARY_DIR}/idmclib.pc DESTINATION lib/pkgconfig)
INSTALL(DIRECTORY include/idmclib DESTINATION include)
