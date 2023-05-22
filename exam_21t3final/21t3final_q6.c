#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <stdint.h>
// print a specified byte from a file
//
// first command line argument specifies a file
// second command line argument specifies a byte location
//
// output is a single line containing only the byte's value
// printed as a unsigned decimal integer (0..255)
// if the location does not exist in the file
// a single line is printed saying: error

int main(int argc, char *argv[]) {
    FILE *input_stream = fopen(argv[1], "rb");
    fseek(input_stream, 0, SEEK_END);
    uint64_t size;
    size = ftell(input_stream);
    int pos = atoi(argv[2]);
    int pos_rel = pos;

    if (pos < 0){
        pos_rel = -pos;
    }
    fseek(input_stream, pos, SEEK_SET);
    if (pos_rel > size){
        printf("error\n");
    } else {
        if (pos < 0){
            fseek(input_stream, pos, SEEK_END);
            printf("%d\n", fgetc(input_stream));
        
        } else {
            fseek(input_stream, pos, SEEK_SET);
            printf("%d\n", fgetc(input_stream));
        }
    }
    fclose(input_stream);
    return 0;
}
