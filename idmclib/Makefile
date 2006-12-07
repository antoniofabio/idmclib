MAINDIR=$(CURDIR)

export MAINDIR

include Makefile.inc
include VERSION

all: idmclib tests jidmc pyidmc

idmclib:
	cd src; $(MAKE)

includes:
	cp src/*.h include/idmclib

tests: idmclib includes
	cd tests; $(MAKE)

run_tests: tests
	cd tests; $(MAKE) run_tests

jidmc: idmclib includes
	cd jidmc; $(MAKE)
	
pyidmc: idmclib includes
	cd pyidmc; $(MAKE)

dist-src: clean
	@mkdir idmclib
	@cp -r Makefile Makefile.inc Makefile.inc.win VERSION src tests jidmc pyidmc \
	$(LIBDIR) include doc idmclib
	tar czf idmclib_$(VERSION).tar.gz idmclib
	@rm -rf idmclib

dist: idmclib jidmc pyidmc
	@mkdir idmclib
	@cp -r Makefile Makefile.inc src tests jidmc pyidmc $(LIBDIR) include idmclib
	tar czf idmclib_$(VERSION)_$(PLATFORM).tar.gz idmclib
	@rm -rf idmclib

clean:
	rm -rf idmclib
	rm -f include/idmclib/*.h
	rm -f $(LIBDIR)/*
	rm -f *.tar.gz
	cd src && $(MAKE) clean
	cd tests && $(MAKE) clean
	cd jidmc && $(MAKE) clean
	cd pyidmc && $(MAKE) clean
