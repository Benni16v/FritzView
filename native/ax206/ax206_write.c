/*
 * ax206_write.c
 *
 * Sendet ein Bild direkt per USB an ein Pearl AX206 Display (bzw. baugleiche
 * "Hacked" Digital Photo Frames) - ganz ohne lcd4linux.
 *
 * Protokoll-Grundlage: drv_dpf.c aus dem lcd4linux/dpf-ax Projekt
 * (http://dpf-ax.sourceforge.net/), hier neu implementiert mit libusb-1.0.
 *
 * Eingabe: eine PPM-Bilddatei (Format P6, binaer, RGB888), exakt in der
 * Aufloesung des Displays (Pearl: 320x240).
 *
 * Aufruf: ./ax206_write bild.ppm [backlight 0-7]
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libusb-1.0/libusb.h>

#define AX206_VID 0x1908
#define AX206_PID 0x0102

#define USBCMD_SETPROPERTY 0x01
#define USBCMD_BLIT        0x12

#define ENDPT_OUT 0x01
#define ENDPT_IN  0x81

#define TIMEOUT_MS 5000

static libusb_device_handle *dev = NULL;

/* Sendet einen Befehl per USB-Mass-Storage-Protokoll (Bulk-Only Transport)
 * und liest die Bestaetigung (CSW) zurueck.
 * direction_in = 1: es soll eine Antwort vom Geraet gelesen werden (io_data)
 * direction_in = 0: es sollen Daten zum Geraet gesendet werden (io_data), falls vorhanden
 */
static int wrap_scsi(unsigned char *cmd, int cmdlen, int direction_in,
                      unsigned char *io_data, unsigned long block_len)
{
    unsigned char cbw[31] = {
        0x55, 0x53, 0x42, 0x43,             /* dCBWSignature "USBC" */
        0xde, 0xad, 0xbe, 0xef,             /* dCBWTag */
        0x00, 0x00, 0x00, 0x00,             /* dCBWDataTransferLength */
        0x00,                               /* bmCBWFlags */
        0x00,                               /* bCBWLUN */
        0x10,                               /* bCBWCBLength (immer 16) */
        0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
        0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
    };
    int transferred;
    int ret;
    unsigned char csw[13];
    int retry;

    if (cmdlen > 16) {
        fprintf(stderr, "wrap_scsi: Kommando zu lang\n");
        return -1;
    }
    memcpy(&cbw[15], cmd, cmdlen);

    cbw[8]  = (unsigned char)(block_len);
    cbw[9]  = (unsigned char)(block_len >> 8);
    cbw[10] = (unsigned char)(block_len >> 16);
    cbw[11] = (unsigned char)(block_len >> 24);

    ret = libusb_bulk_transfer(dev, ENDPT_OUT, cbw, sizeof(cbw), &transferred, TIMEOUT_MS);
    if (ret != 0) {
        fprintf(stderr, "wrap_scsi: Fehler beim Senden des Kommandos (%s)\n", libusb_error_name(ret));
        return -1;
    }

    if (io_data && block_len > 0) {
        if (direction_in) {
            ret = libusb_bulk_transfer(dev, ENDPT_IN, io_data, (int)block_len, &transferred, TIMEOUT_MS);
        } else {
            ret = libusb_bulk_transfer(dev, ENDPT_OUT, io_data, (int)block_len, &transferred, TIMEOUT_MS);
        }
        if (ret != 0 || (unsigned long)transferred != block_len) {
            fprintf(stderr, "wrap_scsi: Fehler bei Datenuebertragung (%s)\n", libusb_error_name(ret));
            return -1;
        }
    }

    retry = 0;
    do {
        ret = libusb_bulk_transfer(dev, ENDPT_IN, csw, sizeof(csw), &transferred, TIMEOUT_MS);
        retry++;
    } while (ret != 0 && retry < 5);

    if (ret != 0 || transferred != sizeof(csw)) {
        fprintf(stderr, "wrap_scsi: Fehler beim Lesen der Bestaetigung (%s)\n", libusb_error_name(ret));
        return -1;
    }
    if (memcmp(csw, "USBS", 4) != 0) {
        fprintf(stderr, "wrap_scsi: ungueltige Antwort vom Geraet\n");
        return -1;
    }

    return csw[12]; /* 0 = OK */
}

