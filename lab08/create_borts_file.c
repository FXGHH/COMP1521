#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <ctype.h>
int main(int argc, char *argv[]) {
    if (argc != 4) {
        fprintf(stderr, "Usage: %s <source file> <destination file>\n", argv[0]);
        return 1;
    }
    FILE *input_stream = fopen(argv[1], "w");
    if (input_stream == NULL) {
        perror(argv[1]);
        return 1;
    }
    uint32_t start = strtol(argv[2], NULL, 10);
    uint32_t end = strtol(argv[3], NULL, 10);

    while (start <= end){
        uint32_t tep = start;
        uint32_t head = (tep >> 8) & 0xff;
        tep = start;
        uint32_t tail = tep & 0x00ff;
        fputc(head, input_stream);
        fputc(tail, input_stream);
        start++;
    }
    fclose(input_stream);
    return 0;
}