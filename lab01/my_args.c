#include<stdio.h>

int main(int argc, char const *argv[]) {
    printf("Program name: %s\n", argv[0]);
    if (argc == 1) {
        printf("There are no other arguments\n");
        return 0;
    }
    printf("There are %d arguments:\n", argc - 1);
    int k = argc - 1;
    for (int i = 1; i <= k; i++) {
        printf("\tArgument %d is \"%s\"\n", i, argv[i]);
    }
    
    return 0;
}