static int ax206_get_dimensions(int *width, int *height)
{
    unsigned char cmd[16] = {0xcd,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0};
    unsigned char buf[5];

    if (wrap_scsi(cmd, sizeof(cmd), 1, buf, sizeof(buf)) != 0) {
        return -1;
    }
    *width  = buf[0] | (buf[1] << 8);
    *height = buf[2] | (buf[3] << 8);
    return 0;
}

static int ax206_blit(const unsigned char *rgb565, int x0, int y0, int x1, int y1)
{
    unsigned char cmd[16] = {0xcd,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0};
    unsigned long len = (unsigned long)(x1 - x0) * (unsigned long)(y1 - y0) * 2;

    cmd[6]  = USBCMD_BLIT;
    cmd[7]  = (unsigned char)(x0);
    cmd[8]  = (unsigned char)(x0 >> 8);
    cmd[9]  = (unsigned char)(y0);
    cmd[10] = (unsigned char)(y0 >> 8);
    cmd[11] = (unsigned char)(x1 - 1);
    cmd[12] = (unsigned char)((x1 - 1) >> 8);
    cmd[13] = (unsigned char)(y1 - 1);
    cmd[14] = (unsigned char)((y1 - 1) >> 8);
    cmd[15] = 0;

    return wrap_scsi(cmd, sizeof(cmd), 0, (unsigned char *)rgb565, len);
}

static int ax206_set_backlight(int value)
{
    unsigned char cmd[16] = {0xcd,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0};
    if (value < 0) value = 0;
    if (value > 7) value = 7;
    cmd[6] = USBCMD_SETPROPERTY;
    cmd[7] = 0x01;
    cmd[8] = 0x00;
    cmd[9] = (unsigned char)value;
    cmd[10] = 0;
    return wrap_scsi(cmd, sizeof(cmd), 0, NULL, 0);
}

/* Liest eine PPM-Datei (Format P6, binaer, RGB888) ein. */
static unsigned char *read_ppm(const char *path, int *out_width, int *out_height)
{
    FILE *fp;
    char magic[3];
    int width, height, maxval;
    unsigned char *data;
    size_t size;
    int c;

    fp = fopen(path, "rb");
    if (!fp) {
        fprintf(stderr, "Kann Datei nicht oeffnen: %s\n", path);
        return NULL;
    }

    if (fscanf(fp, "%2s", magic) != 1 || strcmp(magic, "P6") != 0) {
        fprintf(stderr, "Keine gueltige PPM-Datei (P6 erwartet): %s\n", path);
        fclose(fp);
        return NULL;
    }

    c = fgetc(fp);
    while (1) {
        while (c == ' ' || c == '\t' || c == '\n' || c == '\r') c = fgetc(fp);
        if (c == '#') {
            while (c != '\n' && c != EOF) c = fgetc(fp);
        } else {
            break;
        }
    }
    ungetc(c, fp);

    if (fscanf(fp, "%d %d %d", &width, &height, &maxval) != 3) {
        fprintf(stderr, "Konnte PPM-Header nicht lesen: %s\n", path);
        fclose(fp);
        return NULL;
    }
    fgetc(fp); /* einzelnes Whitespace-Zeichen nach dem Header */

    if (maxval != 255) {
        fprintf(stderr, "Nur PPM mit maxval=255 wird unterstuetzt (ist: %d)\n", maxval);
        fclose(fp);
        return NULL;
    }

    size = (size_t)width * (size_t)height * 3;
    data = malloc(size);
    if (!data) {
        fprintf(stderr, "Kein Speicher\n");
        fclose(fp);
        return NULL;
    }

    if (fread(data, 1, size, fp) != size) {
        fprintf(stderr, "PPM-Datei ist unvollstaendig: %s\n", path);
        free(data);
        fclose(fp);
        return NULL;
    }

    fclose(fp);
    *out_width = width;
    *out_height = height;
    return data;
}

