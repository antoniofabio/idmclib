add_library(idmcblas SHARED
daxpy.f  ddot.f   dgemv.f  dnrm2.f  dscal.f  dtrmm.f  idamax.f
dcopy.f  dgemm.f  dger.f   drot.f   dswap.f  dtrmv.f
)

INSTALL(TARGETS idmcblas
        RUNTIME DESTINATION idmclib
        LIBRARY DESTINATION idmclib
        ARCHIVE DESTINATION idmclib)

