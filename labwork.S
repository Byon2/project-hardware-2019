  # labwork.S
  # Written 2015-2017 by F Lundevall
  # Skeleton file for IS1200/IS1500 lab 1.
  # The macros PUSH and POP are in the public domain.
  # Please add your own code at the end of the file.

  #
  # Please keep the two macros PUSH and POP unchanged
  #
.macro	PUSH reg
	addi	$sp,$sp,-4
	sw	\reg,0($sp)
.endm

.macro	POP reg
	lw	\reg,0($sp)
	addi	$sp,$sp,4
.endm
	
	#.global		hexasc
	.global	delay
	.global	time2string
	.global enable_interrupt
	.data
	.align 2
mytime:	.word 0x5957
timstr:	.ascii "text more text lots of text\0"
	.text


  #
  # Please add your own code below this line
  #

  # you can write your code for subroutine "hexasc"
hexasc:
	andi	$a0,$a0,0x000f
	addi	$t0,$0,0x39
	addi	$v0,$a0,0x30
	
	ble	$v0,$t0,pass
	nop
	addi	$v0,$v0,0x7
	
	
pass:
	andi	$v0,$v0,0x7F
	jr	$ra
	nop
	
delay:
	PUSH	$ra

	
	
	li	$t0,0x0
	li	$t1,4711
	
while:
	beq	$0,$a0,end
	nop
	sub	$a0,$a0,1
	
for:
	beq	$t0,$t1,while
	nop
	addi	$t0,$t0,1
	j	for
	nop
	
end:
	POP	$ra
	jr 	$ra
	nop
	
time2string:
	PUSH	$ra
	PUSH	$s0
	PUSH	$s1
	PUSH	$s2
	
	move	$s0,$a0
	move	$s1,$a1

	andi	$t0,$s1,0xf000
	srl	$a0,$t0,12
	jal	hexasc
	nop
	move	$a2,$v0
	sb	$a2,0($s0)
	
	andi	$t0,$s1,0x0f00
	srl	$a0,$t0,8
	jal	hexasc
	nop
	move	$a2,$v0
	sb	$a2,1($s0)
	
	li	$t0,0x3A
	sb	$t0,2($s0)
	
	andi	$t0,$s1,0x00f0
	srl	$a0,$s1,4
	jal	hexasc
	nop
	move	$a2,$v0
	sb	$a2,3($s0)
	
	
	andi	$a0,$s1,0x000f
	jal	hexasc
	nop
	move	$a2,$v0
	sb	$a2,4($s0)
	
	li	$t0,0x00
	sb	$t0,5($s0)
	
	
	
	
	
	POP	$s2
	POP	$s1
	POP	$s0
	POP	$ra
	
	jr	$ra
	nop
	
	

enable_interrupt:
	ei
	jr	$ra
	nop




























