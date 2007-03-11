EXTRA_DIST = inflation.lua  lorenz.lua  test2.lua  test.lua \
	logistic.lua   OL3G.lua    testError2.lua \
	ridmcTest.R ridmc.R \
	basin.c  cycles.c  lexp.c  model.c  ridmc.c  traj.c ridmc.h

COMPILE = $(CC) -c $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) \
        $(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS) -I../src -I$(R_HOME)/include

all: ridmcShlib

.c.o:
	$(COMPILE) $< -o $@

ridmcShlib: basin.o  cycles.o  lexp.o  model.o  ridmc.o traj.o
	R CMD SHLIB ridmc.o basin.o cycles.o lexp.o model.o  \
	traj.o ../src/.libs/libidmclib.a \
	../src/idmclapack/.libs/libidmclapack.a \
	../src/idmcblas/.libs/libidmcblas.a $(LIBS) $(FLIBS)

clean:
	rm -f *.o *.so *.dll
