#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
int main(int argc, char *argv[]) {
    if (argc != 5) {
        fprintf(stderr, "Usage: %s <source file> <destination file>\n", argv[0]);
        return 1;
    }

    FILE *input_stream = fopen(argv[1], "rb");
    if (input_stream == NULL) {
        perror(argv[1]);  // prints why the open failed
        return 1;
    }

    FILE *output_stream = fopen(argv[3], "rb");
    if (output_stream == NULL) {
        perror("tem.txt");
        return 1;
    }

    fseek(input_stream, atoi(argv[2]), SEEK_SET);
    fseek(output_stream, atoi(argv[4]), SEEK_SET);
    // printf("42nd byte of the file is %d\n", fgetc(input_stream));
    // printf("42nd byte of the file is %d\n", fgetc(output_stream));
    int a = fgetc(input_stream);
    int b = fgetc(output_stream);
    if (a == 0xffffffff || b == 0xffffffff){
        printf("byte %d in %s and byte %d in %s are not the same\n", atoi(argv[2]), argv[1], atoi(argv[4]), argv[3]);
        // printf("ssdadada\n");
    } else {
        // printf("42nd byte of the file is %d\n", fgetc(input_stream));
        // printf("42nd byte of the file is %d\n", fgetc(output_stream));
        if (a == b){
            printf("byte %d in %s and byte %d in %s are the same\n", atoi(argv[2]), argv[1], atoi(argv[4]), argv[3]);
        } else {
            printf("byte %d in %s and byte %d in %s are not the same\n", atoi(argv[2]), argv[1], atoi(argv[4]), argv[3]);
        }
    }
    
    
    fclose(output_stream);
    fclose(input_stream); 

    return 0;
}