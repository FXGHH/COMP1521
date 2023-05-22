// swap pairs of bits of a 64-bit value, using bitwise operators

#include <assert.h>
#include <stdint.h>
#include <stdlib.h>

// return value with pairs of bits swapped
uint64_t bit_swap(uint64_t value) {
    // PUT YOUR CODE HERE
    uint64_t mask_1 = value & 0x5555555555555555;
    uint64_t mask_2 = value & 0xAAAAAAAAAAAAAAAA;
    uint64_t returned = (mask_1 << 1) | (mask_2 >> 1);
    return returned;
}