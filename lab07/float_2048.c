// Multiply a float by 2048 using bit operations only

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

#include "floats.h"

// float_2048 is given the bits of a float f as a uint32_t
// it uses bit operations and + to calculate f * 2048
// and returns the bits of this value as a uint32_t
//
// if the result is too large to be represented as a float +inf or -inf is returned
//
// if f is +0, -0, +inf or -inf, or Nan it is returned unchanged
//
// float_2048 assumes f is not a denormal number
//
uint32_t float_2048(uint32_t f) {
    // PUT YOUR CODE HERE
    float_components_t fl;
    fl.sign = (f >> 31) & 1; 
    fl.exponent = ((((uint32_t)1) << (30 - 23 + 1)) - 1) & (f >> 23);
    fl.fraction = ((((uint32_t)1) << (22 + 1)) - 1) & (f);

    if (fl.fraction != 0 && fl.exponent == 0XFF) {
        return f;
    } else if ((fl.fraction == 0 && fl.exponent == 0XFF)) {
        return f;
    } else if (fl.fraction == 0 && fl.exponent == 0) {
        return f;
    } else {

        uint32_t dif = 0xff - fl.exponent;
        uint32_t exponent_mask = 0xff << 23;

        if (dif >= 11) {
            f = f + (11 << 23);
        } else {
            f = f | exponent_mask;
            f = f >> 23;
            f = f << 23;
        }
        return f;
    }
}
