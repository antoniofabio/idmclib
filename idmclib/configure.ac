AC_PREREQ(2.61)
AC_INIT(idmclib, 0.5.0, [antonio.fabio _at_ gmail.com])
AM_INIT_AUTOMAKE
AC_CONFIG_SRCDIR(src)

# Checks for programs.
AC_PROG_LIBTOOL
AC_PROG_CC_C99
AC_PROG_F77
AC_F77_LIBRARY_LDFLAGS
AC_F77_WRAPPERS

# Checks for libraries.
AC_CHECK_LIB([m], [main])
AC_CHECK_LIB([gslcblas], [main])
AC_CHECK_LIB([gsl], [main])
AC_CHECK_LIB([lua50], [main])
AC_CHECK_LIB([lualib50], [main])

# Check for java stuff
AC_CANONICAL_HOST
case "${host_os}" in
  cygwin*|mingw*|windows*|winnt)
    AC_DEFINE(Win32, 1, [Define according to your operating system type.])
    JNIDIR="win32"
    ;;
  *solaris*)
    AC_DEFINE(Solaris, 1, [Define according to your operating system type.])
    JNIDIR="solaris"
    ;;
  *linux*)
    AC_DEFINE(Linux, 1, [Define according to your operating system type.])
    JNIDIR="linux"
    ;;
  *)
    AC_DEFINE(Unix, 1,
              [Define according to your operating system type.])
    JNIDIR="unix"
   ;;
esac
AC_SUBST(JNIDIR)
AM_CONDITIONAL(ISWIN, test $JNIDIR = "win32")

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
                 src/tests/Makefile
		jidmc/Makefile])
AC_OUTPUT
