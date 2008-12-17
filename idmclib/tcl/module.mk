SRC += tcl/tclidmclib_WRAP.c
TOCLEAN += tcl/tclidmclib.so

tcl/tclidmclib_WRAP.c: tcl/idmc.i
	$(SWIG) -tcl -o $@ $<

tcl/tclidmclib.o: tcl/tclidmclib_WRAP.c include/idmclib/version.h
	$(CC) -c $(CFLAGS) $(TCL_CFLAGS) -DUSE_TCL_STUBS -DUSE_TK_STUBS $< -o $@

tcl/tclidmclib.so: tcl/tclidmclib_WRAP.o src/libidmclib.a
	$(CC) -shared $^ $(LDFLAGS) $(TCL_LDFLAGS) -o $@

TCLTESTS:=attractor model setSeed
TCLTESTS_BIN:=$(TCLTESTS:%=tcl/test_%.tcl)

tcltests: $(TCLTESTS_BIN) tcl/tclidmclib.so
	@cd tcl; for i in $(TCLTESTS_BIN); do echo running $$i; ../$$i; done
