# Author: Krista Smith
# Date: 10/16/23
# Description: This file will demonstrate the use of floating point numbers

# create a macro to print a string
.macro print_str(%string)
	li $v0, 4
	la $a0, %string
	syscall
.end_macro

.data
greeting: .asciiz "Welcome to Floats 'R Us!!\n" # greeting
close: .asciiz "\nThanks for visiting Floats 'R Us! Have a great week." # graceful close
prompt: .asciiz "Please enter a floating point number: " # prompt for a float
display: .asciiz "The answer is: " # display answer
newline: .asciiz "\n" # force a newline
circle: .asciiz "\nThe area of the circle with your entered radius is: " # circle area display

doubleFloat: .double 123.456
singleFloat: .float 123.456
pi: .float 3.1415926
radius: .float 4.0

# the easiest way to load a float immediate is to load it from memory
# 3 float constants
const1: .float 15.0
const2: .float 6.0
const3: .float 19.25

.text
# Pseudocode: all instructions are for floats, single precision
# divide 2 floating points and display the answer
# subtract a value and display
# read in a float, multiply and display

# REGISTERS USED: 
# f16, f18

# friendly greeting
	li $v0, 4 # print a string
	la $a0, greeting
	syscall
	
	# print it again with macro
	print_str(greeting)

# divide 2 floating points and display the answer
	# load floats into registers
	l.s $f16, const1 # load 15.0 into f16
	l.s $f18, const2 # load 6.0 into f18
	
	# divide
	div.s $f16, $f16, $f18 # f16 = 15/6
	
	# display the "display" string
	print_str(display)
	
	# display the quotient
	li $v0, 2 # print a float
	mov.s $f12, $f16 # move quotient into f12
	syscall
	
	# force a newline
	print_str(newline)
	
# subtract a value from the quotient and display
	# load 19.25 into f18
	l.s $f18, const3
	
	# subtract 19.25 from quotient
	sub.s $f16, $f16, $f18 # f16 = f16 - 19.25
	# print display
	print_str(display)
	
	# print difference
	li $v0, 2
	mov.s $f12, $f16
	syscall
	
# read in a float, multiply and display
	# force newline
	print_str(newline)
	
	# display prompt
	print_str(prompt)
	
	# read in a float
	li $v0, 6
	syscall
	
	mov.s $f18, $f0 # move f0 into f18
	
	# multiply input by difference
	mul.s $f16, $f16, $f18 # f16 = f16 * f18
	# display "display"
	print_str(display)
	# display the product
	li $v0, 2
	mov.s $f12, $f16
	syscall
	
# load a single and double precision float from memory
	l.s $f2, singleFloat
	l.d $f4, doubleFloat

# load immediates that encode the floats into general purpose registers
# then move into float registers
	
	# put 123.456 into t1 (single precision 123.456 = 0x 42F6E979)
	li $t1, 0x42F6E979 # must use hexadecimal
	mtc1 $t1, $f6 # move the float into coprocessor 1's register f6
	
	# double precision
	# 123.456 double precision = 0x405E DD2F 1A9F EB77
	# load half into one register and half into another since we are limited by 32b
	li $t2, 0x405EDD2f
	li $t3, 0x1A9FEB77
	# move into f8-f9
	mtc1.d $t2, $f8

	# load a float
	li $t4, 6 # load a 6 into fp register
	mtc1 $t4, $f0
	
	# YOUR TURN:
	# calculate area of circle given fp value of pi, can hard code radius, display prompt and answer
# ask user to input radius
	# force a newline
	print_str(newline)
	
	# display prompt
	print_str(prompt)
	
	# read in a float
	li $v0, 6
	syscall
	
	mov.s $f22, $f0 # move f0 into f22
	
	# hard code radius
	l.s $f20, pi # load pi into f20
	 #l.s $f22, radius # hard code radius
	
	# calculate area of circle
	# area = pi * r * r
	mul.s $f22, $f22, $f22 # f22 = r * r
	mul.s $f20, $f22, $f20 # f20 = f20 * f22 or r^2 * pi
	
	# display answer
	print_str(circle)
	
	# display float
	li $v0, 2
	mov.s $f12, $f20
	syscall

exit:
# graceful close
	li $v0, 4 # print a string
	la $a0, close
	syscall
	
# clean exit
	li $v0, 10
	syscall