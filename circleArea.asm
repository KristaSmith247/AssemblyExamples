# Author: Krista Smith
# Date: 10/4/23
# Description: The program will estimate the area of a circle given a radius.

.data
greeting: .asciiz "Welcome to Circle Areas 'R Us\n" # greeting
close: .asciiz "\nThanks and have a great weekend" # close
prompt: .asciiz "\nEnter a radius or a 0 to quit: " # prompt for radius
display: .asciiz "The approximate area of the circle is " # display

.text

# Pseudocode:
# friendly greeting
# while(radius != 0) {
#	print(prompt)
#	read int
#	calculate area
#	print(display)
# 	print (area)
#	change the condition
#	jump back
#  } // end while
# print(close)
# clean exit

# Registers used:
# radius - t0
# area - t1

# friendly greeting
	li $v0, 4
	la $a0, greeting
	syscall

loop:
#	print(prompt)
	li $v0, 4
	la $a0, prompt
	syscall
	
#	read int
	li $v0, 5
	syscall
	# move the int to t0
	move $t0, $v0
# break out of the loop: jump to exit
	beqz $t0, exit
	
#	calculate area
	# area = pi * radius^2
	li $t1, 3 # approximate pi
	mul $t1, $t1, $t0 # t1 = 3 * r
	mul $t1, $t1, $t0 # t1 = (3 * r) * r
	
#	print(display)
	li $v0, 4
	la $a0, display
	syscall
	
# 	print (area)
	li $v0, 1 # print int
	move $a0, $t1
	syscall

#	jump back
	j loop

exit:	
# print(close)
	li $v0, 4
	la $a0, close
	syscall
# clean exit
	li $v0, 10
	syscall
