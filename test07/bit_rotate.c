#include "bit_rotate.h"

// return the value bits rotated left n_rotations
uint16_t bit_rotate(int n_rotations, uint16_t bits) {
    uint16_t return_value = 0;
    for (int i = 15; i >= 0; i--){
        uint16_t a = bits >> i;
        a = a & ((uint16_t)1);
        if (a == 1){
            int cal = (i + n_rotations);
            if (cal < 0){
                while (cal < 0){
                cal = cal + 16;
                } 
            } else{
                while (cal >= 16){
                cal = cal - 16;
              }
            }
            uint16_t mask = ((uint16_t)1) << cal;
            return_value = return_value | mask;
        }
    }
    return return_value;
}
