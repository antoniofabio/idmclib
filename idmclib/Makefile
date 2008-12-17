include Makefile.config

CFLAGS+= -I./include -I./include/idmclib $(LUA_CFLAGS) $(GSL_CFLAGS)
LDFLAGS+=$(LUA_LDFLAGS) $(GSL_LDFLAGS)
TCL_LDFLAGS+=-ltclstub

LIB_VER_MAJOR:=0
LIB_VER_MINOR:=10
LIB_VER_MICRO:=1

MODULES:=src doc java tcl tests
SRC:=
TOCLEAN:=idmclib.pc
GENERATED_FILES:=tcl/tclidmclib_WRAP.c java/idmclib_WRAP.c include/idmclib/version.h

.PHONY : all java tcl lib test clean distrib clean-all doc

all: lib
lib: src/libidmclib.a
java: java/jidmclib.so
tcl: tcl/tclidmclib.so

LIBNAME:=idmclib-$(LIB_VER_MAJOR).$(LIB_VER_MINOR).$(LIB_VER_MICRO)
distrib: clean-all $(GENERATED_FILES) doc
	@mkdir -p .distrib/$(LIBNAME)
	@cp -r * .distrib/$(LIBNAME)
	@cd .distrib; tar cjf ../$(LIBNAME).tar.bz2 $(LIBNAME)
	@rm -rf .distrib

clean:
	@rm -rf *~ $(SRC:%.c=%.o) $(SRC:%=%~) $(TOCLEAN)
clean-all: clean
	@rm -f $(GENERATED_FILES)

export
% :: %.in
	@cat $< | while read line; do eval "echo $$line"; done > $@
	@echo generated $@ from $<

include $(MODULES:%=%/module.mk)

test: ctests jtests

install: lib $(GENERATED_FILES) idmclib.pc
	install -d $(PREFIX)/lib
	install -m a-x+rw -D src/libidmclib.a -t $(PREFIX)/lib
	install -d $(PREFIX)/include/idmclib
	install -m a-x+rw -D include/idmclib/* -t $(PREFIX)/include/idmclib
	install -d $(PREFIX)/lib/pkgconfig
	install -m a-x+rw -D idmclib.pc -t $(PREFIX)/lib/pkgconfig
