AC_INIT([RiDMC], 0.5.0)

AC_CHECK_LIB(m, main)
AC_CHECK_LIB(gslcblas, main)
AC_CHECK_LIB(gsl, main)

AC_CHECK_LIB(lua50, lua_open)
AC_CHECK_LIB(lualib50, main)

AC_CHECK_LIB(idmclib, main)

AC_SUBST(CPPFLAGS)
AC_SUBST(LIBS)
AC_CONFIG_FILES([src/Makevars])
AC_OUTPUT

