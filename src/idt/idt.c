#include "idt.h"
#include "../kernel.h"
#include "../config.h"
#include "../memory/memory.h"

struct idtEntry idtEntries[TOTAL_INTERRUPTS];
struct idtPtr idtPtr;

extern void idtLoad(struct idtPtr * ptr);

void interruptZero() {

}

void idtSet(int interruptNumber, void * address) {
    struct idtEntry * idtDescriptor = &idtEntries[interruptNumber];
    idtDescriptor->offsetLow = (uint16_t) address & 0xFFFF;
    idtDescriptor->selector = KERNEL_CODE_SELECTOR;
    idtDescriptor->zero = 0x00;
    idtDescriptor->typeAttributes = 0xEE;
    idtDescriptor->offsetHigh = ((uint32_t) address >> 16) & 0xFFFF;
}

void idtInitialize() {
    memset(idtEntries, 0, sizeof(idtEntries));
    idtPtr.limit = sizeof(idtEntries) - 1;
    idtPtr.base = (uint32_t) idtEntries;
    idtLoad(&idtPtr);
}