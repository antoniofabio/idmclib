TESTS:=model NumJac errors basin basin_slow cycles lexp raster
TESTS_NAMES:=$(TESTS:%=test_%)
TESTS_SRC:=$(TESTS_NAMES:%=tests/%.c)
TESTS_OBJ:=$(TESTS_NAMES:%=tests/%.o)
TESTS_BIN:=$(TESTS_NAMES:%=tests/%)

$(TESTS_BIN):%:%.o tests/test_common.c src/libidmclib.a
	$(CC) $(CFLAGS) $^ $(LDFLAGS) -o $@

test: $(TESTS_BIN)
	cd tests; for i in $(TESTS_BIN); do echo -n running $${i}...; ../$$i; done
