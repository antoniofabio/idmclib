SET(SOURCES
daxpy.f  ddot.f   dgemv.f  dnrm2.f  dscal.f  dtrmm.f  idamax.f
dcopy.f  dgemm.f  dger.f   drot.f   dswap.f  dtrmv.f)

LINK_LIBRARIES(${FORTRAN_RUNTIME})

IF(WIN32 AND NOT UNIX)
add_library(idmcblas STATIC ${SOURCES})
ELSE(WIN32 AND NOT UNIX)
add_library(idmcblas SHARED ${SOURCES})
ENDIF(WIN32 AND NOT UNIX)

INSTALL(TARGETS idmcblas
        RUNTIME DESTINATION lib
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib)

