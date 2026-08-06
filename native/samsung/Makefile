CC      = gcc
CFLAGS  = -Wall -O2 $(shell pkg-config --cflags libusb-1.0)
LDLIBS  = $(shell pkg-config --libs libusb-1.0)
TARGET  = samsung_write

all: $(TARGET)

$(TARGET): samsung_write.c
	$(CC) $(CFLAGS) -o $(TARGET) samsung_write.c $(LDLIBS)

clean:
	rm -f $(TARGET)

.PHONY: all clean
