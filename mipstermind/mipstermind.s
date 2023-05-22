########################################################################
# COMP1521 22T1 -- Assignment 1 -- Mipstermind!
#
#
# !!! IMPORTANT !!!
# Before starting work on the assignment, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
# Instructions to configure your text editor can be found here:
#   https://cgi.cse.unsw.edu.au/~cs1521/22T1/resources/mips-editors.html
# !!! IMPORTANT !!!
#
#
# This program was written by YOUR-NAME-HERE (z5555555)
# on INSERT-DATE-HERE
#
# Version 1.0 (28-02-22): Team COMP1521 <cs1521@cse.unsw.edu.au>
#
########################################################################

#![tabsize(8)]

# Constant definitions.
# DO NOT CHANGE THESE DEFINITIONS

TURN_NORMAL = 0
TURN_WIN    = 1
NULL_GUESS  = -1

########################################################################
# .DATA
# YOU DO NOT NEED TO CHANGE THE DATA SECTION
.data

# int correct_solution[GUESS_LEN];
.align 2
correct_solution:	    .space GUESS_LEN * 4

# int current_guess[GUESS_LEN];
.align 2
current_guess:		    .space GUESS_LEN * 4

# int solution_temp[GUESS_LEN];
.align 2
solution_temp:		    .space GUESS_LEN * 4


guess_length_str:	    .asciiz "Guess length:\t"
valid_guesses_str:	    .asciiz "Valid guesses:\t1-"
number_turns_str:	    .asciiz "How many turns:\t"
enter_seed_str:		    .asciiz "Enter a random seed: "
you_lost_str:		    .asciiz "You lost! The secret codeword was: "
turn_str_1:		        .asciiz "---[ Turn "
turn_str_2:		        .asciiz " ]---\n"
enter_guess_str:	    .asciiz "Enter your guess: "
you_win_str:		    .asciiz "You win, congratulations!\n"
correct_place_str:	    .asciiz "Correct guesses in correct place:   "
incorrect_place_str:	.asciiz "Correct guesses in incorrect place: "

############################################################
####                                                    ####
####   Your journey begins here, intrepid adventurer!   ####
####                                                    ####
############################################################


########################################################################
#
# Implement the following 8 functions,
# and check these boxes as you finish implementing each function
#
#  - [X] main
#  - [X] play_game
#  - [X] generate_solution
#  - [X] play_turn
#  - [X] read_guess
#  - [X] copy_solution_into_temp
#  - [X] calculate_correct_place
#  - [X] calculate_incorrect_place
#  - [X] seed_rand  (provided for you)
#  - [X] rand       (provided for you)
#
########################################################################


########################################################################
# .TEXT <main>
.text
main:
	# Args:     void
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [$v0, $a0]
	# Clobbers: [$v0, $a0]
	#
	# Locals:
	#   - []
	#
	# Structure:
	#   main
	#   -> [prologue]
	#   -> body
	#   -> seed_rand
	#   -> play_game
	#   -> [epilogue]
    

main__prologue:
	begin                   # begin a new stack frame
	push    $ra             # | $ra

