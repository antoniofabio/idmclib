LUA_CFLAGS = `lua-config50 --include`
LUA_LIBS = `lua-config50 --libs`
GSL_CFLAGS = `gsl-config --cflags`
GSL_LIBS = `gsl-config --libs`
LAPACK_LIBS = -lblas -llapack
#LAPACK_LIBS = $(SRCDIR)/lapack/liblapack.a $(SRCDIR)/blas/libblas.a -lgfortran
LIB_LDFLAGS = -L$(LIBDIR) -lidmclib -Wl,-rpath,$(LIBDIR)
#LIB_LDFLAGS = $(LIBPATH_STATIC) $(SRCDIR)/blas/libblas.a -lgfortran \
	$(LIBDIR)/libidmclib.a
JAVA_CFLAGS = -I/opt/jdk1.5.0_08/include -I/opt/jdk1.5.0_08/include/linux
JAVA_LDFLAGS= $(LIB_LDFLAGS)
PYTHON_CFLAGS = -I/usr/include/python2.4
PYTHON_LDFLAGS= $(LIB_LDFLAGS)
TESTS_LDFLAGS= $(LIB_LDFLAGS)

MAKE=make
FC=gfortran
CC=gcc
LD=gcc
AR=ar
SWIG = swig

CFLAGS = -c -fPIC $(LUA_CFLAGS) $(GSL_CFLAGS) -I. -I$(INCLUDEDIR) --std=c99
SHFLAGS = -shared
ARCMD = cr
LDFLAGS =  $(LAPACK_LIBS) $(LUA_LIBS) $(GSL_LIBS)

SHLIB_EXT = .so
PLATFORM=linux_x86_64
LIBDIR=$(MAINDIR)/lib
SRCDIR=$(MAINDIR)/src
INCLUDEDIR=$(MAINDIR)/include
LIBPATH=$(LIBDIR)/libidmclib$(SHLIB_EXT)
LIBPATH_STATIC=$(SRCDIR)/lapack/liblapack.a
