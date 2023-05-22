#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <ctype.h>
#include <string.h>

//
// Store an arbitray length Binary Coded Decimal number.
// bcd points to an array of size n_bcd
// Each array element contains 1 decimal digit.
// Digits are stored in reverse order.
//
// For example if 42 is stored then
// n_bcd == 2
// bcd[0] == 0x02
// bcd[1] == 0x04
//

typedef struct big_bcd {
    unsigned char *bcd;
    int n_bcd;
} big_bcd_t;


big_bcd_t *bcd_add(big_bcd_t *x, big_bcd_t *y);
void bcd_print(big_bcd_t *number);
void bcd_free(big_bcd_t *number);
big_bcd_t *bcd_from_string(char *string);

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <number> <number>\n", argv[0]);
        exit(1);
    }

    big_bcd_t *left = bcd_from_string(argv[1]);
    big_bcd_t *right = bcd_from_string(argv[2]);

    big_bcd_t *result = bcd_add(left, right);

    bcd_print(result);
    printf("\n");

    bcd_free(left);
    bcd_free(right);
    bcd_free(result);

    return 0;
}


// DO NOT CHANGE THE CODE ABOVE HERE



big_bcd_t *bcd_add(big_bcd_t *x, big_bcd_t *y) {

    // PUT YOUR CODE HERE
    int a = x->n_bcd, b = y->n_bcd;
    big_bcd_t *top;
    big_bcd_t *bottom;

    if (a >= b) {
        top = x;
        bottom = y;
    } else {
        top = y;
        bottom = x;
    }
    int buffer = 0, length = bottom->n_bcd;

    for (int i = 0; i < length; i++) {

         a = top->bcd[i];
        //printf("a = %d\n", top->bcd[i]);
        //printf("char a = %c\n", top->bcd[i]);
         b = bottom->bcd[i];
        //printf("b = %d\n", b);
        int sum = a + b;
        if (buffer == 1) {
            sum = sum + 1;
            buffer = 0;
        }
        if (sum >= 10) {

            int remain = sum - 10;
            top->bcd[i] = remain;
            //printf("remain = %d\n", remain);
            buffer = 1;
            
        } else {

            top->bcd[i] = sum;
            buffer = 0;

        }
        int k = i;
        while ((buffer != 0 && i < top->n_bcd - 1) && k + 1 == length) {
            //printf("loop\n");
            sum = top->bcd[i + 1] + buffer;
            if (sum >= 10) {

                int remain = sum - 10;
                top->bcd[i + 1] = remain;
                buffer = 1;
                
            } else {

                top->bcd[i + 1] = sum;
                buffer = 0;

            } 
            i++;
        }
        

    }
    //printf("top size = %d\n", sizeof(top->bcd));

    if (buffer != 0) {

        //printf("star\n");
        //printf("or_size = %d\n", top->n_bcd * sizeof top->bcd[0]);
        //printf("new_size = %d\n", (top->n_bcd + 1) * sizeof top->bcd[0]);
        top->bcd = realloc(top->bcd, (top->n_bcd + 1) * sizeof top->bcd[0]);
        //printf("[0] = %c\n", top->bcd[0] + '0');

        top->bcd[top->n_bcd] = 1;
        top->n_bcd = top->n_bcd + 1;

        //printf("top->bcd[top->n_bcd] = %d\ntop->bcd[top->n_bcd - 1] = %d\n", 
                //top->bcd[top->n_bcd], top->bcd[top->n_bcd - 1]);
        //printf("now = %d\n", strlen(top->bcd));
        //top->bcd[top->n_bcd + 1] = '\0';

    } 
    return top;

}


// DO NOT CHANGE THE CODE BELOW HERE


// print a big_bcd_t number
void bcd_print(big_bcd_t *number) {
    // if you get an error here your bcd_add is returning an invalid big_bcd_t
    assert(number->n_bcd > 0);
    for (int i = number->n_bcd - 1; i >= 0; i--) {
        putchar(number->bcd[i] + '0');
        //printf("i = %d\n", i);
    }
}

// free storage for big_bcd_t number
void bcd_free(big_bcd_t *number) {
    // if you get an error here your bcd_add is returning an invalid big_bcd_t
    // or it is calling free for the numbers it is given
    free(number->bcd);
    free(number);
}

// convert a string to a big_bcd_t number
big_bcd_t *bcd_from_string(char *string) {
    big_bcd_t *number = malloc(sizeof *number);
    assert(number);

    int n_digits = strlen(string);
    assert(n_digits);
    number->n_bcd = n_digits;

    number->bcd = malloc(n_digits * sizeof number->bcd[0]);
    assert(number->bcd);

    for (int i = 0; i < n_digits; i++) {
        int digit = string[n_digits - i - 1];
        assert(isdigit(digit));
        number->bcd[i] = digit - '0';
    }

    return number;
}