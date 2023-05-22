
main:                  # int main(void) {
    la   $a0, prompt   # printf("Enter a number: ");
    li   $v0, 4
    syscall

    li   $v0, 5         # scanf("%d", number);
    syscall

    move $t1, $v0       
    li   $t0, 1       # t0 = n 
    li  $t2, 0           # t2 = total

loop_1:

    bgt	$t0, $t1, end    # t0 = n , t1 = hoo many
    li  $t3, 1           # t3 =  j
    

loop_2:
    
    bgt	$t3, $t0, print
    li  $t4, 1           # t4 =  i
    move $t5, $t3
    add	$t3, $t3, 1
    b loop_3

loop_3:

    bgt	$t4, $t5, loop_2
    add	$t2, $t2, $t4    # total = total + i
    add	$t4, $t4, 1
    b loop_3

print:

    move $a0, $t2      # printf("%d", 42);
    li   $v0, 1
    syscall

    li   $a0, '\n'    # printf("%c", '\n');
    li   $v0, 11
    syscall

    li  $t2, 0           # t2 = total
    add	$t0, $t0, 1
    b loop_1

end:
    li   $v0, 0        # return 0
    jr   $ra           # return

    .data
prompt:
    .asciiz "Enter how many: "
