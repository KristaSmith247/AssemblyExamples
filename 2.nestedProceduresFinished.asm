# Author: Krista Smith
# Date: 11/27/23
# Description: 	learn about nested procedures

.data 

# string constants
hello: .asciiz "Inside Hello procedure\n"
hola: 	.asciiz "Inside Hola procedure\n"
name: 	.asciiz "Hi Pedro\n "
done: .asciiz "Have a great week!\n"

.text

	# set up to jump to Hello()
	la $a0, name
	jal hello_proc
	
	# set up to jump to Hola()
	la $a0, name
	jal hola_proc
	
	# print done
	li $v0, 4
	la $a0, done
	syscall
			
end: 	li $v0, 10	#exit
	syscall


###############################################################
# Print Hello String + name string
#
# $a0 - input, name string
# uses $s0 for input parameter (required)
hello_proc:

	# only one register to store return address $ra, it is overwritten in the jump to Hola()
	# save registers to the Stack
	subu $sp, $sp, 32 # subtract 32 from the stack pointer and put it back in the stack pointer (32 is the frame size)
			# (^begin allocation)
	sw $ra, 28($sp) # preserve return address (required)
	sw $fp, 24($sp) # preserve frame counter (required)
	sw $s0, 20($sp) # preserve $s0 if necessary
	sw $s1, 16($sp) # preserve $s1 if necessary
	addu $fp, $sp, 32 # move frame pointter to the base frame (end allocation)
	
			
			
	# set return value
	move $s0, $a0
	
	# print hello
	li $v0, 4
	la $a0, hello
	syscall
	
	# print name
	li $v0, 4
	move $a0, $s0
	syscall
	
	# call Hola()
	# set up the argument
	move $a0, $s0
	jal hola_proc
	
	# it is getting confused about the value in $ra when jumping back from Hola()
	# $ra contains line 59, but line 61 says jump to $ra
end_hello_proc:
	# reset ra - restore registers from the Stack
	lw $ra, 28($sp) # restore return address
	lw $fp, 24($sp) # restore frame counter
	lw $s0, 20($sp) # restore $s0 if necessary
	lw $s1, 16($sp) # restore $s1 if necessary
	addu $sp, $sp, 32 # end allocation (move frame pointer back to base frame)
	# return from procedure
	jr $ra



###############################################################
# Print Hola String + name string
#
# $a0 - input, name string
# uses $s0 for input parameter (required)
hola_proc:

	# set return value
	move $s0, $a0
	
	# print hola
	li $v0, 4
	la $a0, hola
	syscall
	
	# print name
	li $v0, 4
	move $a0, $s0
	syscall
	
end_hola_proc:
	jr $ra
