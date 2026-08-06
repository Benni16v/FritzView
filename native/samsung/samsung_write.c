/*
 * samsung_write.c
 *
 * Sendet ein JPEG-Bild direkt per USB an einen Samsung SPF-
 * Bilderrahmen - ganz ohne lcd4linux.
 *
 * Protokoll-Grundlage: Photoframe.py aus Joergs lcd4linux-Plugin
 * (Enigma2), hier neu implementiert mit libusb-1.0.
 *
 * Eingabe: eine fertige JPEG-Datei, in der Aufloesung des
 * jeweiligen Rahmens (siehe known_devices unten).
 *
 * Aufruf: ./samsung_write bild.jpg
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <libusb-1.0/libusb.h>

#define ENDPOINT_OUT 0x02
#define TIMEOUT_MS 5000

typedef struct {
    const char *name;
    uint16_t vid_mon;
    uint16_t pid_mon;   /* Mini-Monitor-Modus (Zielmodus) */
    uint16_t vid_ms;
    uint16_t pid_ms;    /* Massenspeicher-Modus (Ausgangsmodus) */
    int width;
    int height;
} known_device_t;

/* Aus Photoframe.py uebernommen (get_known_devices) */
static known_device_t known_devices[] = {
    { "Samsung SPF-75H/76H", 0x04e8, 0x200f, 0x04e8, 0x200e, 800, 480 },
    { "Samsung SPF-87H",     0x04e8, 0x2034, 0x04e8, 0x2033, 800, 480 },
    { "Samsung SPF-87H alt", 0x04e8, 0x2026, 0x04e8, 0x2025, 800, 480 },
    { "Samsung SPF-83H",     0x04e8, 0x200d, 0x04e8, 0x200c, 800, 600 },
    { "Samsung SPF-107H",    0x04e8, 0x2036, 0x04e8, 0x2035, 1024, 600 },
    { "Samsung SPF-105P",    0x04e8, 0x201b, 0x04e8, 0x201c, 1024, 600 },
    { "Samsung SPF-85H/86H", 0x04e8, 0x2013, 0x04e8, 0x2012, 800, 600 },
    { "Samsung SPF-72H",     0x04e8, 0x200b, 0x04e8, 0x200a, 800, 480 },
    { "Samsung SPF-700T",    0x04e8, 0x2050, 0x04e8, 0x204f, 800, 600 },
    { "Samsung SPF-85P/86P", 0x04e8, 0x2017, 0x04e8, 0x2016, 800, 600 },
    { "Samsung SPF-107H alt",0x04e8, 0x2028, 0x04e8, 0x2027, 1024, 600 },
    { "Samsung SPF-1000P",   0x04e8, 0x2040, 0x04e8, 0x2039, 1024, 600 },
    { "Samsung SPF-800P",    0x04e8, 0x2038, 0x04e8, 0x2037, 800, 480 },
};
#define NUM_KNOWN_DEVICES (sizeof(known_devices) / sizeof(known_devices[0]))

static libusb_device_handle *open_by_id(uint16_t vid, uint16_t pid)
{
    return libusb_open_device_with_vid_pid(NULL, vid, pid);
}

/* Schaltet ein Geraet von Massenspeicher- in Mini-Monitor-Modus */
static void frame_switch(libusb_device_handle *dev)
{
    unsigned char buf[254];
    libusb_control_transfer(dev, 0x80, 0x06, 0xfe, 0xfe, buf, 0xfe, TIMEOUT_MS);
    sleep(2);
}

/* Haelt das Geraet im Mini-Monitor-Modus (muss regelmaessig/initial
 * aufgerufen werden) */
static void frame_init(libusb_device_handle *dev)
{
    unsigned char buf[2];
    libusb_control_transfer(dev, 0xc0, 0x01, 0x00, 0x00, buf, 2, TIMEOUT_MS);
}

static libusb_device_handle *find_and_init(known_device_t *found_dev)
{
    libusb_device_handle *dev;
    unsigned int i;

    for (i = 0; i < NUM_KNOWN_DEVICES; i++) {
        dev = open_by_id(known_devices[i].vid_mon, known_devices[i].pid_mon);
        if (dev) {
            fprintf(stderr, "Gefunden (bereits im Mini-Monitor-Modus): %s (%dx%d)\n",
                    known_devices[i].name, known_devices[i].width, known_devices[i].height);
            *found_dev = known_devices[i];
            frame_init(dev);
            return dev;
        }
    }

    for (i = 0; i < NUM_KNOWN_DEVICES; i++) {
        dev = open_by_id(known_devices[i].vid_ms, known_devices[i].pid_ms);
        if (dev) {
            fprintf(stderr, "Gefunden im Massenspeicher-Modus: %s - schalte um...\n",
                    known_devices[i].name);
            frame_switch(dev);
            libusb_close(dev);

            dev = open_by_id(known_devices[i].vid_mon, known_devices[i].pid_mon);
            if (dev) {
                fprintf(stderr, "Umschalten erfolgreich: %s (%dx%d)\n",
                        known_devices[i].name, known_devices[i].width, known_devices[i].height);
                *found_dev = known_devices[i];
                frame_init(dev);
                return dev;
            }
            fprintf(stderr, "Umschalten fehlgeschlagen.\n");
            return NULL;
        }
    }

    return NULL;
}

