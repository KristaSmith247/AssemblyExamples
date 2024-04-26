# shiftAND.asm
# Author: Krista Smith
# Date: 9/27/23
# Description : This program will demonstrate shift operations and isolating bits using AND. 

.data


.text

	# set a hex value
	li $t0, 0xABCDABCD
	li $t1, 0x1234FEDC
	
	# shift left
	sll $t4, $t0, 4	# shift t0 by 4 - expect a larger value when shifted to the left BCDABCD0
	sll $t4, $t0, 3	# shift left by 3
	
	# shift left by 7
	sll $t4, $t0, 7		# (e6d5e680)
	
	# shift right
	srl $t5, $t1, 4 	# shift $t1 right by 4 bits
	srl $t5, $t1, 11	
	
	# shift right by 6
	srl $t5, $t1, 6		# (0x0048d3fb)
	
# --- ISOLATE BITS ---------------------------------------------------
	li $s0, 0xFC000000
	# 0b 1111 1100 0000 0000 0000 0000 0000 0000	binary for above hex number
	# use shift to isolate 31 - 26 (6 leftmost bits 1111 11 = 0x3F)
	# shift right by 26 to drop off trailing 26 bits
	srl $s1, $s0, 26	# s1 now contains 0x3F
	
	li $s0, 0xabcd1234
	# isolate most significant bit 1010
	# isolate 31 (leftmost bit 1)
	srl $t1, $s0, 31
	
	# isolate bits 30 - 23 (010 1011 1 = 0x57)
	# 0b 1010 1011 1100 1101 0001 0010 0011 0100
	# shift left by 1 - drop the leading bit
	sll $s2, $s0, 1
	# shift right by 24 - drop off trailing 24 bits
	srl $s3, $s2, 24
	
	# isolate bits using AND
	# isolate bits 30 - 23 (010 1011 1 = 0x57)
	# 1010 1011 1100 1101 0001 0010 0011 0100   in $s0
	# 0111 1111 1000 0000 0000 0000 0000 0000 (0x7F80 0000)
	# andi with this hex number
	andi $s4, $s0, 0x7f800000
	# shift right to get the bit
	srl $s4, $s4, 23
	
	
	

# clean exit
	li $v0, 10
	syscall
