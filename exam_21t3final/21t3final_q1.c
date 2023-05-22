#include <stdio.h>

// read two integers and print all the integers which have their bottom 2 bits set.

int main(void) {
    int x, y;

    scanf("%d", &x);
    scanf("%d", &y);
    x += 1;
    int mask = 3;
    while(x < y){
        if ((mask & x) == 3){
            printf("%d\n", x);
        }
        x++;
    }

    // PUT YOUR CODE HERE

    return 0;
}
