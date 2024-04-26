# Author: Krista Smith
# Date: 10/18/23
# Description: The program will demonstrate the creation and use of procedures.

.globl main, hello_world, hello_message # put the names of procedures in here <another segment/directive in Help>

.macro print_str(%string)
	# procedure to print a string
	li $v0, 4
	la $a0, %string
	syscall
.end_macro

.data
greeting: .asciiz "Hello, welcome to my procedures.\n" # greeting
hello: .asciiz "\nHello world! I am inside a procedure.\n" # display from inside procedure
newline: .asciiz "\n" # newline
close: .asciiz "\nCreating procedures is fun!" # graceful close 
message: .asciiz "\nHello. I am a parameter inside a procedure." # pass message into procedure as parameter
message1: .asciiz "\nHow fun! I am still a parameter to a procedure."


.text

main:

# Pseudocode:
# expanded format
# write procedure pseudocode
# create strings to print
# create procedure - begin and end labels
# write procedure operations
# call procedure from main

	# display greeting
	print_str(greeting)
	
	# jump to procedure
	jal hello_world # jal sets $ra to the address of the next instruction
	
	# jump to procedure - again
	jal hello_world
	
	# call the HelloMessage(message) procedure
	la $a0, message 	# set argument
	jal hello_message 	# call procedure
	
	# do it again with a different argument
	la $a0, message1	# set argument
	jal hello_message 	# call procedure
	
	
	
end_main:
	# graceful close
	print_str(close)
	
	# clean exit
	li $v0, 10
	syscall
	
# procedure - void HelloWorld()
#	print(hello world message)
#
# register mapping
# none
# return : none

hello_world:

	# print hello world
	print_str(hello)
	
end_hello_world:
	jr $ra # jump back
	

# Pseudocode: void HelloMessage(string message)
#	print(message)
#
# register mapping:
# a0 - string to print
# return: none
hello_message:

	li $v0, 4 # print string
	# la $a0, message # print message - this will be set before the jal
	syscall
	
	
end_hello_message:
	jr $ra # jump back