include ../Makefile.inc

CFLAGS += $(PYTHON_CFLAGS)
LDFLAGS := $(PYTHON_LDFLAGS)

SRCS = idmc_wrap
C_SRCS = $(addsuffix .c, $(SRCS) )
C_OBJS = $(addsuffix .o, $(SRCS) )

SHNAME = _idmc$(SHLIB_EXT)

SWIG_SRC = idmc.i
SWIG_OPTS = -python

all: $(SHNAME)

$(C_SRCS): %_wrap.c: %.i idmc_model.i idmc_traj.i idmc_cycles.i idmc_lexp.i idmc_raster.i idmc_basin.i
	$(SWIG) $(SWIG_OPTS) $<

$(SHNAME): $(C_OBJS) $(LIBDIR)/libidmclib.so
	$(LD) $(SHFLAGS) $(LDFLAGS) $(C_OBJS) -o $@

clean:
	rm -f *.o *$(SHLIB_EXT) *.d *wrap.c *.pyc idmc.py

%.d: %.c
	$(CC) -MM $(CPPFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$

include $(C_SRCS:.c=.d)
