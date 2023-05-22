# Sieve of Eratosthenes
# https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
main:

    # PUT YOUR CODE
    li   $t0, 0         # i = 0
loop0:
    bge  $t0, 1000, end0  # while (i < 1000) { 

    mul  $t1, $t0, 1    #   calculate &numbers[i]
    la   $t2, prime     #
    add  $t3, $t1, $t2  #

    li   $t4, 1
    sb   $t4, ($t3)     #   prime[i] = 1;
    
    addi $t0, $t0, 1    #   i++;
    j    loop0          # }

end0:
    li   $t0, 2         # i = 2
loop1:
    bge  $t0, 1000, end2  # while (i < 1000) {

    mul  $t1, $t0, 1
    la   $t2, prime   #
    add  $t3, $t1, $t2  #
    lb   $t1, ($t3)     #   load numbers[i] into $a0

    li   $t7, 0
    bgt	 $t1, $t7, always   # if (prime[i])

end1:
    addi $t0, $t0, 1    #   i++;
    b loop1
always:
    move $a0, $t0       
    li   $v0, 1         #   printf("%d",i)
    syscall

    li   $a0, '\n'      #   printf("%c", '\n');
    li   $v0, 11
    syscall
    mul  $t4, $t0, 2    #   int j = 2 * i;   j = $t4 

loop2:
    bge  $t4, 1000, end1  # while (j < 1000) {
    
    mul  $t1, $t4, 1
    la   $t2, prime   #
    add  $t3, $t1, $t2  #
    li   $t5, 0
    sb   $t5, ($t3)     #   prime[i] = 0; 

    add  $t4, $t4, $t0    #   j = j + i;
    b loop2
end2:
    li $v0, 0           # return 0}
    jr $31

.data
prime:
    .space 1000