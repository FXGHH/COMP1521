/**
 * given a `UTF-8` encoded string,
 * return a new string that is the reversed version of the given string.
 *
 * `unicode` has specific rules about how string should be reversed
 * We don't want to reverse a `unicode` string
 * We want to reverse a sequence of `UTF-8` code points
 *
 * eg:
 * "hello world"
 * would return "dlrow olleh"
 *
 * "🍓🍇🍈🍍🍐"
 * would return "🍐🍍🍈🍇🍓"
**/
#include<string.h>
char *final_q7(char *string) {
    int length = strlen(string);
    char new[length + 1];
    int c; // not char!
    while ((c = ) != 0) {
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
    return string;
}
