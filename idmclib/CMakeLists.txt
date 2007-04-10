#Change PROJECT_NAME to the name of your project
PROJECT(idmclib C Fortran)
FIND_PACKAGE(SWIG REQUIRED)
INCLUDE(${SWIG_USE_FILE})
INCLUDE(FindJNI)

SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "idmc: The iDMC C support library")
SET(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/doc/README")
SET(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/license")
SET(CPACK_PACKAGE_VERSION_MAJOR "0")
SET(CPACK_PACKAGE_VERSION_MINOR "5")
SET(CPACK_PACKAGE_VERSION_PATCH "0")
INCLUDE(CPack)

SET(CMAKE_C_FLAGS --std=c99)

FIND_PATH(LUA_INCLUDEDIR lua.h
  PATHS /usr/include /usr/local/include /usr/include/lua50)
INCLUDE_DIRECTORIES(${LUA_INCLUDEDIR})
FIND_LIBRARY(LUA_LIBRARY NAMES lua50 lua
  PATHS  /usr/lib /usr/local/lib)
FIND_LIBRARY(LUALIB_LIBRARY NAMES lualib50 lualib
  PATHS  /usr/lib /usr/local/lib)
FIND_LIBRARY(GSL_LIBRARY gsl
  PATHS  /usr/lib /usr/local/lib)
FIND_LIBRARY(GSLCBLAS_LIBRARY gslcblas
  PATHS  /usr/lib /usr/local/lib)
FIND_LIBRARY(M_LIBRARY m
  PATHS  /usr/lib /usr/local/lib)

FIND_PATH(R_HOME  include/R.h /usr/local/lib/R /usr/local/lib64/R)

ENABLE_TESTING()
ADD_TEST(model tests/test_model)

add_subdirectory (src)
add_subdirectory (ridmc)
add_subdirectory (jidmc)
#add_subdirectory (doc)
#add_subdirectory (pyidmc)
add_subdirectory (tests)

INSTALL(FILES ChangeLog license VERSION
	DESTINATION idmclib)

