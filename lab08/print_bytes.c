#include <stdio.h>
#include <ctype.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <source file> <destination file>\n", argv[0]);
        return 1;
    }
    FILE *input_stream = fopen(argv[1], "rb");
    if (input_stream == NULL) {
        perror(argv[1]);
        return 1;
    }
    int c;
    long index = 0;
    while ((c = fgetc(input_stream)) != EOF) {
        if (isprint(c) != 0){
            printf("byte %4ld: %3d 0x%02x '%c'\n", index, c, c, c);
        } else {
            printf("byte %4ld: %3d 0x%02x\n", index, c, c);
        }
        index++;
    }

    fclose(input_stream);
    return 0;
}