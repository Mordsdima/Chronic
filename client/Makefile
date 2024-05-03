V ?= v
MAKE ?= make

libraylib.a: 
	cd raylib/src && $(MAKE) && cd ../.. 

build: libraylib.a
	$(V) -prod .

devbuild: libraylib.a
	$(V) .

rundev: libraylib.a
	$(V) run .

.PHONY: libraylib.a build devbuild rundev
