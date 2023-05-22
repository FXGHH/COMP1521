# Read three numbers `start`, `stop`, `step`
# Print the integers bwtween `start` and `stop` moving in increments of size `step`

main:                       # int main(void)
    la   $a0, prompt1       # printf("Enter the starting number:");
    li   $v0, 4
    syscall

    li   $v0, 5             # scanf("%d", number);
    syscall
    move $t0, $v0           #$t0 = start

    la   $a0, prompt2       # printf("Enter the stopping number: ");
    li   $v0, 4
    syscall

    li   $v0, 5             # scanf("%d", number);
    syscall
    move $t1, $v0           #$t1 = stop

    la   $a0, prompt3       # printf("Enter the stopping number: ");
    li   $v0, 4
    syscall

    li   $v0, 5             # scanf("%d", number);
    syscall
    move $t2, $v0           #$t2 = step


    blt	 $t1, $t0, less
    blt	 $t0, $t1, greater

less:
    bge  $t2, $zero, end
    b    loop1

greater:
    ble  $t2, $zero, end
    b    loop2

loop1:
    blt	 $t0, $t1, end
    move $a0, $t0      
    li   $v0, 1
    syscall
    li   $a0, '\n'          # printf("%c", '\n');
    li   $v0, 11
    syscall
    add	 $t0, $t0, $t2
    b    loop1

loop2:
    bgt	 $t0, $t1, end
    move $a0, $t0      
    li   $v0, 1
    syscall
    li   $a0, '\n'          # printf("%c", '\n');
    li   $v0, 11
    syscall
    add	 $t0, $t0, $t2
    b    loop2


end:
    li   $v0, 0
    jr   $ra          # return 0

.data
    prompt1: .asciiz "Enter the starting number: "
    prompt2: .asciiz "Enter the stopping number: "
    prompt3: .asciiz "Enter the step size: "