main__body:
        # printf("Guess length: %d\n", GUESS_LEN);
	li      $v0, 4          # syscall 4: print_string
	la      $a0, guess_length_str
	syscall                 # printf("Guess length: ");

	li      $v0, 1          # syscall 1: print_int
	li      $a0, GUESS_LEN
	syscall                 # printf("%d", GUESS_LEN);

	li      $v0, 11         # syscall 11: print_char
	li      $a0, '\n'
	syscall                 # printf("\n");


        # printf("Valid guesses: 1-%d\n", GUESS_CHOICES);
	li      $v0, 4          # syscall 4: print_string
	la      $a0, valid_guesses_str
	syscall                 # printf("Valid guesses: 1-");

	li      $v0, 1          # syscall 1: print_int
	li      $a0, GUESS_CHOICES
	syscall                 # printf("%d", GUESS_CHOICES);

	li      $v0, 11         # syscall 11: print_char
	li      $a0, '\n'
	syscall                 # printf("\n");


	# printf("Number of turns: %d\n\n", MAX_TURNS);
	li      $v0, 4          # syscall 4: print_string
	la      $a0, number_turns_str
	syscall                 # printf("Number of turns: ");

	li      $v0, 1          # syscall 1: print_int
	li      $a0, MAX_TURNS
	syscall                 # printf("%d", MAX_TURNS);

	li      $v0, 11         # syscall 11: print_char
	li      $a0, '\n'
	syscall                 # printf("\n");
	syscall                 # printf("\n");

	#  TODO ... complete this function
	la      $a0, enter_seed_str      # printf("Enter a random seed: ");
	li      $v0, 4
	syscall
	li      $v0, 5          # scanf("%d", &random_seed);
	syscall                 #
	move    $a0, $v0
	jal     seed_rand
	jal     play_game

main__epilogue:
	pop     $ra               # | $ra
	end                       # ends the current stack frame

	li      $v0, 0
	jr      $ra               # return 0;




########################################################################
# .TEXT <play_game>
.text
play_game:
	# Args:     void
	# Returns:  void
	#
	# Frame:    [$ra]
	# Uses:     [$v0, $a0, $t0, $t1, $t2, $t3, $t4]
	# Clobbers: [$v0, $a0, $t0, $t1, $t2, $t3, $t4]
	#
	# Locals:
	#   - ['turn' in $a0]
	#   - ['i' in $t0]
	#   - ['turn_status' in $t1]
	#
	# Structure:
	#   play_game
	#   -> [prologue]
	#   -> body
	#   -> generate_solution
	#      ->rand
	#   -> play_turn
	#      -> read_guess
	#      -> copy_solution_into_temp
	#      -> calculate_correct_place
	#      -> calculate_incorrect_place
	#   -> [epilogue]

play_game__prologue:
        begin               # begin a new stack frame
        push    $ra         # | $ra

play_game__body:
    # TODO ... complete this function
        jal     generate_solution        # generate_solution();
        li      $a0, 0                   # int turn = 0
        la      $t0, MAX_TURNS

game_loop0:
        bge	$a0, $t0, lose           # if  turn >= MAX_TURNS

        jal     play_turn                # play_turn(turn)   
 
        move    $t1, $v0                 # int turn_status = play_turn(turn);
        la      $t2, TURN_WIN
        beq	$t1, $t2, play_game__epilogue         # if (turn_status == TURN_WIN)
        addi    $a0, $a0, 1              # turn ++
        b       game_loop0

lose:
        li      $v0, 4                   # syscall 4: print_string
        la      $a0, you_lost_str
        syscall                          # printf("You lost! The secret codeword was: ");

        li      $t0, 0                   # int i = 0
        la      $t2, GUESS_LEN

game_loop1:
        bge	$t0, $t2, game_end0      # i < GUESS_LEN

        mul     $t3, $t0, 4              # correct_solution[i]
        la      $t4, correct_solution        
        add     $t4, $t4, $t3         
        lw      $a0, 0($t4)              # store entered number in array
        li      $v0, 1                   # printf("%d ", correct_solution[i])
        syscall
	    li      $a0, ' '                 # printf("%c", '\n');
        li      $v0, 11
        syscall
        addi    $t0, $t0, 1              # i ++
        b       game_loop1

game_end0:
        li      $a0, '\n'                # printf("%c", '\n');
        li      $v0, 11
        syscall

play_game__epilogue:
        pop     $ra         # | $ra
        end                 # ends the current stack frame
        jr      $ra         # return;




