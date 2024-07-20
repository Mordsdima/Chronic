V ?= v
MAKE ?= make

libraylib.a: 
	cd raylib/src && $(MAKE) && cd ../.. 

build: 
	$(V) -prod .

devbuild: 
	$(V) .

rundev: 
	$(V) run .

.PHONY: libraylib.a build devbuild rundev
