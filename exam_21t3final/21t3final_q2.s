# read two integers and print all the integers which have their bottom 2 bits set.

main:
    li $v0, 5
    syscall
    move $t0, $v0

    li $v0, 5
    syscall
    move $t1, $v0

    addi $t0, $t0, 1
large:
    bge	$t0, $t1, end
    andi $t3, $t0, 3			# $t0 = $t1 & 0
    li   $t4, 3         
    beq	 $t3, $t4, true
    addi $t0, $t0, 1
    j large
true:
    move $a0, $t0
    li   $v0, 1
    syscall
    li   $a0, '\n'
    li   $v0, 11
    syscall
    addi $t0, $t0, 1
    j large
    # REPLACE THE LINES ABOVE WITH YOUR CODE
end:
    li $v0, 0
    jr $31
