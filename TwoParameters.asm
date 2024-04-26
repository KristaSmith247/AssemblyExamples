# Author: Krista Smith
# Date: 10/18/23
# Description: The program will create a procedure with two parameters and a return,
#	read in two ints, add them together with a  procedure,
#	print results

.macro print_str(%string)
	li $v0, 4
	la $a0, %string
	syscall
.end_macro


# global directive
.globl main # list of procedures


.data
greeting: .asciiz "Welcome to my Adding Calculator.\n" # greeting
close: .asciiz "\nThanks and have a great weekend." # close
prompt1: .asciiz "\nPlease enter an integer: " # prompt for num1
prompt2: .asciiz "\nPlease enter a second integer: " # prompt for num2
display: .asciiz "\nThe sum is " # display for answer
.text

main:
# pseudocode:
# write a procedure to add two numbers and return sum
# display sum
# test with hard-coded values


# greeting
	print_str(greeting)
# hard code two integers
	# load arguments
	li $a0, 10
	li $a1, 15
	jal add_two # call procedure to add them
	
	move $s0, $v0 # return value is in v0, moved to s0
# print the return value
	# print answer
	print_str(display) 	# print display

	li $v0, 1 	# print int
	move $a0, $s0
	syscall

# prompt for 2 ints, add them and display the sum
	print_str(prompt1)
	# read an int
	li $v0, 5
	syscall
	# move the return value into argument
	move $t2, $v0 # move int to t0

	print_str(prompt2)
	# read an int
	li $v0, 5
	syscall
	# move the return value into argument
	move $t3, $v0 # move int to t1
	
	# set up arguments for procedure
	move $a0, $t2
	move $a1, $t3
	jal add_two # call procedure
	
	move $s0, $v0 	# capture the return value
	print_str(display)
	
	# print the sum
	li $v0, 1
	move $a0, $s0
	syscall
	
end_main:
	# graceful close
	print_str(close)
	
	# clean exit
	li $v0, 10
	syscall
	
	
# Procedure AddTwo(int num1, int num2)
#	int total = num1 + num2
#	return total
#
# Register mapping:
# a0 = num1
# a1 - num2
# Return:
# v0 = total
add_two:
	# get in the habit of moving arguments into temp registers
	move $t0, $a0 # move a0 into t0
	move $t1, $a1 # move a1 into t1
	
	# add ints together, store in return register
	add $v0, $t0, $t1
	
end_add_two:
	jr $ra # jump back