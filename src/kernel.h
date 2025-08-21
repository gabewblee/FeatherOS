#ifndef KERNEL_H
#define KERNEL_H

#include <stdint.h>
#include <stddef.h>

// Dimensions
#define WIDTH 80
#define HEIGHT 20

// VGA memory addresses
#define MDA 0xB0000
#define CGA 0xB8000

// VGA attributes
#define ROW 0
#define COLUMN 0
#define COLOR 0x0F

void kernelMain();

#endif