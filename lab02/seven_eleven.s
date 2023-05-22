# Read a number and print positive multiples of 7 or 11 < n

main:                  # int main(void) {

    la   $a0, prompt   # printf("Enter a number: ");
    li   $v0, 4
    syscall

    li   $v0, 5         # scanf("%d", number);
    syscall

    move $t1, $v0      
    li   $t0, 1

loop:

    # add	$t0, $t0, 1
    bge	$t0, $t1, end    # t0 was increment, t1 was limitation
    li  $t4, 7
    div	$t0, $t4          # a =  i % 7
    mfhi $t2
    beq	$t2, 0, print

    li  $t5, 11
    div	$t0, $t5          # b = i % 11
    mfhi $t3
    beq	$t3, 0, print

    add	$t0, $t0, 1
    b loop

print:

    move $a0, $t0      # printf("%d", 42);
    li   $v0, 1
    syscall

    li   $a0, '\n'    # printf("%c", '\n');
    li   $v0, 11
    syscall
    add	$t0, $t0, 1
    b loop

end:
    jr   $ra           # return

    .data
prompt:
    .asciiz "Enter a number: "
