main:
    li   $v0, 5         #   scanf("%d", &x);
    syscall             #
    move $t0, $v0

    li   $v0, 5         #   scanf("%d", &y);
    syscall             #
    move $t1, $v0

    addi $t2, $t0, 1    #   $t2 = i
    li   $t4, 13
 
loop1:
    bge  $t2, $t1, end
    beq	 $t2, $t4, end0
    move $a0, $t2        #   printf("%d\n", i);
    li   $v0, 1
    syscall

    li   $a0, '\n'      #   printf("%c", '\n');
    li   $v0, 11
    syscall
end0:
    addi $t2, $t2, 1
    b loop1
end:

    li   $v0, 0         # return 0
    jr   $ra
