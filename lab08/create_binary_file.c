#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc <= 2) {
        fprintf(stderr, "Usage: %s <source file> <destination file>\n", argv[0]);
        return 1;
    }
    FILE *input_stream = fopen(argv[1], "wb");
    if (input_stream == NULL) {
        perror(argv[1]);
        return 1;
    }
    long input = 2;
    while (input < argc){
        fputc(strtol(argv[input], NULL, 10), input_stream);
        input++;
    }

    fclose(input_stream);
    return 0;
}