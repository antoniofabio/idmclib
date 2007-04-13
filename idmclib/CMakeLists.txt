PROJECT(idmclib C Fortran)
FIND_PACKAGE(SWIG)
INCLUDE(${SWIG_USE_FILE})
INCLUDE(FindJNI)

SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "idmc: The iDMC C support library")
SET(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/doc/README")
SET(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/license")
SET(CPACK_PACKAGE_VERSION_MAJOR "0")
SET(CPACK_PACKAGE_VERSION_MINOR "5")
SET(CPACK_PACKAGE_VERSION_PATCH "0")
SET(CPACK_SOURCE_IGNORE_FILES "/\\\\.;~$;/_;build/;CMakeFiles/;CMakeCache;gz$;Makefile\\\\.;trace;Testing/;foo;autom4te;cmake_install;CPack;\\\\.pem;ltmain.sh;configure;libtool;/config\\\\.;missing;SCons;autogen.sh;install-sh;Dart;\\\\.svn/;aclocal;log$;Makefile$")
INCLUDE(CPack)

SET(CMAKE_C_FLAGS --std=c99)

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
FIND_LIBRARY(FORTRAN_RUNTIME g2c gfortran
  PATHS  /usr/lib /usr/local/lib c:/mingw/lib)

FIND_PATH(R_HOME  include/R.h 
/usr/local/lib/R 
/usr/local/lib64/R 
c:/programmi/R/R-2.4.0
c:/programmi/R/R-2.4.1
c:/programmi/R/R-2.5.0
)
FIND_LIBRARY(R_RUNTIME R
PATHS ${R_HOME}/lib
/usr/lib
/usr/local/lib
/usr/local/lib64
)
EXECUTE_PROCESS(
   COMMAND ${CMAKE_COMMAND} -E copy_directory
   ${PROJECT_SOURCE_DIR}/tests
   ${PROJECT_BINARY_DIR}/tests
)
ENABLE_TESTING()

add_subdirectory (src)
IF(R_HOME)
add_subdirectory (ridmc)
ELSE(R_HOME)
MESSAGE(STATUS "R_HOME not found: not building R bindings. 
If you want to build R bindings, try manually setting the R_HOME variable")
ENDIF(R_HOME)
IF(JAVA_INCLUDE_PATH AND JAVA_INCLUDE_PATH2 AND SWIG_EXECUTABLE)
add_subdirectory (jidmc)
ELSE(JAVA_INCLUDE_PATH AND JAVA_INCLUDE_PATH2 AND SWIG_EXECUTABLE)
MESSAGE(STATUS "Java include paths and/or swig executable not found: not building Java bindings. 
If you want to build Java bindings, try manually setting JAVA_INCLUDE_PATH, JAVA_INCLUDE_PATH2 
and/or SWIG_DIR, SWIG_EXECUTABLE variables")
ENDIF(JAVA_INCLUDE_PATH AND JAVA_INCLUDE_PATH2 AND SWIG_EXECUTABLE)
#add_subdirectory (doc)
#add_subdirectory (pyidmc)
add_subdirectory (tests)

INSTALL(FILES AUTHORS BUGS ChangeLog license VERSION
	DESTINATION lib/idmclib)
INSTALL(DIRECTORY doc DESTINATION lib/idmclib)
INSTALL(DIRECTORY include/idmclib DESTINATION include)