########################################################################
# .TEXT <generate_solution>
.text
generate_solution:
	# Args:     void
	# Returns:  void
	#
	# Frame:    [$ra, $s0]
	# Uses:     [$v0, $a0, $t1, $t2, $t3, $t4, $s0]
	# Clobbers: [$v0, $a0, $t1, $t2, $t3, $t4]
	#
	# Locals:
	#   - ['i' in $s0]
	#
	# Structure:
	#   generate_solution
	#   -> [prologue]
	#   -> generate_solution_body
	#      -> rand  
	#   -> [epilogue]

generate_solution__prologue:
	begin                        # begin a new stack frame
	push    $ra                  # | $ra
	push    $s0
initial_value:
    li      $s0, 0               # int i = 0
    la      $t1, GUESS_LEN

generate_solution__body:
        # TODO ... complete this function
    bge     $s0, $t1, generate_solution__epilogue
    
	la      $a0, GUESS_CHOICES
	jal     rand                 # rand(GUESS_CHOICES)
	addi    $v0, $v0, 1          # rand(GUESS_CHOICES) + 1;
	move    $t2, $v0

	mul     $t3, $s0, 4
	la      $t4, correct_solution 
	add     $t3, $t4, $t3        #
	sw      $t2, ($t3)           #  correct_solution[i] = rand(GUESS_CHOICES) + 1;

	addi    $s0, $s0, 1          # i ++
	b       generate_solution__body

generate_solution__epilogue:
	pop     $s0
	pop     $ra         # | $ra
	end                 # ends the current stack frame
	jr      $ra         # return;




########################################################################
# .TEXT <play_turn>
.text
play_turn:
	# Args:
	#   - $a0: int
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra, $s0, $s1, $s2, $a0]
	# Uses:     [$v0, $s0, $s1, $s2, $a0]
	# Clobbers: [$v0]
	#
	# Locals:
	#   - []
	
	#
	# Structure:
	#   play_turn
	#   -> [prologue]
	#   -> play_turn_body
	#   -> read_guess
	#   -> copy_solution_into_temp
	#   -> calculate_correct_place
	#   -> calculate_incorrect_place
	#   -> epilogue/game_lose
	#   -> [epilogue]

play_turn__prologue:
	begin                         # begin a new stack frame
	push    $ra       
	push    $s0
	push    $s1
	push    $s2
	push    $a0
play_turn__body:
    # TODO ... complete this function
	move    $s0, $a0   
	li      $v0, 4                # syscall 4: print_string
	la      $a0, turn_str_1
	syscall                       # printf("---[ Turn");

	addi    $a0, $s0, 1           # rand(GUESS_CHOICES) + 1;
	li      $v0, 1                # printf("%d",turn + 1)
	syscall

	li      $v0, 4                # syscall 4: print_string
	la      $a0, turn_str_2
	syscall                       # printf("]--\n");
	li      $v0, 4                # syscall 4: print_string
	la      $a0, enter_guess_str
	syscall                       # printf("Enter your guess: ");

	jal     read_guess
	jal     copy_solution_into_temp

	jal     calculate_correct_place
	move    $s0, $v0                   # int correct_place = calculate_correct_place();
	jal     calculate_incorrect_place
	move    $s1, $v0                   # int incorrect_place = calculate_incorrect_place();
	
	la      $s2, GUESS_LEN
	bne	$s0, $s2, game_lose        # if (correct_place == GUESS_LEN)
	
	li      $v0, 4                     # syscall 4: print_string
	la      $a0, you_win_str
	syscall                            # printf("You win, congratulations!\n");

	la      $v0, TURN_WIN              # return TURN_WIN;
	b       play_turn__epilogue    

game_lose:
	li      $v0, 4                     # syscall 4: print_string
	la      $a0, correct_place_str        
	syscall                            # printf("Correct guesses in correct place:   ");
	move    $a0, $s0                      
	li      $v0, 1                     # printf("%d", correct_place)
	syscall
	li      $a0, '\n'                  # printf("%c", '\n');
	li      $v0, 11
	syscall

	li      $v0, 4                     # syscall 4: print_string
	la      $a0, incorrect_place_str
	syscall                            # printf("Correct guesses in incorrect place: ");
	move    $a0, $s1                      
	li      $v0, 1                     # printf("%d", incorrect_place)
	syscall
	li      $a0, '\n'                  # printf("%c", '\n');
	li      $v0, 11
	syscall
	la      $v0, TURN_NORMAL           # return TURN_NORMAL;