static unsigned char *read_file(const char *path, long *out_size)
{
    FILE *fp;
    unsigned char *data;
    long size;

    fp = fopen(path, "rb");
    if (!fp) {
        fprintf(stderr, "Kann Datei nicht oeffnen: %s\n", path);
        return NULL;
    }
    fseek(fp, 0, SEEK_END);
    size = ftell(fp);
    fseek(fp, 0, SEEK_SET);

    data = malloc(size);
    if (!data) {
        fclose(fp);
        return NULL;
    }
    if (fread(data, 1, size, fp) != (size_t)size) {
        fprintf(stderr, "Datei ist unvollstaendig: %s\n", path);
        free(data);
        fclose(fp);
        return NULL;
    }
    fclose(fp);
    *out_size = size;
    return data;
}

int main(int argc, char *argv[])
{
    libusb_device_handle *dev;
    known_device_t found_dev;
    unsigned char *jpeg;
    long jpeg_size;
    unsigned char *tdata;
    long raw_size, pad, total_size;
    int transferred, ret;

    if (argc < 2) {
        fprintf(stderr, "Aufruf: %s bild.jpg\n", argv[0]);
        return 1;
    }

    jpeg = read_file(argv[1], &jpeg_size);
    if (!jpeg) return 1;

    if (libusb_init(NULL) != 0) {
        fprintf(stderr, "libusb_init fehlgeschlagen\n");
        free(jpeg);
        return 1;
    }

    dev = find_and_init(&found_dev);
    if (!dev) {
        fprintf(stderr, "Kein bekannter Samsung-Bilderrahmen gefunden.\n");
        libusb_exit(NULL);
        free(jpeg);
        return 1;
    }

    if (libusb_kernel_driver_active(dev, 0) == 1) {
        libusb_set_auto_detach_kernel_driver(dev, 1);
    }
    ret = libusb_claim_interface(dev, 0);
    if (ret != 0) {
        fprintf(stderr, "Konnte USB-Interface nicht belegen: %s\n", libusb_error_name(ret));
        libusb_close(dev);
        libusb_exit(NULL);
        free(jpeg);
        return 1;
    }

    /* Header: a5 5a 18 04 <4 byte Laenge LE, = jpeg_size+14> 48 00 00 00 <jpeg> */
    raw_size = 12 + jpeg_size;
    pad = (0x10000 - ((raw_size + 2) % 0x10000)) % 0x10000;
    total_size = raw_size + 2 + pad;

    tdata = malloc(total_size);
    if (!tdata) {
        fprintf(stderr, "Kein Speicher\n");
        goto fail;
    }

    {
        unsigned char *p = tdata;
        uint32_t len_field = (uint32_t)(jpeg_size + 14);
        *p++ = 0xa5; *p++ = 0x5a; *p++ = 0x18; *p++ = 0x04;
        *p++ = (unsigned char)(len_field);
        *p++ = (unsigned char)(len_field >> 8);
        *p++ = (unsigned char)(len_field >> 16);
        *p++ = (unsigned char)(len_field >> 24);
        *p++ = 0x48; *p++ = 0x00; *p++ = 0x00; *p++ = 0x00;
        memcpy(p, jpeg, jpeg_size);
        p += jpeg_size;
        *p++ = 0xff; *p++ = 0x00;
        memset(p, 0x00, pad);
    }

    ret = libusb_bulk_transfer(dev, ENDPOINT_OUT, tdata, (int)total_size, &transferred, TIMEOUT_MS);
    if (ret != 0) {
        fprintf(stderr, "Fehler beim Senden: %s\n", libusb_error_name(ret));
        free(tdata);
        goto fail;
    }

    fprintf(stderr, "Bild gesendet (%d Bytes).\n", transferred);

    free(tdata);
    free(jpeg);
    libusb_release_interface(dev, 0);
    libusb_close(dev);
    libusb_exit(NULL);
    return 0;

fail:
    free(jpeg);
    libusb_release_interface(dev, 0);
    libusb_close(dev);
    libusb_exit(NULL);
    return 1;
}
