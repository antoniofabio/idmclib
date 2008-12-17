TOCLEAN += java/jidmclib.so

java/idmclib_WRAP.c: java/idmc.i
	$(SWIG) -java -package org.tsho.jidmclib -outdir java/org/tsho/jidmclib -o $@ $<

java/idmclib_WRAP.o: java/idmclib_WRAP.c
	$(CC) -c $(JNI_CFLAGS) $(CFLAGS) $< -o $@

java/jidmclib.so: java/idmclib_WRAP.o src/libidmclib.a
	$(CC) -shared $(JNI_LDFLAGS) $^ $(LDFLAGS) -o $@
