SUFFIXES = .f
.f.o:
       $(F77) $(FFLAGS) -c $<

lib_LIBRARIES = libblas.a
libblas_a_SOURCES = daxpy.f ddot.f dgemv.f dnrm2.f dscal.f dtrmm.f idamax.f \
	dcopy.f dgemm.f dger.f drot.f dswap.f dtrmv.f
