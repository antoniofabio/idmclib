IF(WIN32 AND NOT UNIX)
add_library(idmcblas STATIC
daxpy.f  ddot.f   dgemv.f  dnrm2.f  dscal.f  dtrmm.f  idamax.f
dcopy.f  dgemm.f  dger.f   drot.f   dswap.f  dtrmv.f
)
ELSE(WIN32 AND NOT UNIX)
add_library(idmcblas SHARED
daxpy.f  ddot.f   dgemv.f  dnrm2.f  dscal.f  dtrmm.f  idamax.f
dcopy.f  dgemm.f  dger.f   drot.f   dswap.f  dtrmv.f
)
ENDIF(WIN32 AND NOT UNIX)

INSTALL(TARGETS idmcblas
        RUNTIME DESTINATION idmclib
        LIBRARY DESTINATION idmclib
        ARCHIVE DESTINATION idmclib)