int main(int argc, char *argv[])
{
    int ret;
    int img_width, img_height;
    unsigned char *rgb888;
    unsigned char *rgb565;
    int dev_width, dev_height;
    size_t pixel_count;
    size_t i;
    int backlight = -1;

    if (argc < 2) {
        fprintf(stderr, "Aufruf: %s bild.ppm [backlight 0-7]\n", argv[0]);
        return 1;
    }
    if (argc >= 3) {
        backlight = atoi(argv[2]);
    }

    rgb888 = read_ppm(argv[1], &img_width, &img_height);
    if (!rgb888) {
        return 1;
    }

    ret = libusb_init(NULL);
    if (ret != 0) {
        fprintf(stderr, "libusb_init fehlgeschlagen: %s\n", libusb_error_name(ret));
        free(rgb888);
        return 1;
    }

    dev = libusb_open_device_with_vid_pid(NULL, AX206_VID, AX206_PID);
    if (!dev) {
        fprintf(stderr, "Pearl-Display (USB %04x:%04x) nicht gefunden.\n", AX206_VID, AX206_PID);
        libusb_exit(NULL);
        free(rgb888);
        return 1;
    }

    libusb_set_auto_detach_kernel_driver(dev, 1);

    ret = libusb_claim_interface(dev, 0);
    if (ret != 0) {
        fprintf(stderr, "Konnte USB-Interface nicht belegen: %s\n", libusb_error_name(ret));
        libusb_close(dev);
        libusb_exit(NULL);
        free(rgb888);
        return 1;
    }

    if (ax206_get_dimensions(&dev_width, &dev_height) != 0) {
        fprintf(stderr, "Konnte Display-Aufloesung nicht auslesen.\n");
        goto fail;
    }
    fprintf(stderr, "Display gefunden: %dx%d\n", dev_width, dev_height);

    if (img_width != dev_width || img_height != dev_height) {
        fprintf(stderr, "Bildgroesse (%dx%d) passt nicht zur Display-Aufloesung (%dx%d)\n",
                img_width, img_height, dev_width, dev_height);
        goto fail;
    }

    pixel_count = (size_t)img_width * (size_t)img_height;
    rgb565 = malloc(pixel_count * 2);
    if (!rgb565) {
        fprintf(stderr, "Kein Speicher\n");
        goto fail;
    }

    for (i = 0; i < pixel_count; i++) {
        unsigned char r = rgb888[i * 3 + 0];
        unsigned char g = rgb888[i * 3 + 1];
        unsigned char b = rgb888[i * 3 + 2];
        rgb565[i * 2 + 0] = (unsigned char)((r & 0xf8) | (g >> 5));
        rgb565[i * 2 + 1] = (unsigned char)(((g & 0x1c) << 3) | (b >> 3));
    }

    if (backlight >= 0) {
        ax206_set_backlight(backlight);
    }

    ret = ax206_blit(rgb565, 0, 0, img_width, img_height);
    if (ret != 0) {
        /* Das Pearl beantwortet diesen herstellerspezifischen Befehl oft mit
         * einem "Fehler"-Statusbyte, obwohl das Bild trotzdem korrekt
         * ankommt (lcd4linux/dpf-ax ignoriert das genauso). Nur Hinweis,
         * kein Abbruch. */
        fprintf(stderr, "Hinweis: Geraet meldete Status %d (meist unkritisch).\n", ret);
    }

    fprintf(stderr, "Bild gesendet.\n");

    free(rgb565);
    free(rgb888);
    libusb_release_interface(dev, 0);
    libusb_close(dev);
    libusb_exit(NULL);
    return 0;

fail:
    free(rgb888);
    libusb_release_interface(dev, 0);
    libusb_close(dev);
    libusb_exit(NULL);
    return 1;
}
