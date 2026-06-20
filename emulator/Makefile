CC = gcc
CFLAGS = -O2 -Wall -I/usr/include/z80ex
LIBS = -lz80ex
TARGET = dgt100_emu

$(TARGET): dgt100_emu.c
	$(CC) $(CFLAGS) -o $(TARGET) dgt100_emu.c $(LIBS)

clean:
	rm -f $(TARGET)

install-deps:
	sudo apt-get install -y libz80ex-dev

.PHONY: clean install-deps
