# TODO: Shared library compilation not working for some reason
CC = clang
CFLAGS = -Iinclude -Ilib
LDFLAGS = -shared
DEPS = $(wildcard include/*.h)
LIBS = -L.

SRC = $(wildcard src/*.c)
OBJ = $(SRC: .c=.o)
STATIC_TARGET = bin/CodeNeura
SHARED_TARGET = bin/CodeNeura.so

$(STATIC_TARGET): $(OBJ)
	$(CC) $(SRC) $(CFLAGS) -Wall -Wextra -o $(STATIC_TARGET)

$(DYNAMIC_TARGET): CFLAGS += -fPIC
$(DYNAMIC_TARGET): $(OBJ)
	$(CC) $(SRC) $(LDFLAGS) -o $@ $^ $(LIBS)

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

clean:
	rm -f src/*.o *~ core $(INCDIR)/*~ $(SHARED_TARGET) 
