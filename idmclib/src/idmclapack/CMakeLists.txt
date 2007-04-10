LINK_DIRECTORIES(../idmcblas)

add_library(idmclapack SHARED
dgebak.f  dhseqr.f  dlahrd.f  dlanv2.f  dlarft.f  dlassq.f  ieeeck.f
dgebal.f  dlabad.f  dlaln2.f  dlapy2.f  dlarfx.f  dorg2r.f  ilaenv.f
dgeev.f   dlacpy.f  dlamch.f  dlarfb.f  dlartg.f  dorghr.f  lsame.f
dgehd2.f  dladiv.f  dlange.f  dlarf.f   dlascl.f  dorgqr.f  xerbla.f
dgehrd.f  dlahqr.f  dlanhs.f  dlarfg.f  dlaset.f  dtrevc.f
)

TARGET_LINK_LIBRARIES(idmclapack idmcblas)

INSTALL(TARGETS idmclapack
        RUNTIME DESTINATION idmclib
        LIBRARY DESTINATION idmclib
        ARCHIVE DESTINATION idmclib)
