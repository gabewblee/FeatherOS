#include "memory.h"

void * memset(void * ptr, int c, size_t size) {
    unsigned char * p = ptr;

    for (size_t i = 0; i < size; i++) {
        p[i] = (char) c;
    }
    
    return ptr;
}