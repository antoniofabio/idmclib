TOCLEAN+=java/jidmclib.so java/idmclib_WRAP.o

java/idmclib_WRAP.c: java/idmc.i
	$(SWIG) -java -package org.tsho.jidmclib -outdir java/org/tsho/jidmclib -o $@ $<

java/idmclib_WRAP.o: java/idmclib_WRAP.c include/idmclib/version.h
	$(CC) -c $(JNI_CFLAGS) $(CFLAGS) $< -o $@

java/jidmclib.so: java/idmclib_WRAP.o src/libidmclib.a
	$(CC) -shared $(JNI_LDFLAGS) $^ $(LDFLAGS) -o $@

JTESTS:=attractor
JTESTS_BIN:=$(JTESTS:%=java/%.class)
TOCLEAN+=$(JTESTS_BIN)
$(JTESTS_BIN):%.class:%.java java/jidmclib.so
	javac -cp java -sourcepath java -d java $<

jtests: $(JTESTS_BIN)
	@cd java; for i in $(JTESTS); do echo running $$i java test; java $$i; done
