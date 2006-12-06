include ../Makefile.inc

LDFLAGS := $(TESTS_LDFLAGS)

TESTS = model traj cycles lexp
C_SRCS = $(addsuffix .c, $(addprefix test_,$(TESTS))) test_common.c
OBJS = $(C_SRCS:.c=.o)
BINARIES = $(addprefix test_,$(TESTS))

all: $(BINARIES)

$(BINARIES):test_%:test_%.o test_common.o
	$(LD) $< test_common.o $(LDFLAGS) -o $@

run_tests: $(BINARIES)
	@for b in $(BINARIES); do echo $$b; ./$$b; done

clean:
	rm -f *o *.d $(BINARIES)

%.d: %.c
	$(CC) -MM $(CPPFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$

include $(C_SRCS:.c=.d)
