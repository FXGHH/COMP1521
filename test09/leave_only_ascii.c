#include <stdio.h>
#include <ctype.h>
int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <source file> <destination file>\n", argv[0]);
        return 1;
    }

    FILE *input_stream = fopen(argv[1], "rw");
    if (input_stream == NULL) {
        perror(argv[1]);  // prints why the open failed
        return 1;
    }

    FILE *output_stream = fopen("tem.txt", "wb");
    if (output_stream == NULL) {
        perror("tem.txt");
        return 1;
    }

    int c; // not char!
    while ((c = fgetc(input_stream)) != EOF) {
        if (isascii(c)){
            fputc(c, output_stream);
        }
    }
    fclose(output_stream);
    fclose(input_stream); 
    
    FILE *input_stream_2 = fopen("tem.txt", "r");
    FILE *output_stream_2 = fopen(argv[1], "wb");
    while ((c = fgetc(input_stream_2)) != EOF) {
        fputc(c, output_stream_2);
    }

    fclose(input_stream_2);  // optional here as fclose occurs
    fclose(output_stream_2); // automatically on exit

    return 0;
}