# Author: Krista Smith
# Date: 11/27/23
# Description: 	Print out the properties of a one digit number. 
#		Example of a switch block

# Pseudocode: 
#
#	print(prompt)
#	n = readInt()
#
#	switch(n) {
#	   case 0:
#	      print "n is zero"
#	      break
#	   case 4:
#	      print "n is even"
#	      break
#	   case 1:
#	   case 9:
#	      print "n is square"
#	      break
#	   case 2:
#	      print "n is even"
#	      break
#	   case 3:
#	   case 5:
#	   case 7:
#	      print "n is prime"
#	      break
#	   case 6:
#	   case 8:
#	      print "n is even"
#	      break
#	   default:
#	      print "out of range"
#
#	} # end switch
#
# Registers: n = $t0


.data 

# string constants
prompt: .asciiz "Enter a one digit number: "
zero: 	.asciiz "n is zero\n"
even: 	.asciiz "n is even\n"
square: .asciiz "n is square\n"
prime: 	.asciiz "n is prime\n"
bad: 	.asciiz "out of range\n"

# switch block jump table
# (like an array that will tell us where we want to jump to)
switch: .word case0, case1, case2, case3, case4, case5, case6, case7, case8, case9
# what is the index of each word? 
# index: 	0 ,	1,	2,   3,     4,     5, 	6, 	7, 	8, 9
# how big is each element? they are word-size - 4 bytes
# how many bytes to the second element? 4
# index: 0*4 , 1*4, 2*4, ....
# n = index	n = 0*4, 1*4, 2*4, ...
.text
	# print prompt
	li $v0, 4
	la $a0, prompt
	syscall
	# read in int
	li $v0, 5
	syscall
	# move into $t0, n = readInt()
	move $t0, $v0
	
	# test print
	#li $v0, 1
	#move $a0, $t0
	#syscall

	# set up branch to default
	bltz $t0, default # if n < 0, go to default
	bgt $t0, 9, default # if n > 9, go to default
	
	# set up register $v0 for future calls
	li $v0, 4 # print string
	
	
	
	# branch to the correct label
	mul $t1, $t0, 4 # temp = n * 4 (this is where we branch to, as seen on line 59-60)
	lw $t1, switch($t1) # temp = switch(temp)
	jr $t1 # jump to address in temp
case0:
	# print zero
	#li $v0, 4
	la $a0, zero
	syscall
	j end # jump to the end

case4: 
	#  print even
	la $a0, even
	syscall

case1:
case9:
	# print square
	la $a0, square
	syscall
	j end
	
case2:
	# print even
	la $a0, even
	syscall

case3:
case5:
case7:	
	# print prime
	la $a0, prime
	syscall
	j end

case6:
case8:
	# print even
	la $a0, even
	syscall
	j end
		
default:
	# print bad
	#li $v0, 4
	la $a0, bad
	syscall

end: 	li $v0, 10	#exit
	syscall




