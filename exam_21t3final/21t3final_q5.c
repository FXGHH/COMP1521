#include <stdlib.h>
#include <stdint.h>

// given 2 uint32_t values
// return the number of bits which are set (1) in both values

int final_q5(uint32_t value1, uint32_t value2) {
    uint32_t result = value1 & value2;
    int count = 0;
    for (int i = 0; i < 32; i++){
        uint32_t new;
        new = result >> i;
        if ((new & 1) == 1){
            count ++;
        }
    }
    return count;
}
