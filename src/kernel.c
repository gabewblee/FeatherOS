#include "kernel.h"

static uint16_t * vgaMemory;
static size_t row;
static size_t column;
static uint8_t color;

static uint16_t vgaEntry(const char c) {
    return (uint16_t) c | color << 8;
}

static size_t strlen(const char * str) {
    size_t length = 0;

    while (str[length] != '\0') {
        length++;
    }

    return length;
} 

static void terminalWrite(const char c) {
    if (c == '\n') {
        row += 1;
        column = 0;
    } else {
        size_t index = row * WIDTH + column;
        vgaMemory[index] = vgaEntry(c);
        column += 1;

        if (column >= WIDTH) {
            row += 1;
            column = 0;
        }
    }
}

static void terminalPrint(const char * str) {
    size_t length = strlen(str);
    for (size_t i = 0; i < length; i++) {
        terminalWrite(str[i]);
    }
}

static void terminalInitialize() {
    vgaMemory = (uint16_t *) CGA;
    row = ROW;
    column = COLUMN;
    color = COLOR;

    for (size_t y = 0; y < HEIGHT; y++) {
        for (size_t x = 0; x < WIDTH; x++) {
            size_t index = y * WIDTH + x;
            vgaMemory[index] = vgaEntry(' ');
        }
    }

    terminalPrint("Welcome to FeatherOS!\n");
}

void kernelMain() {
    terminalInitialize();
}