# Author: Krista Smith
# Date: 10/4/23
# Description: The program will use a loop to "parrot" a user's input

.data
intro: .asciiz "Say something to the parrot and it will say it back!\n" # friendly greeting
prompt: .asciiz "\nYou say: " # prompt for input
parrot: .asciiz "Parrot says: " # parrot
close: .asciiz "\nThanks and I'm glad there was no emergency" # graceful close
input: .space 256 # save space for 255 characters + one null terminator



.text
# Pseudocode
# print introduction
# hardcode the number of times to loop (again)
# while (i != again) {
#	print (prompt)
#	read input
# 	print(parrot)
# 	print (input)
# } // end while
# print (graceful close)
# clean exit	

# Registers used: 
# i - t0
# again - t1
# input buffer - a1


# print introduction
	li $v0, 4
	la $a0, intro
	syscall

# hardcode the number of times to loop (again)
# set i = 0
	li $t0, 0 # i = 0
	li $t1, 3 # again = 3
	li $a1, 256 # set input buffer size to 256 to read a string
	

loop:
	# if (t0 == t1) break out of loop - jump to endloop
	beq $t0, $t1, endloop
	
#	print (prompt)
	li $v0, 4
	la $a0, prompt
	syscall
	
#	read input
	li $v0, 8 # read string
	la $a0, input # address to store the read
	syscall
	
# 	print(parrot)
	li $v0, 4
	la $a0, parrot
	syscall
	
# 	print (input)
	li $v0, 4
	la $a0, input
	syscall
	
# 	increment i (by 1 because it isn't a word)
	addi $t0, $t0, 1
#	jump to loop
	j loop


endloop:

exit:
# print (graceful close)
	li $v0, 4
	la $a0, close
	syscall

# clean exit
	li $v0, 10
	syscall