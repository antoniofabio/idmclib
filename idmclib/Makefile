MAINDIR=$(CURDIR)

export MAINDIR

include Makefile.inc
include VERSION

all: idmclib tests jidmc pyidmc ridmc

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

ridmc: idmclib includes
	cd ridmc; $(MAKE)

dist-src: clean
	@mkdir idmclib-$(VERSION)
	@cp -r Makefile Makefile.inc Makefile.inc.win VERSION src tests jidmc pyidmc ridmc \
	$(LIBDIR) include doc idmclib-$(VERSION)
	tar czf idmclib_$(VERSION).tar.gz idmclib-$(VERSION)
	@rm -rf idmclib-$(VERSION)

dist: idmclib jidmc pyidmc ridmc
	@mkdir idmclib-$(VERSION)
	@cp -r Makefile Makefile.inc src tests jidmc pyidmc ridmc $(LIBDIR) include idmclib-$(VERSION)
	tar czf idmclib_$(VERSION)_$(PLATFORM).tar.gz idmclib-$(VERSION)
	@rm -rf idmclib-$(VERSION)

clean:
	rm -rf idmclib
	rm -f include/idmclib/*.h
	rm -f $(LIBDIR)/*
	rm -f *.tar.gz
	cd src && $(MAKE) clean
	cd tests && $(MAKE) clean
	cd jidmc && $(MAKE) clean
	cd pyidmc && $(MAKE) clean
	cd ridmc && $(MAKE) clean
