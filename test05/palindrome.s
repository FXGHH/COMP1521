# read a line and print whether it is a palindrom

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
    la   $t3, 0          # int j = 0;
    addi $t4, $t7, -2    # int k = i - 2;
    
loop2:
    bge	$t3, $t4, end3

    mul  $t6, $t3, 1
    la   $t2, line      #
    add  $t2, $t2, $t6  #
    lb   $t1, ($t2)     #   load numbers[i] into $a0

    mul  $t6, $t4, 1
    la   $t2, line      #
    add  $t2, $t2, $t6  #
    lb   $t5, ($t2)     #   load numbers[i] into $a0

    beq	 $t5, $t1, end2
    la   $a0, not_palindrome
    li   $v0, 4
    syscall
    b    end4
end2:
    addi $t3, $t3, 1
    addi $t4, $t4, -1
    b    loop2
end3:

    la   $a0, palindrome
    li   $v0, 4
    syscall
end4:
    li   $v0, 0          # return 0
    jr   $ra


.data
str0:
    .asciiz "Enter a line of input: "
palindrome:
    .asciiz "palindrome\n"
not_palindrome:
    .asciiz "not palindrome\n"


# line of input stored here
line:
    .space 256

