#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

int main(int argc, char **argv) {
    // int node_list[999] = {-1};
    // int file[999] = {-1};
    for (int arg = 1; arg < argc; arg++) {
    //     struct stat s;
    //     if (stat(argv[arg], &s) != 0) {
    //        perror(argv[arg]);
    //        exit(1);
    //     }
        
    //     int a = s.st_ino;
    //     for(int i = 0; i < 998; i++){
    //         if (node_list[i] == a){
    //             break;
    //         }else if (node_list[i] == -1){
    //             node_list[i] = s.st_ino;
    //             file[i] = arg;
    //             break;
    //         }
    //     }
        
    // }
    // for(int a = 0; a < 998; a++){
    //     if (file[a] == -1){
    //         exit(1);
    //     } else {
    //         printf("%s\n", argv[a + 1]);
    //     }
    // }

    // printf("%s\n", argv[1]);
        struct stat s;
        if (stat(argv[arg], &s) != 0) {
            perror(argv[arg]);
            exit(1);
        }
        int a = s.st_ino;
        int pr = 1;
        for (int i = 1; i < arg; i++) {
            if (stat(argv[i], &s) != 0) {
                perror(argv[i]);
                exit(1);
            }
            int b = s.st_ino;
            if (a == b){
                pr = 0;
            }
        }
        if (pr == 1){
            printf("%s\n", argv[arg]);
        }

        // printf("%d\n", a);
    }
    return EXIT_SUCCESS;
}
