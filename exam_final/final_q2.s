# given one integer value return the right justified version of the value.
# right-justification is (in this case)
# the process of removing all zeros from the right side of the value
# eg:
# given  (in $a0) 0b00000000000000000000000001101000
# return (in $v0) 0b00000000000000000000000000001101

.text
.globl final_q2

final_q2:
    # YOU DO NOT NEED TO CHANGE THE LINES ABOVE HERE

    # REPLACE THIS LINE WITH YOUR CODE


    move    $v0, $a0    # return argument unchanged
    beq	 $v0, $zero, end1
    li   $t2, 1
    li   $t3, 1
loop: 
    and  $t1, $v0, $t3
    beq	 $t2, $t1, end1
    srl  $v0, $v0, 1

    j    loop

end1:
    jr  $ra
# ADD ANY EXTRA FUNCTIONS BELOW THIS LINE
