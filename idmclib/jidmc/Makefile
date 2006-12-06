include ../Makefile.inc

MODULES = idmc

SWIG_SRC = $(addsuffix .i, $(MODULES))
SWIG_OPTS = -java -package org.tsho.jidmclib -outdir org/tsho/jidmclib

C_SRCS = $(addsuffix _wrap.c, $(MODULES))
CFLAGS += $(JAVA_CFLAGS)
LDFLAGS := $(JAVA_LDFLAGS)

T = $(addsuffix $(SHLIB_EXT), $(MODULES))

all: $(T)

$(C_SRCS): %_wrap.c: %.i idmc_model.i idmc_traj.i idmc_cycles.i idmc_lexp.i
	$(SWIG) $(SWIG_OPTS) $<

$(T): %$(SHLIB_EXT): %_wrap.o $(LIBPATH) $(LIBPATH_STATIC)
	$(LD) $(SHFLAGS) $< $(LDFLAGS) -o $@

clean:	
	rm -f *o *.d *wrap.c *.class org/tsho/jidmclib/*

%.d: %.c
	$(CC) -MM $(CPPFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$

include $(C_SRCS:.c=.d)
