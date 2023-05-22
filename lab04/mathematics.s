.data
    prompt_str: .asciiz "Enter a random seed: "
    result_str: .asciiz "The random result is: "

.text
main:
    la $a0, prompt_str    # printf("Enter a random seed: ");
    li $v0, 4
    syscall
    li $v0, 5           # scanf("%d", &x);
    syscall             # $t0 = random_seed
    move $a0, $v0
    #  ADD CODE TO CREATE STACK FRAME
    begin  
    push  $ra            # save $ra onto stack
    # move  $a0, $t0       # seed_rand(random_seed); <random_seed = $a0>
    jal	  seed_rand			# jump to target and save position to $ra

    li    $a0, 100       # rand(100);
    jal   rand           # $v0 = value

    move  $a1, $v0        
    jal   add_rand

    move  $a0, $v0       # $a0 = b844 = 47172(right)

    jal   sub_rand
    move  $t2, $v0       # final value in $t2 into seq_rand
    jal   seq_rand
    move  $t6, $t2

    la    $a0, result_str    # printf("The random result is: ");
    li    $v0, 4
    syscall

    move $a0, $t6      
    li   $v0, 1         #   printf("%d",value)
    syscall

    li   $a0, '\n'      #   printf("%c", '\n');
    li   $v0, 11
    syscall
    
    j    end1
    # ADD CODE FORFUNCTION HERE
add_rand:
    begin
    push  $ra
    li    $a0, 0xFFFF
    jal   rand           # $v0 = value
    add   $v0, $v0, $a1  # value = $v0 = add_rand(value);
    pop   $ra
    end
    jr    $ra
sub_rand:
    begin
    push  $ra
    jal   rand           # $v0 = value
    sub   $v0, $a0, $v0  # value = $v0 = add_rand(value);
    pop   $ra
    end
    jr    $ra



seq_rand:
    begin
    push  $ra
    # move  $a1, $a0
    li    $a0, 100
    jal   rand           # $v0 = value
    move  $t3, $v0       # limit = $t3 = 46
    li    $t4, 0         # i = $t4 = 0
loop0:
    bge	  $t4, $t3, end0    
    begin
    push  $ra
    move  $a1, $t2
    jal   add_rand
    move  $t2, $v0          
    pop   $ra
    end
    # jr    $ra    
    addi  $t4, $t4, 1
    b     loop0
end0:
    pop   $ra
    end
    jr    $ra


    # ADD CODE TO REMOVE STACK FRAME
end1:
    pop   $ra            # recover $ra from stack
    end                  # move frame pointer back
    jr  $ra

##
## The following are two utility functions, provided for you.
##
## You don't need to modify any of the following.
## But you may find it useful to read through.
## You'll be calling these functions from your code.
##

OFFLINE_SEED = 0x7F10FB5B

########################################################################
# .DATA
.data

# int random_seed;
.align 2
random_seed:    .space 4


########################################################################
# .TEXT <seed_rand>
.text

# DO NOT CHANGE THIS FUNCTION

seed_rand:
    # Args:
    #   - $a0: unsigned int seed
    # Returns: void
    #
    # Frame:    []
    # Uses:     [$a0, $t0]
    # Clobbers: [$t0]
    #
    # Locals:
    # - $t0: offline_seed
    #
    # Structure:
    #   seed_rand

    li  $t0, OFFLINE_SEED # const unsigned int offline_seed = OFFLINE_SEED;
    xor $t0, $a0          # random_seed = seed ^ offline_seed;
    sw  $t0, random_seed

    jr  $ra               # return;

########################################################################
# .TEXT <rand>
.text

# DO NOT CHANGE THIS FUNCTION

rand:
    # Args:
    #   - $a0: unsigned int n
    # Returns:
    #   - $v0: int
    #
    # Frame:    []
    # Uses:     [$a0, $v0, $t0]
    # Clobbers: [$v0, $t0]
    #
    # Locals:
    #   - $t0: random_seed
    #
    # Structure:
    #   rand

    lw      $t0, random_seed # unsigned int rand = random_seed;
    multu   $t0, 0x5bd1e995  # rand *= 0x5bd1e995;
    mflo    $t0
    addiu   $t0, 12345       # rand += 12345;
    sw      $t0, random_seed # random_seed = rand;

    remu    $v0, $t0, $a0    #    rand % n
    jr      $ra              # return rand % n;