play_turn__epilogue:
	pop     $a0         # | $a0
	pop     $s2         # | $s2
	pop     $s1         # | $s1
	pop     $s0         # | $s0
	pop     $ra         # | $ra
	end                 # ends the current stack frame
	jr      $ra         # return;



########################################################################
# .TEXT <read_guess>
.text
read_guess:
	# Args:     void
	# Returns:  void
	#
	# Frame:    [$ra, $s0, $s1, $s2, $s3]
	# Uses:     [$v0, $s0, $s1, $s2, $s3]
	# Clobbers: [$v0]
	#
	# Locals:
	#   - ['int n_guess' in $s0]
	#   - ['int guess' in $v0]
	#
	# Structure:
	#   read_guess
	#   -> [prologue]
	#   -> read_guess__body
	#   -> read_loop0
	#   -> [epilogue]

read_guess__prologue:
	begin                   # begin a new stack frame
	push    $ra       
	push    $s0
	push    $s1
	push    $s2
	push    $s3
read_guess__body:
	# TODO ... complete this function
	li	$s0, 0		# int n_guess = 0
	la	$s1, GUESS_LEN

read_loop0:
    bge	$s0, $s1, read_guess__epilogue		# n_guess < GUESS_LEN
	li      $v0, 5          #   scanf("%d", &guess);
    syscall                 #

	mul  	$s2, $s0, 4     #   calculate &current_guess[n_guess]
	la   	$s3, current_guess  
	add  	$s3, $s3, $s2   #
	sw   	$v0, ($s3)      #   store entered number in current_guess[n_guess]

    addi    $s0, $s0, 1     # n_guess++
	b	read_loop0
read_guess__epilogue:
	pop	$s3         # | $s3
    pop     $s2         # | $s2
	pop     $s1         # | $s1
	pop     $s0         # | $s0
	pop     $ra         # | $ra
	end                 # ends the current stack frame
	jr      $ra         # return;
       





########################################################################
# .TEXT <copy_solution_into_temp>
.text
copy_solution_into_temp:
	# Args:     void
	# Returns:  void
	#
	# Frame:    [$ra, $s0, $s1, $s2, $s3, $s4]
	# Uses:     [$s0, $s1, $s2, $s3, $s4]
	# Clobbers: []
	#
	# Locals:
	#   - ['int i' in $s0]
	#
	# Structure:
	#   copy_solution_into_temp
	#   -> [prologue]
	#   -> copy_solution_into_temp__body
	#   -> copy_solution_loop0
	#   -> [epilogue]

copy_solution_into_temp__prologue:
	begin                   # begin a new stack frame
	push    $ra       
	push    $s0
	push    $s1
	push    $s2
	push    $s3
        push	$s4
copy_solution_into_temp__body:
	# TODO ... complete this function
	li	$s0, 0          # int i = 0
	la	$s1, GUESS_LEN

copy_solution_loop0:
    bge	$s0, $s1, copy_solution_into_temp__epilogue     # i < GUESS_LEN

    mul  	$s2, $s0, 4     #   calculate correct_solution[i]
	la   	$s3, correct_solution  
	add  	$s3, $s3, $s2   #
	lw   	$s4, ($s3)      #   get correct_solution[i]

    mul  	$s2, $s0, 4     #   calculate solution_temp[i]
	la   	$s3, solution_temp
	add  	$s3, $s3, $s2   #
	sw   	$s4, ($s3)      #   get solution_temp[i]

	addi    $s0, $s0, 1     # i++
	b	copy_solution_loop0
