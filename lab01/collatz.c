#include<stdio.h>
#include<stdlib.h>

void recession (int number) {
    printf("%d\n", number);
    if (number != 1) {
        if (number % 2 == 0) {
            number = number / 2;
        } else {
            number = (number * 3) + 1;
        }
    }
    if (number != 1) {
        recession(number);
    } else {
        printf("%d\n", number);
    }
    return;
}

int main(int argc, char const *argv[]) {
    if (argc != 2) {
        printf("Usage: %s NUMBER", argv[0]);
        return 0;
    }
    
    int number = atoi(argv[1]);
    if (number == 1) {
        printf("%d\n", number);
        return 0;
    } else {
        recession(number);
    }
  
    return 0;
}