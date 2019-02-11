  # hexmain.asm
  # Written 2015-09-04 by F Lundevall
  # Copyright abandonded - this file is in the public domain.

	.text
main:
	li	$a0,0xff		# change this to test different values
	
back:
	jal	hexasc		# call hexasc
 
	nop			# delay slot filler (just in case)	

	move	$a0,$v0		# copy return value to argument register

	li	$v0,11		# syscall with v0 = 11 will print out
	syscall			# one byte from a0 to the Run I/O window
	
	j	stop		# stop after one run
	nop			# delay slot filler (just in case)

  # You can write your own code for hexasc here
  #
hexasc:
	andi	$v0,$a0,0x000F		#only keeps the LSB
	addi	$t0,$0,0x39		#keeps the ascii code for 9
	addi	$v0,$v0,0x30		#adds the ascii code for 0 to the number
	
	ble	$v0,$t0,pass		#checks if the ascii code is lesser or equal to 9 otherwise it needs to return a-f in ascii
	nop
	addi	$v0,$v0,0x7		#adds 7 to make it a-f in ascii
	
	
	
pass:
	andi	$v0,$v0,0x7F		#makes sure there are only 7 bits that can be 1
	jr	$ra			#returns to the caller
	nop				#for delayed branching
	
	
	
stop:	nop
	


















