#include <stdio.h>

int main(int argc, char *argv[]) {

    FILE *input_stream = fopen(argv[1], "rb");
    if (input_stream == NULL) {
        perror(argv[1]);  // prints why the open failed
        return 1;
    }
    
    FILE *output_stream = fopen("new_file", "wb");
    if (output_stream == NULL) {
        perror(argv[2]);
        return 1;
    }

    int c; // not char!
    while ((c = fgetc(input_stream)) != EOF) {
        // int b = fgetc(input_stream);
        // if (c == '\r' && b == '\n'){
        //     fputc(b, output_stream);
        // } else if (c == '\r' && b != '\n'){
        //     c = '\n';
        //     fputc(c, output_stream);
        // } else {
        //     if (b != EOF){
        //         fputc(c, output_stream);
        //         fputc(b, output_stream);
        //     } else {
        //         fputc(c, output_stream);
        //         break;
        //     }
            
        // }
        if (c == '\r'){
            int b = fgetc(input_stream);
            if (b == '\n'){
                fputc(b, output_stream);
                
            } else {
                c = '\n';
                fputc(c, output_stream);
                fseek(input_stream, -1, SEEK_CUR);
            }
            if (b == EOF){
            break;
            }
        } else {
            fputc(c, output_stream);
        }

    }
    fclose(input_stream);  // optional here as fclose occurs
    fclose(output_stream); // automatically on exit

    FILE *a = fopen("new_file", "rb");
    if (input_stream == NULL) {
        perror(argv[1]);  // prints why the open failed
        return 1;
    }
    FILE *b = fopen(argv[1], "wb");
    if (output_stream == NULL) {
        perror(argv[2]);
        return 1;
    }
    while ((c = fgetc(a)) != EOF) {
        fputc(c, b);
    }
    fclose(a);  // optional here as fclose occurs
    fclose(b); // automatically on exit
    return 0;
}

