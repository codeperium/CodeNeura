# TODO: Shared library compilation not working for some reason
CC = clang
CFLAGS = -Iinclude
LDFLAGS = -shared
DEPS = $(wildcard include/*.h)
LIBS = -L./lib

SRC = $(wildcard src/*.c)
LIB_SRC = $(filter-out src/test.c, $(SRC))
OBJ = $(LIB_SRC: .c=.o)
STATIC_TARGET = lib/libcodeneura.a
SHARED_TARGET = lib/libcodeneura.so
TEST_SRC = src/test.c
TEST_OBJ = $(TEST_SRC: .c=.o)

test: $(TEST_OBJ)
	$(CC) $(CFLAGS) $(LIBS) -o bin/test -lcodeneura $^

static: $(OBJ)
	$(CC) $(CFLAGS) -Wall -Wextra -o $(STATIC_TARGET) $^

shared: CFLAGS += -fPIC
shared: $(OBJ)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $(SHARED_TARGET) $^ $(LIBS)

compile_test: shared test

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

clean:
	rm -f src/*.o *~ core $(INCDIR)/*~ $(SHARED_TARGET) $(STATIC_TARGET)
