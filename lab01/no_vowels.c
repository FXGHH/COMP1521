#include <stdio.h>
#include <string.h>

int main(void) {

    char c;

    while (scanf("%c", &c) == 1) {

        if (strchr("aAeEiIoOuU", c) == NULL) {

            printf("%c", c);
        }
    }

    return 0;
}
