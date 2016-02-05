CC=gcc
CFLAGS=-Wall -std=gnu11 -I.
LDFLAGS=-static -L. -lfftw3f -lm -lgsl
EXECUTABLES= x2kc2c t2wr2c mxyz2muvw avg
RFLAGS=-O3 -march=sandybridge
DFLAGS=-g -O0 -march=sandybridge

all: release

release:
	$(foreach 	EXECUTABLE,$(EXECUTABLES),$(CC) $(CFLAGS) $(RFLAGS) $(EXECUTABLE).c core/*.c -o $(EXECUTABLE) $(LDFLAGS) &&) true

valgrind:
	$(foreach 	EXECUTABLE,$(EXECUTABLES),$(CC) $(CFLAGS) $(DFLAGS) $(EXECUTABLE).c core/*.c -o $(EXECUTABLE) $(LDFLAGS) &&) true

sanitizer:
	$(foreach 	EXECUTABLE,$(EXECUTABLES),$(CC) $(CFLAGS) $(DFLAGS) -fsanitize=address -fno-omit-frame-pointer $(EXECUTABLE).c core/*.c -o $(EXECUTABLE) $(LDFLAGS) &&) true

clean:
	$(foreach EXECUTABLE,$(EXECUTABLES),rm -rf $(EXECUTABLE) &&) true

.PHONY: all clean
