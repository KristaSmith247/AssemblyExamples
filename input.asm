# Author: Krista Smith
# Date: 9/11/23
# Description: The program will take user input and perform operations with the input.

# data segment
.data
prompt: .asciiz "What is your favorite number? "
favNum: .word 0	# store the user's answer, initial value of 0
display: .asciiz "Your favorite number is "
display2: .asciiz "\nThe value after adding 2 is "
anotherNum: .asciiz "\nEnter another number: "
display3: .asciiz "\nIf your entered number was less than 50, your output will be 1."
display4: .asciiz "\nIf you entered a number greater than or equal to 50, your output will be 0."
display5: .asciiz "\nOutput: "

# text segment
.text

# ask for user input

	li $v0, 4 # print string	
	la $a0, prompt # load address of string to print
	syscall

# capture input
	li $v0, 5 # read an int
	syscall
	move $t0, $v0 # move input from $v0 to $t0

# add an immediate to input
	addi $t1, $t0, 2	# add 2 to input
	
# store the number in memory
	sw $t1, favNum	# store $t1 into favNum
		
# display input
	li $v0, 4	# print string
	la $a0, display # string to print
	syscall
	
	li $v0, 1	# print integer
	move $a0, $t0	# move value from $t0 to $a0
	syscall
	
# display number + 2
	li $v0, 4	# print string
	la $a0, display2
	syscall
			
	li $v0, 1	# print integer
	lw $a0, favNum  # set the argument with the int to print
	syscall

# prompt user for another number 

	li $v0, 4	# prompt for another number
	la $a0, anotherNum
	syscall
	
	li $v0, 5	# capture user input
	syscall
	move $t4, $v0	# move user input from $v0 to $t4
	
	# if the second input is less than an immediate : print value
	slti $t5, $t4, 50	# if the second input is less than 10, set $t5
	
	li $v0, 4		# display string 
	la $a0, display3
	syscall
	
	li $v0, 4		# display output explanation string
	la $a0, display4
	syscall
	
	li $v0, 4		# display output explanation string
	la $a0, display5
	syscall
	
	li $v0, 1		# print out answer of either 0 or 1
	la $a0, ($t5)
	syscall
	
# clean exit
	li $v0, 10
	syscall