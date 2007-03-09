SUFFIXES = .f

.f.o:
	$(F77) $(FFLAGS) -c $<

lib_LTLIBRARIES = liblapack.la
liblapack_la_SOURCES = dgebak.f dgebal.f dgeev.f dgehd2.f dgehrd.f dhseqr.f dlabad.f dlacpy.f \
dladiv.f dlahqr.f dlahrd.f dlaln2.f dlamch.f dlange.f dlanhs.f dlanv2.f \
dlapy2.f dlarfb.f dlarf.f dlarfg.f dlarft.f dlarfx.f dlartg.f dlascl.f \
dlaset.f dlassq.f dorg2r.f dorghr.f dorgqr.f dtrevc.f ieeeck.f ilaenv.f \
lsame.f xerbla.f
liblapack_la_LDFLAGS = -static
