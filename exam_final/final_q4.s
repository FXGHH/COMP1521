# return the number of peaks in an array of integers
#
# A peak is a value that is both preceded and succeeded
# by a value smaller than itself
#
# ie:
# Both the value before and the value after the current value
# are smaller than the current value
#
# eg:
# [1, 3, 2, 5, 4, 4, 9, 0, 1, -9, -5, -7]
#     ^     ^        ^     ^       ^
# The value 3, 5, 9, 1, -5 are all peaks in this array
# So your function should return 5

.text
.globl final_q4

final_q4:
	# YOU DO NOT NEED TO CHANGE THE LINES ABOVE HERE


	# REPLACE THIS LINE WITH YOUR CODE
	move	$t0, $a0	# array
	move	$t1, $a1	# length
    li  $t2, 0   # total = 0
	li  $t3, 1   #i = 1
	sub	$t1, $t1, $t3   # length -1 
loop0:
    bge	$t3, $t1, end1
    mul  $t4, $t3, 4 
	add  $t5, $t0, $t4  # array[i]
    lw   $t5, ($t5)       # array[i]

    addi $t6, $t3, 1
	mul  $t4, $t6, 4
    add  $t6, $t0, $t4  # array[i + 1]
    lw   $t6, ($t6)       # array[i + 1]

	li   $t7, 1
	sub	 $t7, $t3, $t7   
	mul  $t4, $t7, 4
    add  $t7, $t0, $t4  # array[i - 1]
    lw   $t7, ($t7)       # array[i - 1]

	ble	 $t5, $t7, end0
    ble	 $t5, $t6, end0
	addi $t2, $t2, 1
end0:
    addi $t3, $t3, 1
	j loop0
end1:
    move $v0, $t2
	jr	$ra


# ADD ANY EXTRA FUNCTIONS BELOW THIS LINE
