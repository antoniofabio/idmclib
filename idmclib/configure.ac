AC_PREREQ(2.61)
AC_INIT(idmclib, 0.5.0, [Antonio, Fabio Di Narzo <antonio.fabio _at_ gmail.com>])
AM_INIT_AUTOMAKE
AC_CONFIG_SRCDIR(src)

# Checks for programs.
AC_PROG_RANLIB
AC_PROG_CC_C99
AC_PROG_F77
AC_F77_LIBRARY_LDFLAGS
AC_F77_WRAPPERS
AC_CHECK_PROG(SWIG, swig, yes, no)

# Checks for libraries.
AC_CHECK_LIB([gsl], [main])
AC_CHECK_LIB([gslcblas], [main])
AC_CHECK_LIB([m], [main])
AC_CHECK_LIB([lua], [main])
AC_CHECK_LIB([lualib], [main])

# Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADERS([stdlib.h string.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_C_INLINE
AC_TYPE_SIZE_T

# Checks for library functions.
AC_FUNC_MALLOC
AC_CHECK_FUNCS([memset sqrt])

AC_CONFIG_FILES([Makefile
                 src/Makefile
                 src/blas/Makefile
                 src/lapack/Makefile
                 src/tests/Makefile])
AC_OUTPUT
