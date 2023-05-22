#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    char *home = getenv("HOME");
    if (home == NULL) {
        home = "."; 
    }

    char *filename = ".diary";
    int path_len = strlen(home) + strlen(filename) + 2; 
    char diary_path[path_len];
    snprintf(diary_path, path_len, "%s/%s", home, filename); 

    FILE *file = fopen(diary_path, "a");
    if (file == NULL) {
        perror(diary_path);
        return 1;
    }
    int input = 1;
    while (input < argc){
        fputs(argv[input], file);
        fputs(" ", file);
        input++;
    }
    fputs("\n", file);
    fclose(file);

    return 0;
}