#include <stdio.h>

int main(int argc, char *argv[]) {

    FILE *input_stream = fopen(argv[1], "rb");
    if (input_stream == NULL) {
        perror(argv[1]);  // prints why the open failed
        return 1;
    }

    int head = fgetc(input_stream);
    int c; // not char!
    int length = 0;
    fseek(input_stream, 0, SEEK_SET);
    while ((c = fgetc(input_stream)) != EOF) {
        length ++;
    }

    fseek(input_stream, 0, SEEK_END);

    int start = 0;
    while ((c = fgetc(input_stream)) != head) {
    
        if(c == '\n'){
           int b;
           b = fgetc(input_stream);
           while(b != '\n' && b != EOF){
               fputc(b, stdout);
               b = fgetc(input_stream);
           }
           fputc('\n', stdout);
           fseek(input_stream, -start, SEEK_END);
        } else {
           fseek(input_stream, -2, SEEK_CUR);
           start += 2;
        }
    }
    fseek(input_stream, 0, SEEK_SET);
    int new = fgetc(input_stream);
    while(new != '\n' && new != EOF){
        fputc(new, stdout);
        new = fgetc(input_stream);
    }

    fclose(input_stream); 

    return 0;
}
