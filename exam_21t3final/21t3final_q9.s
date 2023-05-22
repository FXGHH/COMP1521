# this code reads a line of input and prints 42
# change it to check the string for brackets

# read a line of input and checks whether it consists only of balanced brackets
# if the line contains characters other than ()[]{} -1 is printed
# if brackets are not balance,  -1 is printed
# if the line contains only balanced brackets, length of the line is printed

main:
    push    $ra
    la   $a0, line
    la   $a1, 1024
    li   $v0, 8          # fgets(line, 1024, stdin);
    syscall
    li  $a0, 0
    li  $a1, '\n'
    jal check

    # THESE LINES JUST PRINT 42
    # REPLACE THE LINES BELOW WITH YOUR CODE
    move $a0, $v0
    li $v0, 1
    syscall
    li   $a0, '\n'
    li   $v0, 11
    syscall
    # REPLACE THE LINES ABOVE WITH YOUR CODE


    li   $v0, 0          # return 0
    jr   $31



# PUT YOU FUNCTION DEFINITIONS HERE
check:
    begin
    push  $s1
    push  $s2
    push  $s3
    la    $s1, line
    add   $s1, $s1, $a0
    lb	  $s2, 0($s1)

    
    bne	  $s2, $a1, not_e
equal:
    addi  $v0, $a0, 1  # v0 fanhui
    j     ret
not_e:
    move    $a2, $a0
    jal   match
    la    $s3, $v1
    ble	  $a0, $zero, ret
    jal   check
ret:
    pop    $s3
    pop    $s2
    pop    $s1
    end
    jr      $ra         


match:
    begin
    push  $s1
    push  $s2
    push  $s3
    push  $a0
    push  $a1
    push  $a2

    li    $v1, -1     # r
    la    $t1, line
    add	  $t1, $t1, $a2		# $t1 = $t1 +a2
    lb    $s2, $t1     # c
    li    $s3, 0       # w
    
    li    $t0, '['
    bne	  $s2, $t0, not1
    la    $s3, ']'     # w = ']'
    j     judge
not1:
    li    $t0, '('
    bne	  $s2, $t0, not2
    la    $s3, ')'     # w = ']'
    j     judge
not2:
    li    $t0, '{'
    bne	  $s2, $t0, judge
    la    $s3, '}'     # w = ']

    
judge:
    beq   $s3, $zero, endj
    addi  $a0, $a2, 1		# $t1 = $t1 +a2
    move  $a1, $s3
    jal   check
    move  $v1, $v0

endj:
    pop    $a2
    pop    $a1
    pop    $a0
    pop    $s3
    pop    $s2
    pop    $s1
    end
    jr      $ra    
    

.data
line:
    .byte 0:1024
