  # timetemplate.asm
  # Written 2015 by F Lundevall
  # Copyright abandonded - this file is in the public domain.

.macro	PUSH (%reg)
	addi	$sp,$sp,-4
	sw	%reg,0($sp)
.end_macro

.macro	POP (%reg)
	lw	%reg,0($sp)
	addi	$sp,$sp,4
.end_macro

	.data
	.align 2
mytime:	.word 0x0000
timstr:	.ascii "text more text lots of text\0"
	.text
main:
	# print timstr
	la	$a0,timstr
	li	$v0,4
	syscall
	nop
	# wait a little
	li	$a0,2
	jal	delay
	nop
	# call tick
	la	$a0,mytime
	jal	tick
	nop
	# call your function time2string
	la	$a0,timstr
	la	$t0,mytime
	lw	$a1,0($t0)
	jal	time2string
	nop
	# print a newline
	li	$a0,10
	li	$v0,11
	syscall
	nop
	# go back and do it all again
	j	main
	nop
# tick: update time pointed to by $a0
tick:	lw	$t0,0($a0)	# get time
	addiu	$t0,$t0,1	# increase
	andi	$t1,$t0,0xf	# check lowest digit
	sltiu	$t2,$t1,0xa	# if digit < a, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0x6	# adjust lowest digit
	andi	$t1,$t0,0xf0	# check next digit
	sltiu	$t2,$t1,0x60	# if digit < 6, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0xa0	# adjust digit
	andi	$t1,$t0,0xf00	# check minute digit
	sltiu	$t2,$t1,0xa00	# if digit < a, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0x600	# adjust digit
	andi	$t1,$t0,0xf000	# check last digit
	sltiu	$t2,$t1,0x6000	# if digit < 6, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0xa000	# adjust last digit
tiend:	sw	$t0,0($a0)	# save updated result
	jr	$ra		# return
	nop

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

	
	
	li	$t0,0x0		#for a counter starting on 0
	li	$t1,4711	#delay constant
	
while:
	beq	$0,$a0,end	#if the input is 0 it will end
	nop
	sub	$a0,$a0,1	#subtracts the input with 1
	
for:
	beq	$t0,$t1,while	#if they are equal to the value saved then it should go out to the while loop
	nop
	addi	$t0,$t0,1	#adds 1 to the timer
	j	for		#Go back to the for loop
	nop
	
end:
	POP	$ra		#go back to the caller
	jr 	$ra
	nop
	
time2string:
	PUSH	$ra		#push all registers used
	PUSH	$s0
	PUSH	$s1
	PUSH	$s2
	
	move	$s0,$a0		#moves the contents to registers that hexasc doesn't use
	move	$s1,$a1

	andi	$t0,$s1,0xf000
	srl	$a0,$t0,12	#shifts the msb to the hexasc
	jal	hexasc
	nop
	move	$a2,$v0		#then stores it to the address
	
	sb	$a2,0($s0)
	
	andi	$t0,$s1,0x0f00
	srl	$a0,$t0,8		#does the same for the other digits
	jal	hexasc
	nop
	move	$a2,$v0
	
	sb	$a2,1($s0)		#only 1 is added to the address since only 1 byte is stored
	
	li	$t0,0x3a		#only need this to 
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
	
	li	$t0,0x00		#just need 00 bytes
	sb	$t0,5($s0)
	
	
	
	
	
	POP	$s2			#pops everything back
	POP	$s1
	POP	$s0
	POP	$ra
	
	jr	$ra
	nop
	
	






























