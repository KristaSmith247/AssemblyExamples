# Author: Krista Smith
# Date: 9/13/23
# Description: The program will be used to practice bytes and halfwords.

# data segment
.data
# .word = 4 bytes
# .half = 2 bytes
# .byte = 1 byte

# create a date label with July 4, 1776
date:   .byte 7 # month (4 bits - need 1 byte)
	.byte 4 # day 	(4 bits - need 1 byte)
	.half 1776 # year (11 bits - need 2 bytes - half word)

event: .asciiz "Declaration of Independence"
label: .asciiz "\nThe Declaration of Independence was signed "
separator: .asciiz "/"
# text segment
.text
# load values into registers
	
	lbu $t0, date # load month <byte> into $t0, goes to base address without offset
	lbu $t1, date + 1 # load day into $t1, offset by 1 byte
	lhu $t2, date + 2 # load year into $t2, offset by 2 bytes

# printing characters
# load the first letter of event into $t3
	lbu $t3, event
	
	# display the letter 'a' in Declaration
	lbu $t4, event + 4
	
	# display 'D'
	# with asciiz code:
	# li $a0, 0x60
	# li $v0, 11
	# li $a0, 0x60
	
	li $v0, 11 # print character
	move $a0, $t3 # load argument
	syscall
	
	# display 'a'
	li $v0, 11 # print character
	move $a0, $t4 # load argument
	syscall
	
	# print date label
	li $v0, 4
	la $a0, label
	syscall
	
	# print month
	li $v0, 1
	move $a0, $t0
	syscall
	
	# print /
	li $v0, 4
	la $a0, separator
	syscall
	
	# print day
	li $v0, 1
	move $a0, $t1
	syscall
	
	# print /
	li $v0, 4
	la $a0, separator
	syscall
	
	# print year
	li $v0, 1
	move $a0, $t2
	syscall
	
# clean exit
	li $v0, 10
	syscall