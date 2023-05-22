#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <spawn.h>
#include <sys/wait.h>

int main(int argc, char **argv) {
    char ch[99] = {0};
    while (fgets(ch, 99, stdin) == NULL){
        pid_t pid;
        extern char **environ;
        char *date_argv[] = {argv[1], ch, NULL};

        // spawn "/bin/date" as a separate process
        if (posix_spawn(&pid, argv[1], NULL, NULL, date_argv, environ) != 0) {
            perror("spawn");
            exit(1);
        }

        // wait for spawned processes to finish
        int exit_status;
        if (waitpid(pid, &exit_status, 0) == -1) {
            perror("waitpid");
            exit(1);
        }
       
    }
    

    // printf("/bin/date exit status was %d\n", exit_status);
    return 0;
}