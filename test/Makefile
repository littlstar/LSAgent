## libLSAgent dependency
LIB := ../libLSAgent.a

## Dependency source files
DEPSRC := $(shell ls ../deps/*/*.m)

## Dependency object files
DEPOBJS := $(DEPSRC:.m=.o)

## Test source files
SRC := $(wildcard *.m)

## Test source objects
OBJS := $(SRC:.m=.o)

## Test files
TESTS := $(SRC:.m=)

## Compiler flags
CFLAGS += -I../include
CFLAGS += -I../deps
CFLAGS += -Wall

## Linker flags
LDFLAGS += -lobjc -framework Cocoa

## Node executable
NODE := $(shell which node) --harmony

## NPM executable
NPM := $(shell which npm)

## Builds all tests
all: support $(TESTS) support/cleanup

## Builds a named test
$(TESTS): $(DEPOBJS)
$(TESTS): $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(LIB) $(DEPOBJS) $< -o $@
	./$@

## Builds test object files
$(OBJS): $(LIB)
$(OBJS): $(SRC)
	$(CC) $(CFLAGS) -c $(@:.o=.m) -o $@

## Builds dependency objects
$(DEPOBJS): $(DEPSRC)
	$(CC) $(CFLAGS) -c $(@:.o=.m) -o $@

## Ensure dependency library is built
$(LIB):
	$(MAKE) -C ..

## Clean up tests
clean: support/clean
	$(RM) -f $(OBJS)
	$(RM) -f $(TESTS)
	$(RM) -f $(DEPOBJS)

## Support test tasks
.PHONY: support
support: support/server

## Cleans files created for support tasks
.PHONY: support/clean
support/clean: support/cleanup
	$(RM) -rf support/server/node_modules

## Start test server
.PHONY: support/server
support/server:
	test -f $@/pid && kill -9 $(shell cat $@/pid); true;
	$(RM) -f $@/pid
	cd $@ && $(NPM) install
	$(NODE) $@ &
	sleep 1

## Cleanup support related tasks
.PHONY: support/cleanup
support/cleanup:
	@## Cleanup support server
	test -f support/server/pid && kill -9 $(shell cat support/server/pid); true;
	$(RM) -f support/server/pid

