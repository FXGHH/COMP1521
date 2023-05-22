# read a line and print its length

main:
    la   $a0, str0       # printf("Enter a line of input: ");
    li   $v0, 4
    syscall

    la   $a0, line
    la   $a1, 256
    li   $v0, 8          # fgets(buffer, 256, stdin)
    syscall              #
    
    li   $t7, 0

loop1:
    mul  $t6, $t7, 1
    la   $t2, line      #
    add  $t2, $t2, $t6  #
    lb   $t1, ($t2)     #   load numbers[i] into $a0

    beq	 $t1, $zero, end1

    addi $t7, $t7, 1
    b    loop1

end1:

    la   $a0, str1       # printf("Line length: ");
    li   $v0, 4
    syscall

    move $a0, $t7         # printf("%d", i);
    li   $v0, 1
    syscall

    li   $a0, '\n'       # printf("%c", '\n');
    li   $v0, 11
    syscall

    li   $v0, 0          # return 0
    jr   $ra


.data
str0:
    .asciiz "Enter a line of input: "
str1:
    .asciiz "Line length: "


# line of input stored here
line:
    .space 256

