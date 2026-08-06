CC      = gcc
CFLAGS  = -Wall -O2 $(shell pkg-config --cflags libusb-1.0)
LDLIBS  = $(shell pkg-config --libs libusb-1.0)
TARGET  = ax206_write

all: $(TARGET)

$(TARGET): ax206_write.c
	$(CC) $(CFLAGS) -o $(TARGET) ax206_write.c $(LDLIBS)

clean:
	rm -f $(TARGET)

.PHONY: all clean
