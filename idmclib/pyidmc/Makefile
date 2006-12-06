include ../Makefile.inc

MODULES = idmc
SUBMODULES = $(addsuffix .i, $(addprefix idmc_, model traj lexp cycles) )

SWIG_SRC = $(addsuffix .i, $(MODULES))
SWIG_OPTS = -python

C_SRCS = $(addsuffix _wrap.c, $(MODULES))
CFLAGS += $(PYTHON_CFLAGS)
LDFLAGS += $(PYTHON_LDFLAGS)

T = $(addprefix _, $(addsuffix .so, $(MODULES)) )

all: $(T)

idmc_wrap.c: idmc.i $(SUBMODULES)
	$(SWIG) $(SWIG_OPTS) $<

$(T): _%.so: %_wrap.o $(LIBDIR)/libidmclib.so
	$(LD) $(SHFLAGS) $(LDFLAGS) $< -o $@

clean:
	rm -f *o *.d *wrap.c *.pyc $(addsuffix .py, $(MODULES))

%.d: %.c
	$(CC) -MM $(CPPFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$

include $(C_SRCS:.c=.d)
