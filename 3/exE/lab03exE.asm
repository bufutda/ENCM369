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


	.data
aaa:	.word	11, 11, 3, -11
	.globl	aaa
bbb:	.word	200, -300, 400, 500
	.globl	bbb
ccc:	.word	-2, -3, 2, 1, 2, 3
	.globl	ccc
	
	.text
	.globl	main

main:
	# PROLOGUE
	addi	$sp, $sp, -16		# allocate 4 stack slots
	sw	$ra, 12($sp)		# save $ra
	sw	$s0, 8($sp)		# save $s0
	sw	$s1, 4($sp)		# save $s1
	sw	$s2, 0($sp)		# save $s2
	# BODY
	addi	$s2, $zero, 1000	# blue = 1000
	# red = special_sum(aaa, 4, 10)
	la	$a0, aaa		# $a0 = aaa
	addi	$a1, $zero, 4		# $a1 = 4
	addi	$a2, $zero, 10		# $a2 = 10
	jal	special_sum		# $v0 = special_sum(aaa, 4, 10)
	add	$s0, $zero, $v0		# red = $v0
    	# green = special_sum(bbb, 4, 200)
    	la	$a0, bbb		# $a0 = bbb
    	addi	$a1, $zero, 4		# $a1 = 4
    	addi	$a2, $zero, 200		# $a2 = 200
    	jal	special_sum		# $v0 = special_sum(aaa, 4, 200)
    	add	$s1, $zero, $v0		# green = $v0
    	# blue += special_sum(ccc, 6, 500) - red + green
    	la	$a0, ccc		# $a0 = ccc
    	addi	$a1, $zero, 6		# $a1 = 6
    	addi	$a2, $zero, 500		# $a2 = 500
    	jal	special_sum		# $v0 = special_sum(ccc, 6, 500)
    	add	$s2, $s2, $v0		# blue += $v0
    	add	$s2, $s2, $s1		# blue += green
    	sub	$s2, $s2, $s0		# blue -= red
    	# setup main r.v.
    	add	$v0, $zero, $zero	# r.v. = 0
	# EPILOGUE
	lw	$s2, 0($sp)		# recover $s2
	lw	$s1, 4($sp)		# recover $s1
	lw	$s0, 8($sp)		# recover $s0
	lw	$ra, 12($sp)		# recover $ra
	addi	$sp, $sp, 16		# decallocate 4 stack slots
	jr	$ra			# return

special_sum:
	# PROLOGUE
	addi	$sp, $sp, -24		# allocate 6 stack slots
	sw	$ra, 20($sp)		# save $ra
	sw	$s0, 16($sp)		# save $s0
	sw	$s1, 12($sp)		# save $s1
	sw	$s2, 8($sp)		# save $s2
	sw	$s3, 4($sp)		# save $s3
	sw	$s4, 0($sp)		# save $s0
	
	add	$s0, $zero, $a2		# $s0 = b
	add	$s1, $zero, $a0		# $s1 = x
	add	$s2, $zero, $a1		# $s2 = n
	# BODY
	add	$s3, $zero, $zero	# result = 0
	add	$s4, $zero, $zero	# i = 0
	
L0:	sll	$t0, $s4, 2		# $t0 = i * 4
	add	$t0, $t0, $s1		# $t0 += x
	lw	$a0, ($t0)		# $a0 = *x
	add	$a1, $zero, $s0		# $a1 = b
	jal	saturate		# $v0 = saturate(x[i], b)
	add	$s3, $s3, $v0		# result += $v0
	addi	$s4, $s4, 1		# i++
	slt	$t0, $s4, $s2		# $t0 = (i < n)
	beq	$t0, $zero, L1		# if ($t0 == 0) goto L1
	j	L0			# goto L0
	
L1:	add	$v0, $zero, $s3		# r.v. = result
	# EPILOGUE
	lw	$s4, 0($sp)		# recover $s4
	lw	$s3, 4($sp)		# recover $s3
	lw	$s2, 8($sp)		# recover $s2
	lw	$s1, 12($sp)		# recover $s1
	lw	$s0, 16($sp)		# recover $s0
	lw	$ra, 20($sp)		# recover $ra
	addi	$sp, $sp, 24		# deallocate 6 stack slots
	jr	$ra			# return

saturate:
	# BODY
	add	$v0, $zero, $a0		# r.v. = x
	
	slt	$t0, $a1, $a0		# $t0 = (bound < x)
	beq	$t0, $zero, L2		# if ($t0 == 0) goto L2
	add 	$v0, $zero, $a1		# r.v. = bound
L2:	sub	$a1, $zero, $a1		# bound = 0 - bound
	slt	$t0, $a0, $a1		# $t0 = (x < bound)
	beq	$t0, $zero, L3		# if ($t0 == 0) goto L3
	add	$v0, $zero, $a1		# r.v. = bound
L3:	jr	$ra			# return