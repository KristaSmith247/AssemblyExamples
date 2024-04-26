# Name : Krista Smith
# Date : 9/11/23
# Description : The program will add two numbers together and display their sum.

# data segment
.data
display: .asciiz "The sum is "

# text segment
.text
	# add 4 and 8, store sum in $t3, print results
	
	li $t0, 4	# load 4 into $t0
	li $t1, 8	# load 8 into $t1
	
	add $t3, $t0, $t1	# add $t0, $t1, store in $t3
	
	# print string
	li $v0, 4	# print the string
	la $a0, display # set the argument
	syscall
	
	# print the results
	li $v0, 1	# load register 1 to print an integer
	move $a0, $t3	# move data from $t3 to $a0
	syscall 	# print results
	
	# exit the program
	li $v0, 10
	syscall