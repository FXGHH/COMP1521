#include <stdio.h>
#include <string.h>

#define MAX_LINE_LENGTH 1024

int main(void) {

    char line[MAX_LINE_LENGTH + 1];

    while (fgets(line, sizeof line, stdin) != NULL) {

        if ((strlen(line) % 2) == 0) {
     
            fputs(line, stdout);
        }
    }
    return 0;
}