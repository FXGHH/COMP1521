# read an integer
# print 1 iff  the least significant bit is equal to the most significant bit
# print 0 otherwise

main:
    li   $v0, 5
    syscall
    move $t0, $v0

    # move $t1, $t0
    srl  $t1, $t0, 31			# $t0 = $t1 >> 0
    # move $t1, $t0
    andi $t2, $t0, 1
    bne	 $t1, $t2, n_equal
    # THESE LINES JUST PRINT 42
    # REPLACE THE LINES BELOW WITH YOUR CODE
    li $a0, 1
    li $v0, 1
    syscall
    li   $a0, '\n'
    li   $v0, 11
    syscall
    j end
n_equal:
    li $a0, 0
    li $v0, 1
    syscall
    li   $a0, '\n'
    li   $v0, 11
    syscall
    # REPLACE THE LINES ABOVE WITH YOUR CODE


end:
    li $v0, 0
    jr $31
