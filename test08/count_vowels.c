#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {

    FILE *input_stream = fopen(argv[1], "rb");
//     if (input_stream == NULL) {
//         perror(argv[1]);  // prints why the open failed
//         return 1;
//     }


    int c; // not char!
    int count = 0;
    while ((c = fgetc(input_stream)) != EOF) {
        if (strchr("aAeEiIoOuU", c) != NULL) {
            count++;
        }
    }

    printf("%d\n", count);
    fclose(input_stream);  // optional here as fclose occurs


    return 0;
}