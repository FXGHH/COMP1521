// count bits in a uint64_t

#include <assert.h>
#include <stdint.h>
#include <stdlib.h>

// return how many 1 bits value contains
int bit_count(uint64_t value) {
    // PUT YOUR CODE HERE
    uint64_t a = 1;
    int count = 0;
    for (int i = 63; i >= 0; i--) {
        uint64_t b = value >> i;
        if ((a & b) != 0) {
            count++;
        }
    }
    return count;
}
