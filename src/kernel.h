#ifndef KERNEL_H
#define KERNEL_H

#include <stdint.h>
#include <stddef.h>

// Dimensions
#define WIDTH 80
#define HEIGHT 20

#define MDA 0xB0000
#define CGA 0xB8000

void kernelMain();

#endif