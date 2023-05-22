#include "float_exp.h"

// given the 32 bits of a float return the exponent
uint32_t float_exp(uint32_t f) {
    f = (f >> 23) & 0xff;
    return f;
}