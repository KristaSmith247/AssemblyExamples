# Author: Krista Smith
# Date: 10/4/23
# Description: The file will demonstrate looping by iterating over an array of elements.


.data
# an integer array (variable)
fibs: .word 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144
total: .word 0	# integer variable for answer
display: .asciiz "The sum is "

.text
# Pseudocode: 
# 	foreach (fib in fibs){
#		fib += fibs[i]
#	}
# 	display answer

# Registers used: 
# fib - t0
# i (loop control) - t1
# sum - t2

	# initialize i
	li $t1, 0	# i = 0
	
loop:
	# loop condition - branch away when we get to 144
	beq $t0, 144, endloop	# branch to endloop when == 144
	
	lw $t0, fibs($t1)	# fib = fibs[i]
	add $t2, $t2, $t0	# sum += fib
	addi $t1, $t1, 4 	# increment i ( i += 4 because it's a word)
	j loop			# do it again - jump back to  loop
	
endloop:	
	# save answer to memory
	sw $t2, total
	
	# print the answer
	li $v0, 4	# print string
	la $a0, display
	syscall
	
	li $v0, 1	# print int
	lw $a0, total
	syscall
	
	# clean exit
	li $v0, 10
	syscall
	
	