#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
    FILE *input_stream_1 = fopen(argv[1], "rb");
    if (input_stream_1 == NULL) {
        perror(argv[1]);  // prints why the open failed
        return 1;
    }

    FILE *input_stream_2 = fopen(argv[2], "rb");
    if (input_stream_2 == NULL) {
        perror(argv[2]);
        return 1;
    }

    int c; // not char!
    int a;
    int pos = 0;
    
//     (c = fgetc(input_stream_1)) != EOF
    while (1) {
        c = fgetc(input_stream_1);
        a = fgetc(input_stream_2);
        if (a != c && (c != EOF && a != EOF)){
            printf("Files differ at byte %d\n", pos);
            fclose(input_stream_1);  // optional here as fclose occurs
            fclose(input_stream_2); // automatically on exit
            return 0;
        }
        if (c != EOF && a == EOF) {
            printf("EOF on %s\n", argv[2]);
            fclose(input_stream_1);  // optional here as fclose occurs
            fclose(input_stream_2); // automatically on exit
            return 0;
        }
        if (c == EOF && a != EOF) {
            printf("EOF on %s\n", argv[1]);
            fclose(input_stream_1);  // optional here as fclose occurs
            fclose(input_stream_2); // automatically on exit
            return 0;
        }
        if (c == EOF && a == EOF) {
            printf("Files are identical\n");
            return 0;
        }
        pos++;
    }
    fclose(input_stream_1);  // optional here as fclose occurs
    fclose(input_stream_2); // automatically on exit
    return 0;
}