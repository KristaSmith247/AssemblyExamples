# Author: Krista Smith
# Date: 11/29/23
# Description: The program will create nested procedures.

# Prompt for two floats, add them together, display results
# use macros to print strings, floats, chars

.macro print_str(%str)
# macro to print a string
 	li $v0, 4
 	la $a0, %str # set up argument
 	syscall
.end_macro

.macro print_float(%float)
# macro to print a float
	li $v0, 2
	mov.s $f12, %float # set up argument
	syscall
.end_macro

.macro print_char(%char)
# macro to print a char
	li $v0, 11
	li $a0, %char # give hex/ascii value for char to print, so load immediate
	syscall
.end_macro

# declare functions
.globl main, prompt_floats, add_numbers, mult_numbers, print_answer

# data segment with memory labels
.data
greeting: .asciiz "Welcome to Calculators 'R Us!\n\n"
close: .asciiz "\n\nThanks and have a great Christmas!"
prompt1: .asciiz "Please enter a number: "
prompt2: .asciiz "Enter another number: "
newline: .asciiz "\n"


# text segment with source code
.text
# main
main:
	# greeting
	print_str(greeting)
	
	# prompt for 2 floats
	jal prompt_floats
	
	# add floats
	# set up the plus sign
	li $s0, 0x2B
	jal add_numbers
	
	# display results
	#jal print_answer
	li $v0, 4
	la $a0, newline
	syscall
	
	# multiply the floats and print results
	# set up multiplication sign
	li $s0, 0x2A
	jal mult_numbers
	
end_main:
# graceful close
	print_str(close)
	
# clean exit
	li $v0, 10
	syscall

################################################################
# procedure to print the answer
# printAnswer(num1, num2, symbol, answer){
# 	print (num1 + num2 = answer)
# }
# registers:
# f20 = num1
# f21 = num2
# f22 = answer
# s0 = symbol (+ sign, 0x2B) ( = sign, 0x3D) (space 0x20)
print_answer:
	# print num1 - f20
	print_float($f20)
	print_char(0x20) # space
	
	# print +
	#print_char(0x2B)
	li $v0, 11
	move $a0, $s0
	syscall
	
	print_char(0x20) # space
	
	# print num2 - f21
	print_float($f21)
	print_char(0x20) #space
	
	# print = 
	print_char(0x3D)
	print_char(0x20) # space
	
	# print answer - f22
	print_float($f22)
	
end_print_answer:
	jr $ra # jump back
# end procedure printAnswer
###############################################################


###############################################################
# procedure to prompt for floats
# promptFloats() {
# 	input num1
# 	input num2
# }
# Registers: 
# f20 = num1
# f21 = num2
prompt_floats:
	
	# prompt for num1
	print_str(prompt1)
	
	# read num1
	li $v0, 6 # read a float
	syscall
	mov.s  $f20, $f0 # move input to f20
	
	# prompt for num2
	print_str(prompt2)
	
	# read num2
	li $v0, 6 # read a float
	syscall
	mov.s  $f21, $f0 # move input to f21
	
end_prompt_floats:
	jr $ra # jump back
# end procedure promptFloats
###############################################################


###############################################################
# procedure to add the floats
# addNumbers(num1, num2) {
#	answer = num1 + num2
# }
#
# Registers: 
# f20 = num1
# f21 = num2
# f22 = answer
add_numbers:
	# save some registers
	subu $sp, $sp, 32 # set frame size
	sw $ra, 28($sp) # preserve return address (ra)
	sw $fp, 24($sp) # preserve frame pointer
	sw $s0, 20($sp) # preseve a0 # CHANGED THIS
	swc1 $f20, 16($sp) # preserve f20, if necessary
	swc1 $f21, 12($sp) # preserve f21, if necessary
	#sw $f22, 8($sp) # preserve f22, if necesary
	addu $fp, $sp, 32 # move the frame pointer back
	
	
	# num1 + num2 = answer
	add.s $f22, $f20, $f21
	
	# call print_answer
	jal print_answer
	
end_add_numbers:
	# restore registers
	lw $ra, 28($sp) # restore ra
	lw $fp, 24($sp) # restore fp
	# restore a0, f20, f21, f22
	lw $s0, 20($sp)
	lwc1 $f20, 16($sp)
	lwc1 $f21, 12($sp)
	#lw $f22, 8($sp)
	
	jr $ra # jump back
# end procedure addNumbers
##############################################################

###############################################################
# procedure to multiply the floats
# addNumbers(num1, num2) {
#	answer = num1 * num2
# }
#
# Registers: 
# f20 = num1
# f21 = num2
# f22 = answer
mult_numbers:
	# save some registers
	subu $sp, $sp, 32 # set frame size
	sw $ra, 28($sp) # preserve return address (ra)
	sw $fp, 24($sp) # preserve frame pointer
	sw $s0, 20($sp) # preseve a0 # CHANGED THIS
	swc1 $f20, 16($sp) # preserve f20, if necessary
	swc1 $f21, 12($sp) # preserve f21, if necessary
	#sw $f22, 8($sp) # preserve f22, if necesary
	addu $fp, $sp, 32 # move the frame pointer back
	
	
	# num1 * num2 = answer
	mul.s $f22, $f20, $f21
	
	
	# call print_answer
	jal print_answer
	
end_mult_numbers:
	# restore registers
	lw $ra, 28($sp) # restore ra
	lw $fp, 24($sp) # restore fp
	# restore a0, f20, f21, f22
	lw $s0, 20($sp)
	lwc1 $f20, 16($sp)
	lwc1 $f21, 12($sp)
	#lw $f22, 8($sp)
	
	jr $ra # jump back
# end procedure multNumbers
##############################################################