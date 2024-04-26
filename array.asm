# Author: Krista Smith
# Date: 9/13/23
# Description: This program adds elements to an 'array', store the results in memory,
#	and display the results.


# data segment
.data
nums: .word -7, 20, -45	# an array of numbers
result: .word 0 # result - sum of numbers
display: .asciiz "The result is " # string to label results

# text segment
.text
	# load an array (nums) into a register ($t0)
	la $t0, nums
	
	# store each value in a different register
	lw $t1, 0($t0)	# load first element into $t1 - load word with zero offset from t0
	lw $t2, 4($t0)	# load second element into $t2
	lw $t3, 8($t0)	# 3rd element into $t3
	
	# add values, store in $s0
	add $s0, $t1, $t2	# s0 = t1 + t2
	add $s0, $s0, $t3	# s0 = s0 + t3
	
	# store sum in result
	sw $s0, result
	
	# print result
	li $v0, 4	# print string
	la $a0, display # load the argument
	syscall
		
	li $v0, 1 	# print integer
	lw $a0, result	# load argument from results
	syscall


# clean exit
	li $v0, 10
	syscall