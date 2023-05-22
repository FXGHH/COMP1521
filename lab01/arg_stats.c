#include<stdio.h>
#include<stdlib.h>

int main(int argc, char const *argv[]) {
    int min = atoi(argv[1]), max = atoi(argv[1]), sum = 0, pro = 1;
    int k = argc - 1;
    for (int i = 1; i <= k; i++) {

        if (min > atoi(argv[i])) {
            min = atoi(argv[i]);
        }
        if (max < atoi(argv[i])) {
            max = atoi(argv[i]);
        }
        sum = sum + atoi(argv[i]);
        pro = pro * atoi(argv[i]);

    }
    int mean = sum / (argc - 1);
    printf("MIN:  %d\nMAX:  %d\nSUM:  %d\nPROD: %d\nMEAN: %d\n", min, max, sum, pro, mean);
    
    return 0;
}