copy_solution_into_temp__epilogue:
	pop	$s4         # | $s4
	pop	$s3         # | $s3
    pop     $s2         # | $s2
	pop     $s1         # | $s1
	pop     $s0         # | $s0
	pop     $ra         # | $ra
	end                 # ends the current stack frame
	jr      $ra         # return;




########################################################################
# .TEXT <calculate_correct_place>
.text
calculate_correct_place:
	# Args:     void
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra, $s0, $s1, $s2, $s3, $s4, $s5, $s6]
	# Uses:     [$s0, $s1, $s2, $s3, $s4, $s5, $s6, $v0]
	# Clobbers: [$v0]
	#
	# Locals:
	#   - ['int total' in $s0]
	#   - ['int guess_index' in $s2]
	#   - ['int guess' in $s5]
	#
	# Structure:
	#   calculate_correct_place
	#   -> [prologue]
	#   -> calculate_correct_place__body
	#   -> calculate_correct_loop0
	#   -> guess_sloution_equal
	#   -> calculate_correct_loop0
	#   -> [epilogue]

calculate_correct_place__prologue:
	begin                   # begin a new stack frame
	push    $ra       
	push    $s0
	push    $s1
	push    $s2
	push    $s3
    push	$s4
    push    $s5
	push    $s6
calculate_correct_place__body:
	# TODO ... complete this function
    li	$s0, 0          # int total = 0
	la	$s1, GUESS_LEN 
	li 	$s2, 0		# int guess_index = 0 
	
calculate_correct_loop0:
	bge	    $s2, $s1, calculate_correct_place__epilogue     # guess_index < GUESS_LEN
        
	mul  	$s3, $s2, 4     # current_guess[guess_index]
	la   	$s4, current_guess
	add  	$s3, $s4, $s3   #
	lw   	$s5, ($s3)      # int guess = current_guess[guess_index]

	mul  	$s3, $s2, 4     # solution_temp[guess_index]
	la   	$s4, solution_temp
	add  	$s3, $s4, $s3   #
	lw   	$s6, ($s3)      # get solution_temp[guess_index]

guess_sloution_equal:
    bne	$s6, $s5, guess_sloution_end0
	addi    $s0, $s0, 1     # total++;
	la      $s4, NULL_GUESS

	mul  	$s3, $s2, 4     #
	la   	$s5, current_guess
	add  	$s5, $s5, $s3   # current_guess[guess_index]
	sw   	$s4, ($s5)      # current_guess[guess_index] = NULL_GUESS;

	la   	$s5, solution_temp
	add  	$s5, $s5, $s3   # solution_temp[guess_index]
	sw   	$s4, ($s5)      # solution_temp[guess_index] = NULL_GUESS;

guess_sloution_end0:
	addi    $s2, $s2, 1     # guess_index ++
	b	calculate_correct_loop0	

calculate_correct_place__epilogue:
    move    $v0, $s0    # return total;
	pop	    $s6         # | $s6
	pop     $s5         # | $s5
	pop	    $s4         # | $s4
	pop	    $s3         # | $s3
    pop     $s2         # | $s2
	pop     $s1         # | $s1
	pop     $s0         # | $s0
	pop     $ra         # | $ra
	end                 # ends the current stack frame
	jr      $ra         # return;



########################################################################
# .TEXT <calculate_incorrect_place>
.text
calculate_incorrect_place:
	# Args:     void
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra, $s0, $s1, $s2, $s3, $s4, $s5, $s6]
	# Uses:     [$s0, $s1, $s2, $s3, $s4, $s5, $s6, $t5, $t6, $t7, $t8, $v0]
	# Clobbers: [$t5, $t6, $t7, $t8, $v0]
	#
	# Locals:
	#   - ['int total' in $s0]
	#   - ['int guess_index' in $s2]
	#   - ['int guess' in $s5]
	#   - ['int solution_index' in $t5]
	#
	# Structure:
	#   calculate_incorrect_place
	#   -> [prologue]
	#   -> calculate_incorrect_place__body
	#   -> calculate_incorrect_loop0
	#   -> guess_equal_loop0
	#   -> incorrect_end1 / incorrect_end0
        #   -> guess_equal_loop0 / calculate_incorrect_loop0
	#   -> [epilogue]

