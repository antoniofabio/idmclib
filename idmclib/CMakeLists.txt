#Change PROJECT_NAME to the name of your project
PROJECT(idmclib C Fortran)
FIND_PACKAGE(SWIG REQUIRED)
INCLUDE(${SWIG_USE_FILE})
INCLUDE(FindJNI)
FILE(MAKE_DIRECTORY ${idmclib_BINARY_DIR}/jidmc/org/tsho/jidmclib)

SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "idmc: The iDMC C support library")
SET(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/doc/README")
SET(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/license")
SET(CPACK_PACKAGE_VERSION_MAJOR "0")
SET(CPACK_PACKAGE_VERSION_MINOR "5")
SET(CPACK_PACKAGE_VERSION_PATCH "0")
#SET(CPACK_SOURCE_IGNORE_FILES "/CVS/;/\\.svn/;.*~")
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
FIND_LIBRARY(FORTRAN_RUNTIME g2c
  PATHS  /usr/lib /usr/local/lib c:/mingw/lib)

FIND_PATH(R_HOME  include/R.h /usr/local/lib/R /usr/local/lib64/R c:/programmi/R/R-2.4.0)
EXECUTE_PROCESS(
   COMMAND ${CMAKE_COMMAND} -E copy_directory
   ${PROJECT_SOURCE_DIR}/tests
   ${PROJECT_BINARY_DIR}/tests
)
ENABLE_TESTING()

add_subdirectory (src)
add_subdirectory (ridmc)
add_subdirectory (jidmc)
#add_subdirectory (doc)
#add_subdirectory (pyidmc)
add_subdirectory (tests)

INSTALL(FILES ChangeLog license VERSION
	DESTINATION idmclib)
INSTALL(DIRECTORY doc DESTINATION idmclib)


