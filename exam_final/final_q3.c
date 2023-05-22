#include <stdint.h>

/**
 * Return `1` if `value` *is* "balanced"
 * Return `0` if `value` *is not* "balanced"
 *
 * a number is said to be balanced iff it has the same number of bits set
 * set in its upper 16 bits as it does in its lower 16 bits.
 *
 * 0x10500c04 in binary, is 0b00010000010100000000110000000100
 * 0x10500c04 is balanced because there are 3 bits set in the upper 16 bits
 * and 3 bits set in the lower 16 bits
 * given 0x10500c04 final_q3 should return 1.
 *
 * 0x04300090 in binary, is 0b00000100001100000000000010010000
 * 0x04300090 is not balanced because there are 3 bits set in upper 16 bits
 * and 2 bits set in the second 16 bits.
 * given 0x04300090 final_q3 should return 0.
**/

int final_q3(uint32_t value) {
    uint32_t a = value;
    a = a << 16;
    a = a >> 16;
    int high = 0;
    int low = 0;
    // a = value & 0xffff;
    
    for (int i = 0; i < 16; i++){
        if ((a & 1) == 1){
            a = a >> 1;

            low++;
        } else{
            a = a >> 1;
        }

      
    }
    uint32_t b = value >> 16;
    for (int j = 0; j < 16; j++){
        if ((b & 1) == 1){
            b = b >> 1;
            high++;
        } else {
            b = b >> 1;
        }
    }
    if (high == low){
        return 1;
    } else {
        return 0;
    }
}