calculate_incorrect_place__prologue:
	begin                   # begin a new stack frame
	push    $ra       
	push    $s0
	push    $s1
	push    $s2
	push    $s3
	push	$s4
	push    $s5
	push    $s6
calculate_incorrect_place__body:
	# TODO ... complete this function
    li	$s0, 0		# int total = 0
	la	$s1, GUESS_LEN 
	li 	$s2, 0		# int guess_index = 0 

calculate_incorrect_loop0:
	bge	$s2, $s1, calculate_incorrect_place__epilogue     # guess_index < GUESS_LEN

	mul  	$s3, $s2, 4     # current_guess[guess_index]
	la   	$s4, current_guess
	add  	$s3, $s4, $s3   #
	lw   	$s5, ($s3)      # int guess = current_guess[guess_index]

    la	$s6, NULL_GUESS
	beq	$s5, $s6, incorrect_end0	# if (guess != NULL_GUESS)
        
	li	$t5, 0		# int solution_index = 0

guess_equal_loop0:
	bge	$t5, $s1, incorrect_end0	# solution_index < GUESS_LEN	

	mul  	$t6, $t5, 4     # solution_temp[solution_index]
	la   	$t7, solution_temp
	add  	$t7, $t6, $t7   #
	lw   	$t8, ($t7)      # get solution_temp[solution_index] in $t8

	bne	$t8, $s5, incorrect_end1	# solution_temp[solution_index] == guess
	addi    $s0, $s0, 1     # total++;
	sw	$s6, ($t7)	# solution_temp[solution_index] = NULL_GUESS;
        b	incorrect_end0

incorrect_end1:
	addi    $t5, $t5, 1     # solution_index ++
	b       guess_equal_loop0

incorrect_end0:
	addi    $s2, $s2, 1     # guess_index ++
	b	calculate_incorrect_loop0	

calculate_incorrect_place__epilogue:
	move	$v0, $s0
	pop	$s6         # | $s6
	pop     $s5         # | $s5
	pop	$s4         # | $s4
	pop	$s3         # | $s3
        pop     $s2         # | $s2
	pop     $s1         # | $s1
	pop     $s0         # | $s0
	pop     $ra         # | $ra
	end                 # ends the current stack frame
	jr      $ra         # return;




########################################################################
####                                                                ####
####        STOP HERE ... YOU HAVE COMPLETED THE ASSIGNMENT!        ####
####                                                                ####
########################################################################

##
## The following are two utility functions, provided for you.
##
## You don't need to modify any of the following.
## But you may find it useful to read through.
## You'll be calling these functions from your code.
##


########################################################################
# .DATA
# DO NOT CHANGE THIS DATA SECTION
.data

# int random_seed;
.align 2
random_seed:		.space 4


########################################################################
# .TEXT <seed_rand>
# DO NOT CHANGE THIS FUNCTION
.text
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

	li	$t0, OFFLINE_SEED # const unsigned int offline_seed = OFFLINE_SEED;
	xor	$t0, $a0          # random_seed = seed ^ offline_seed;
	sw	$t0, random_seed

	jr      $ra               # return;




########################################################################
# .TEXT <rand>
# DO NOT CHANGE THIS FUNCTION
.text
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
	# - $t0: random_seed
	#
	# Structure:
	#   rand

	lw	$t0, random_seed  # unsigned int rand = random_seed;
	multu	$t0, 0x5bd1e995   # rand *= 0x5bd1e995;
	mflo	$t0
	addiu	$t0, 12345        # rand += 12345;
	sw	$t0, random_seed  # random_seed = rand;

	remu	$v0, $t0, $a0     # rand % n
	jr	$ra               # return;
