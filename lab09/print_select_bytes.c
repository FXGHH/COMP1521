#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc <= 2) {
        fprintf(stderr, "Usage: %s <source file> <destination file>\n", argv[0]);
        return 1;
    }
    FILE *input_stream = fopen(argv[1], "rb");
    if (input_stream == NULL) {
        perror(argv[1]);
        return 1;
    }
    int c;
    long index = 2;
    while (index < argc) {
        c = atoi(argv[index]);
        fseek(input_stream, c, SEEK_SET);
        int con = fgetc(input_stream);
        printf("%d - 0x%02X - '%c'\n", con, con, con);
        index++;
    }

    fclose(input_stream);
    return 0;
}