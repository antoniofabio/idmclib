include ../Makefile.inc

CFLAGS += $(R_CFLAGS)
LDFLAGS := $(R_LDFLAGS)

SRCS = ridmc model traj lexp cycles basin
C_SRCS = $(addsuffix .c, $(SRCS) )
C_OBJS = $(addsuffix .o, $(SRCS) )

SHNAME = ridmc$(SHLIB_EXT)

all: $(SHNAME)

$(SHNAME): $(C_OBJS)
	$(LD) $(SHFLAGS) $(C_OBJS) $(LDFLAGS) -o $@

clean:
	@rm -f *.o *$(SHNAME) *.d

%.d: %.c
	$(CC) -MM $(CPPFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$

include $(C_SRCS:.c=.d)
