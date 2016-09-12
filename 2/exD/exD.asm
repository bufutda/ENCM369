# BEGINNING of start-up & clean-up code.  Do NOT edit this code.
	.data
exit_msg_1:
	.asciiz	"***About to exit. main returned "
exit_msg_2:
	.asciiz	".***\n"
main_rv:
	.word	0
	
	.text
	# adjust $sp, then call main
	addi	$t0, $zero, -32		# $t0 = 0xffffffe0
	and	$sp, $sp, $t0		# round $sp down to multiple of 32
	jal	main
	nop
	
	# when main is done, print its return value, then halt the program
	sw	$v0, main_rv	
	la	$a0, exit_msg_1
	addi	$v0, $zero, 4
	syscall
	nop
	lw	$a0, main_rv
	addi	$v0, $zero, 1
	syscall
	nop
	la	$a0, exit_msg_2
	addi	$v0, $zero, 4
	syscall
	nop
	addi	$v0, $zero, 10
	syscall
	nop	
# END of start-up & clean-up code.

# GLOBAL variables
	.data
	.globl	alpha
alpha:	.word 	0xb1, 0xe1, 0x91, 0xc1, 0x81, 0xa1, 0xf1, 0xd1
	.globl 	beta
beta:	.word 	0x0, 0x10, 0x20, 0x30, 0x40, 0x50, 0x60, 0x70

# Register Allocations
# Register		Variable
# $s0			pa
# $s1			pb
# $s3			guard
# $s4			i 
# $s5			min
# $s6			imin

	.text
	.globl	main
# Main Entry Point
main:
	la	$s0, alpha		# pa = alpha
	addi 	$s3, $s0, 32		# guard = pa + 8
	la	$s1, beta		# pb = beta
	addi	$s1, $s1, 32		# pb += 8
L1:
	beq	$s0, $s3, L2		# if (pa == guard) goto L2
	addi	$s1, $s1, -4		# pb--
	lw	$t0, ($s0)		# $t0 = *pa
	sw	$t0, ($s1)		# *pb = $t0
	addi	$s0, $s0, 4		# pa++
	j	L1			# goto L1
L2:
	add 	$s6, $zero, $zero	# imin = 0
	la	$t1, alpha		# $t1 = alpha
	lw	$s5, ($t1)		# min = alpha[0]
	addi	$s4, $zero, 1		# i = 1
L3:
	addi 	$t3, $zero, 8		# $t3 = 8
	slt	$t4, $s4, $t3		# $t4 = (i < $t3)
	beq	$t4, $zero, L6		# if ($t4 != 0) goto L6
	
	sll 	$t5, $s4, 2		# $t5 = i * 4
	add	$t5, $t5, $t1		# $t5 += alpha
	lw	$t6, ($t5)		# $t6 = *$t2
	slt	$t7, $t6, $s5		# $t7 = ($t6 < min)
	bne	$t7, $zero, L5		# if ($t7 != 0) goto L5
L4:
	addi	$s4, $s4, 1		# i++
	j	L3			# goto L3
L5:
	sll	$t2, $s4, 2 		# $t2 = i * 4
	add 	$t2, $t2, $t1		# $t2 += alpha
	lw	$s5, ($t2)		# min = *$t2
	add	$s6, $zero, $s4		# imin = i
	j	L4			# goto L4
L6:
	jr	$ra			# return
