#include <stdio.h>

// copy file specified as command line argument 1 to
// file specified as command line argument 2
// convert UTF8 to ASCII by replacing multibyte UTF8 characters with '?'

int main(int argc, char *argv[]) {

    // PUT YOUR CODE HERE
    FILE *input_stream = fopen(argv[1], "rb");
    if (input_stream == NULL) {
        perror(argv[1]);  // prints why the open failed
        return 1;
    }

    FILE *output_stream = fopen(argv[2], "wb");
    if (output_stream == NULL) {
        perror(argv[2]);
        return 1;
    }

    int c; // not char!
    while ((c = fgetc(input_stream)) != EOF) {
        // printf("%d\n", c);
        if (c >= 0xC0 && c < 0xE0){
            fseek(input_stream, 1, SEEK_CUR);
            c = 63;
            fputc(c, output_stream);
        } else if(c >= 0xE0 && c < 0xF0){
            fseek(input_stream, 2, SEEK_CUR);
            c = 63;
            fputc(c, output_stream);
        } else if(c >= 0xF0){
            fseek(input_stream, 3, SEEK_CUR);
            c = 63;
            fputc(c, output_stream);
        } else{
            fputc(c, output_stream);
        }
    }


    fclose(input_stream);  // optional here as fclose occurs
    fclose(output_stream); // automatically on exit

    return 0;
}
