# TempConversions.asm
# Author: Krista Smith
# Date: 10/23/23
# Decription: Convert Fahrenheit and Celsius temperatures - single precision

# macros
# print str, char, floats
# str and char use $a0 argument
# print to the $a0 argument
.macro printA(%info, %type)
	la $a0, %info
	la $v0, %type
	syscall
.end_macro

# print strings
.macro print_str(%string)
	printA(%string, 4)
.end_macro

# print char
.macro print_char(%char)
	printA(%char, 11)
.end_macro

# read a char
.macro read_char()
	li $v0, 12
	syscall
.end_macro

# float use $f12 argument
.macro printF(%info, %type) # template for anything that uses f12 as an argument
	mov.s $f12, %info
	li $v0, %type
	syscall
.end_macro


.macro print_float(%float)
	printF(%float, 2)
.end_macro


.macro read_float()
	li $v0, 6
	syscall
	# move from f0
.end_macro


# declare the procedures
.globl main, convert_to_cel, convert_to_far, print_answer

# labels
.data
greeting: .asciiz "Welcome to Temperatures 'R Us\n" # greeting
close: .asciiz "Thanks and have a great snow day." # close

farPrompt: .asciiz "\nEnter the Fahrenheit temperature to convert: " # prompt for Fahrenheit
celPrompt: .asciiz "\nEnter the Celsius temperature to convert: " # prompt for Celsius
typePrompt: .asciiz "\nPress C to convert to Celsius. Press F to convert to Fahrenheit: " # prompt for conversion type

# display answer
# 92 degrees F is 93.32 degrees C
answer1: .asciiz " Fahrenheit is "
answer2: .asciiz " Celsius"
invalidDisplay: .asciiz "Invalid input." # display invalid input

const5: .float 5.0 # const5: 5.0
const9: .float 9.0 # const9: 9.0
const32: .float 32.0 # const32: 32.0


.text
main:
# Pseudocode
# expanded format
# program pseudocode
# pseudocode for functions
# create datafields
# create macros
# writing the code
# test with known values

# Program: 
# greeting
# prompt for conversion type
# if: to Fahrenheit, prompt for celsius temperature, call ConvertToFar, call PrintAnswer
# elif: to celsius, prompt for Fahrenheit temp, call ConvertToCel, call PrintAnswer
# else: print(invalid input)
# exit
#
# Registers:
# cel = f20
# far = f22
# convt type = t1




# Program: 
# greeting
	print_str(greeting) # graceful close
	print_char(10)	# newline
	
# prompt for conversion type
	print_str(typePrompt)
	
# read in the type
	read_char() # read char
	move $t1, $v0 # move from v0 to t1

	# branch to Fahrenheit if F or f
	beq $t1, 0x46, Fahrenheit
	beq $t1, 0x66, Fahrenheit
	
	# branch to Celsius if C or c
	beq $t1, 0x43, Celsius
	beq $t1, 0x63, Celsius
	
	j Invalid # if input is not any of the above: jump to invalid
# if to Fahrenheit
Fahrenheit:
	 # prompt for celsius temperature
	 print_str(celPrompt)
	 
	 # read in the float
	 read_float()
	 mov.s $f20, $f0 # move f0 to argument register f20 to set up arguments
	 
	 # set up arguments
	 # call ConvertToFar
	 jal convert_to_far
	 
	 # set up arguments
	 mov.s $f22, $f0
	 
	 # call PrintAnswer
	 jal print_answer
	 
	 j end_main # branch to exit (end_main)
	
# elif: to celsius
Celsius:
	# prompt for fahrenheit temperature
	 print_str(farPrompt)
	 
	 # read in the float
	 
	 # set up arguments
	 # call ConvertToCel
	 
	 # set up arguments
	 # call PrintAnswer
	 
	 j end_main # branch to exit (end_main)
	 
# else: print(invalid input)
Invalid:
	# print invalid
	print_str(invalidDisplay)
	# exit

# exit
end_main:

# graceful close
	print_char(10) # two newlines
	print_char(10)
	print_str(close)
	print_char(10)	# newline
# clean exit
	li $v0, 10
	syscall




# procedures

# ConvertToFar(float cel) {
# 	return  cel * 9.0/5.0 + 32.0
# }

# Registers for ConvertToFar:
# cel = f20
# result = f0
# labels for 9.0, 5.0, and 32.0 (easiest way to deal with floating points is to load from memory)
# constants = f16, f18
convert_to_far:
	# return  cel * 9.0/5.0 + 32.0
	l.s $f16, const5 # load 5.0
	l.s $f18, const9 # load 9.0
	div.s $f16, $f18, $f16 # f16 = 9/5
	
	mul.s $f0, $f16, $f20 # f0 = 9/5 * cel
	
	l.s $f18, const32 # load 32
	add.s $f0, $f0, $f18 # f0 = f0 + 32
end_convert_to_far:
	jr $ra # jump back
	
# ConvertToCel(float fra) {
# 	return  (5.0/9.0) * (far- 32.0)
# }

# Registers for ConvertToCel:
# far = f20
# result = f0
# labels for 9.0, 5.0, and 32.0 (easiest way to deal with floating points is to load from memory)
# constants = f16, f18
convert_to_cel:

end_convert_to_cel:
	jr $ra # jump back
	
	
# PrintAnswer(float far, float cel) {
#	# 25 degrees Fahrenheit is 19 degrees Celsius
# }
#
# Registers for PrintAnswer:
# far = f22
# cel = f20
print_answer:
	# print far
	print_float($f22)
	
	# print degree symbol
	print_char(176)
	
	# print answer1
	print_str(answer1)
	
	# print cel
	print_float($f20)
	
	# print degree symbol
	print_char(176)
	
	# print answer2
	print_str(answer2)
	
end_print_answer:
	jr $ra # jump back