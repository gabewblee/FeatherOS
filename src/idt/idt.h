#ifndef IDT_H
#define IDT_H

#include <stdint.h>

struct idtEntry {
    uint16_t offsetLow;        // Offset bits 0 - 15
    uint16_t selector;         // GDT selector
    uint8_t zero;              // Reserved, must be zero
    uint8_t typeAttributes;    // Descriptor type and attributes
    uint16_t offsetHigh;       // Offset bits 16 - 31
} __attribute__((packed));

struct idtPtr {
    uint16_t limit;            // Size of the IDT in bytes
    uint32_t base;             // Base address of the IDT
} __attribute__((packed));

void idtInitialize();

#endif