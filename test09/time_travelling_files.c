#include <time.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>

void stat_file(char *pathname);

int main(int argc, char *argv[]) {
    for (int arg = 1; arg < argc; arg++) {
        stat_file(argv[arg]);
    }
    return 0;
}

void stat_file(char *pathname) {
    // printf("stat(\"%s\", &s)\n", pathname);

    struct stat s;
    if (stat(pathname, &s) != 0) {
        perror(pathname);
        exit(1);
    }
    time_t now = time(NULL);
    if (now - (time_t)s.st_mtime < 0){
        printf("%s has a timestamp that is in the future\n", pathname);
    } else if(now - (time_t)s.st_atime < 0){
        printf("%s has a timestamp that is in the future\n", pathname);
    }
    
    // printf("%10ld, %s\n", now, pathname);
    // printf("mtime =%10ld # Modification time (seconds since 1/1/70)\n",
    //        (long)s.st_mtime);
}