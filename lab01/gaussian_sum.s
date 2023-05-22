main:

la      $a0, string
li      $v0, 4
syscall

li      $v0, 5
syscall
move    $t1, $v0         # number 1 = t1


la      $a0, string_1
li      $v0, 4
syscall

li      $v0, 5
syscall
move    $t2, $v0          # number 2 = t2


sub     $t3, $t2, $t1
addi    $t3, $t3, 1

add     $t4, $t1, $t2
  
mult    $t3, $t4		# $t0 * $t1 = Hi and Lo registers
mflo    $t5		        # copy Lo to $t2

li      $t6, 2

div     $t5, $t6			# $t0 / $t1
mflo	$t7				# $t2 = floor($t0 / $t1) 

la      $a0, string_2
li      $v0, 4
syscall

move    $a0, $t1
li      $v0, 1
syscall

la      $a0, string_3
li      $v0, 4
syscall

move    $a0, $t2
li      $v0, 1
syscall

la      $a0, string_4
li      $v0, 4
syscall

move    $a0, $t7
li      $v0, 1
syscall

li      $a0, '\n'    # printf("%c", '\n');
li      $v0, 11
syscall

li      $v0, 0      # return 0
jr      $ra


        .data
string:
        .asciiz "Enter first number: "
string_1:
        .asciiz "Enter second number: "
string_2:
        .asciiz "The sum of all numbers between "
string_3:
        .asciiz " and "
string_4:
        .asciiz " (inclusive) is: "
