# ifElseClass.asm
# Author: Krista Smith
# Date: 10/2/23
# Description: The program will read in a number. If less than or equal to 100: multiply number by three.
#	Else: add 12. Then display the answer

.data
prompt: .asciiz "Please enter a number: "
answer: .asciiz "The answer is "

.text
# Pseudocode: 
# prompt for a number
# if (n <= 100) : 
#	n *= 3;
# else: n += 12;
# exit the program

# REGISTERS: n, multiply, add
# s1 - n (entered number)
# s2 - multiply (n * 3)
# s3 - multiplication answer
# s4 - 100


# hard code value
	li $s4, 100	# s4 = 100
	
# prompt for a number
	li $v0, 4
	la $a0, prompt
	syscall

# store input
	li $v0, 5
	syscall
	move $s1, $v0 # s1 = n

# if s1 <= 100: s1 * 3
	 bgt $s1, $s4, addition
	 mul $s2, $s1, 3 # s2 = s1 * 3
	 move $s3, $s2	 # move multiplication answer to s3
	 j exit		# jump to exit
	 

addition: 
# else: s1 + 12
	addi $s3, $s1, 12	# add n + 12, store in s3

exit:
# display answer
	li $v0, 4
	la $a0, answer
	syscall
# print int
	li $v0, 1
	move $a0, $s3
	syscall
	
# clean exit
	li $v0, 10
	syscall
