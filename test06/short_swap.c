// Swap bytes of a short

#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

// given uint16_t value return the value with its bytes swapped
uint16_t short_swap(uint16_t value) {
    // PUT YOUR CODE HERE
    uint16_t front = (0x00ff & value) << 8;
    value = value >> 8;
    uint16_t swaped_value = value | front;

    return swaped_value;
}
