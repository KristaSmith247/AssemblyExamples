# Author : Krista Smith
# Date : 9/6/23
# Description : My first assembly program.


# data segment - variable and constants go here
.data
hello: .asciiz "Hello world! Welcome to CS 2810!"
message: .asciiz "\nHere's a second string."

# text segment - code goes here
.text

	# print hello
	
	li $v0, 4	# set up system to print a string
	la $a0, hello	# load print argument
	syscall		# print
	
	
	la $a0, message	# load message string into $a0
	syscall		# execute
	
	# add $s0 and $s1, store in $t1
	# add $s2 and $s3, store in $t2
	# subtract $t1 - $t2
	
	add $t0, $s0, $s1
	add $t1, $s2, $s3
	sub $s4, $t0, $t1
	
	# exit program section
	
	li $v0, 10	# set up program to exit
	syscall 	# exit program