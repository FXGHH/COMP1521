#include <stdio.h>
#include <stdlib.h>

void fib(int aim, int a, int b, int cur) {

    if (aim == cur) {
        printf("%d\n", a + b);
        return;
    } else {
        int c = a;
        a = b;
        b = c + a;
        cur++;
        fib(aim, a, b, cur);
    }
    return;
}

int main(void) {

    int aim;
    int a = 0, b = 1, cur = 2;

    while (scanf("%d", &aim) != EOF) {
        if (aim == 0) {
            printf("0\n");
        } else if (aim == 1) {
            printf("1\n");
        } else if (aim >= 46){
            printf("0\n");
        } else {
            fib(aim, a, b, cur);
        }
        
    }

    return EXIT_SUCCESS;
}

