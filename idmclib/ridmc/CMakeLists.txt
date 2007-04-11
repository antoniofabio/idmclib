include_directories (${idmclib_SOURCE_DIR}/include
${R_HOME}/include
)
link_directories (
${idmclib_BINARY_DIR}/src
${idmclib_BINARY_DIR}/src/idmcblas
${idmclib_BINARY_DIR}/src/idmclapack
)

add_library(ridmc SHARED
basin.c  
cycles.c  
lexp.c  
model.c  
ridmc.c  
traj.c
)

SET_TARGET_PROPERTIES(ridmc PROPERTIES LINKER_LANGUAGE C)
TARGET_LINK_LIBRARIES (ridmc idmclib idmcblas idmclapack 
	${LUA_LIBRARY} ${LUALIB_LIBRARY} ${GSL_LIBRARY} ${GSLCBLAS_LIBRARY} ${FORTRAN_RUNTIME})

INSTALL(TARGETS ridmc
  RUNTIME DESTINATION lib/ridmc
  LIBRARY DESTINATION lib/ridmc
  ARCHIVE DESTINATION lib/ridmc
)

FILE(GLOB files "${CMAKE_CURRENT_SOURCE_DIR}/*.h")
INSTALL(FILES ${files} DESTINATION lib/ridmc)
FILE(GLOB files "${CMAKE_CURRENT_SOURCE_DIR}/*.c")
INSTALL(FILES ${files} DESTINATION lib/ridmc)
FILE(GLOB files "${CMAKE_CURRENT_SOURCE_DIR}/*.R")
INSTALL(FILES ${files} DESTINATION lib/ridmc)
FILE(GLOB files "${CMAKE_CURRENT_SOURCE_DIR}/*.lua")
INSTALL(FILES ${files} DESTINATION lib/ridmc)

