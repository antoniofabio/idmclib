include ../Makefile.inc

MODULES = model traj lexp lexp_aux matrices cycles gsl_rng_lualib
SRCS= $(addsuffix .c, $(MODULES))
OBJS = $(SRCS:.c=.o)

all: idmclib

idmclib: $(LIBPATH) $(LIBDIR)/libidmclib.a

$(LIBPATH): idmclib$(SHLIB_EXT)
	cp $< $@

$(LIBDIR)/libidmclib.a: idmclib.a
	cp $< $@

idmclib$(SHLIB_EXT): $(OBJS) blaslib lapacklib
	$(LD) $(SHFLAGS) $(OBJS) $(LDFLAGS) -o $@
	
idmclib.a: $(OBJS) blaslib lapacklib
	$(AR) $(ARCMD) $@ $(OBJS)
	
blaslib:
	cd blas && $(MAKE)

lapacklib:
	cd lapack && $(MAKE)

clean:
	rm -f *o *.d idmclib.a lapack/liblapack.a
	cd blas && $(MAKE) clean
	cd lapack && $(MAKE) clean

%.d: %.c
	$(CC) -MM $(CPPFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$

include $(SRCS:.c=.d)
