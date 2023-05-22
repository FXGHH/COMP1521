// compile .c files specified as command line arguments
//
// if my_program.c and other_program.c is speicified as an argument then the follow two command will be executed:
// /usr/local/bin/dcc my_program.c -o my_program
// /usr/local/bin/dcc other_program.c -o other_program

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <spawn.h>
#include <sys/types.h>
#include <sys/wait.h>

#define DCC_PATH "/usr/local/bin/dcc"

extern char **environ;

int main(int argc, char **argv) {
    long index = 1;
    while (index < argc) {
        FILE *input_stream = fopen(argv[index], "a");
        if (input_stream == NULL) {
            perror(argv[1]);
            return 1;
        }
        fclose(input_stream);
        pid_t pid;
        char cop[100];
        strcpy(cop, argv[index]);
        char *n_ar = strtok(cop, ".");
        char *ls_argv[] = {DCC_PATH, argv[index], "-o", n_ar, NULL};
        printf("running the command: ");
        printf("\"");
        printf("/usr/local/bin/dcc %s -o %s", argv[index], n_ar);
        printf("\"\n");
        if (posix_spawn(&pid, DCC_PATH, NULL, NULL, ls_argv, environ) != 0) {
            perror("spawn");
            exit(EXIT_SUCCESS);
            
        }
        int exit_status;
        if (waitpid(pid, &exit_status, 0) == -1) {
            perror("waitpid");
            exit(EXIT_SUCCESS);
        }
        index++;
    }
    return EXIT_SUCCESS;
}
