## libagent dependency
LIB := ../libagent.a

## Test source files
SRC := $(wildcard *.m)

## Test source objects
OBJS := $(SRC:.m=.o)

## Test files
TESTS := $(SRC:.m=)

## Compiler flags
CFLAGS += -I../include

## Linker flags
LDFLAGS += -lobjc -framework Cocoa

## Builds all tests
all: $(TESTS)

## Builds a named test
$(TESTS): $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(LIB) $< -o $@
	./$@

## Builds test object files
$(OBJS): $(LIB)
$(OBJS): $(SRC)
	$(CC) $(CFLAGS) -c $< -o $@

## Ensure dependency library is built
$(LIB):
	$(MAKE) -C ..

clean:
	$(RM) -f $(OBJS)
	$(RM) -f $(TESTS)

