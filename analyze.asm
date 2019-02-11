  # analyze.asm
  # This file written 2015 by F Lundevall
  # Copyright abandoned - this file is in the public domain.

	.text
main:
	addi	$t1,$0,0	# 0011 0000 = 48
loop:
	slt	$t0,$t1,$a0
	nop
	beq	$t0,$0,ddone
	nop
	nop
	lw	$s0,4($a1)
	lw	$s1,8($a1)
	and	$s0,$s0,$s1
	sw	$s0,0($a1)
	addi	$a1,$a1,-12
done:	addi	$t1,$t1,1
	j	loop
ddone:		# copy from s0 to a0
	
	li	$v0,11		# syscall with v0 = 11 will print out
	syscall			# one byte from a0 to the Run I/O window

	addi	$s0,$s0,3	# what happens if the constant is changed?
				# 1 -> 3
	
	li	$t0,0x5b	# 5b = 0101 1011 = 91 -> 0101 1101 = 93 = 5d
	bne	$s0,$t0,loop
	nop			# delay slot filler (just in case)

stop:	j	stop		# loop forever here
	nop			# delay slot filler (just in case)









