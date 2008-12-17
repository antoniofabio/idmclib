SRC += tcl/tclidmclib_WRAP.c
TOCLEAN += tcl/tclidmclib.so

tcl/tclidmclib_WRAP.c: tcl/idmc.i
	$(SWIG) -tcl -o $@ $<

tcl/tclidmclib.o: tcl/tclidmclib_WRAP.c
	$(CC) -c $(CFLAGS) $(TCL_CFLAGS) -DUSE_TCL_STUBS -DUSE_TK_STUBS $< -o $@

tcl/tclidmclib.so: tcl/tclidmclib_WRAP.o src/libidmclib.a
	$(CC) -shared $^ $(TCL_LDFLAGS) $(LDFLAGS) -o $@

