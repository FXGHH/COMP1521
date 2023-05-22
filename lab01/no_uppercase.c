#include <stdio.h>
#include <ctype.h>

int main(void) {

    int c;
    while ((c = getchar()) != EOF) {

        if (c >= 'A' && c <= 'Z') {
            c = tolower(c);
        }
        putchar(c);
    }

    return 0;
}
