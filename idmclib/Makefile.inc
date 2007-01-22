#LUA-5.0 compiling and linking flags:
LUA_CFLAGS = -I$(MAINDIR)/../lua-5.0.2/include
LUA_LIBS = $(MAINDIR)/../lua-5.0.2/lib/liblua.a $(MAINDIR)/../lua-5.0.2/lib/liblualib.a

#GSL-1.8 compiling and linking flags:
GSL_CFLAGS = -I$(MAINDIR)/../gsl-1.8
GSL_LIBS = $(MAINDIR)/../gsl-1.8/.libs/libgsl.a $(MAINDIR)/../gsl-1.8/cblas/.libs/libgslcblas.a -lm

#LAPACK/BLAS linking flags:
#	dynamic linking to system version:
LAPACK_LIBS = -lblas -llapack -lg2c
#	static linking to idmclib subset:
#LAPACK_LIBS = $(SRCDIR)/lapack/liblapack.a $(SRCDIR)/blas/libblas.a -lgfortran

#Flags for linking shared libraries to idmclib
#	dynamically:
#LIB_LDFLAGS = -L$(LIBDIR) -lidmclib -Wl,-rpath,$(LIBDIR)
#	statically:
LIB_LDFLAGS = $(LIBDIR)/libidmclib.a $(LAPACK_LIBS)

#Compiling and linking flags for Java/JNI interface
JAVA_CFLAGS = -I/opt/jdk1.5.0_08/include -I/opt/jdk1.5.0_08/include/linux
JAVA_LDFLAGS= $(LIB_LDFLAGS) $(LUA_LIBS) $(GSL_LIBS)

#Compiling and linking flags for python-2.4 interface
PYTHON_CFLAGS = -I/usr/include/python2.4
PYTHON_LDFLAGS= $(LIB_LDFLAGS)

#Compiling and linking flags for R-2.4.x interface
R_CFLAGS= -I/usr/local/lib64/R/include -DRIDMC_DEBUG
R_LDFLAGS= $(LIB_LDFLAGS) $(LUA_LIBS) $(GSL_LIBS)

#Linking flags for unit testing code
TESTS_LDFLAGS= $(LIB_LDFLAGS) $(LUA_LIBS) $(GSL_LIBS)

#GNU make:
MAKE=make
#Fortran77 compiler:
FC=g77
#C99 compiler:
CC=gcc
#C/Fortran linker:
LD=gcc
#GNU ar:
AR=ar
#SWIG-1.3 (Simplified Wrapper and Interface Generator):
SWIG = swig

#targets to be built by default (in: idmclib tests jidmc pyidmc ridmc):
BUILD_TARGETS = idmclib tests jidmc pyidmc ridmc

CFLAGS = -c -g -fPIC $(LUA_CFLAGS) $(GSL_CFLAGS) -I. -I$(INCLUDEDIR) --std=c99
SHFLAGS = -shared
ARCMD = cr
LDFLAGS =  $(LAPACK_LIBS) $(LUA_LIBS) $(GSL_LIBS)

SHLIB_EXT = .so
PLATFORM=linux_x86_64
LIBDIR=$(MAINDIR)/lib
SRCDIR=$(MAINDIR)/src
INCLUDEDIR=$(MAINDIR)/include
LIBPATH=$(LIBDIR)/libidmclib$(SHLIB_EXT)
LIBPATH_STATIC=$(LIBDIR)/libidmclib.a
