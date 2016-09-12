# stub2.asm
# ENCM 369 Winter 2016 Lab 3
# This program has complete start-up and clean-up code, and a "stub"
# main function. It's exactly the same as stub1.asm from Lab 2, except
# that comments have been added to help with the organization of main.

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

# Below is the stub for main. Edit it to give main the desired behaviour.
	.data
earth:	.word 0x30000
	.globl	earth
	.text
	.globl	main

main:
	# PROLOGUE
	addi	$sp, $sp, -12		# allocate 3 stack slots
	sw	$ra, 8($sp)		# save $ra
	sw	$s0, 4($sp)		# save $s0
	sw	$s1, 0($sp)		# save #s1
	# BODY
	addi	$s0, $zero, 0x7000	# car = 0x7000
	addi	$s1, $zero, 0x3000	# truck = 0x3000
	# set up a registers for call to murcury
	addi	$a0, $zero, 2		# $a0 = 2
	addi	$a1, $zero, 3		# $a1 = 3
	addi	$a2, $zero, 4		# $a2 = 4
	addi	$a3, $zero, 6		# $a3 = 6
	jal	mercury			# $v0 = murcury(2,3,4,6)
	add	$s1, $s1, $v0		# truck += $v0
	la	$t0, earth		# $t0 = earth
	add	$t0, $t0, $s1		# $t0 += truck
	add	$s0, $s0, $t0		# car += $t0
	add	$v0, $zero, $zero	# return value from main = 0
	# EPILOGUE
	lw	$s1, 0($sp)		# recover $s1
	lw	$s0, 4($sp)		# recover $s0
	lw	$ra, 8($sp)		# recover $ra
	addi	$sp, $sp, 12		# decallocate 3 stack slots
	jr	$ra			# return

mercury:
	# PROLOGUE
	addi	$sp, $sp, -32		# allocate 8 stack slots
	sw	$ra, 28($sp)		# save $ra
	sw	$s0, 24($sp)		# save $s0
	sw	$s1, 20($sp)		# save $s1
	sw	$s2, 16($sp)		# save $s2
	sw	$s3, 12($sp)		# save $s3
	sw	$s4, 8($sp)		# save $s4
	sw	$s5, 4($sp)		# save $s5
	sw	$s6, 0($sp)		# save $s6
	add	$s0, $zero, $a0		# save $a0 in $s0
	add	$s1, $zero, $a1		# save $a1 in $s1
	add	$s2, $zero, $a2		# save $a2 in $s2
	add	$s3, $zero, $a3		# save $a3 in $s3
	# BODY
	# beta = venus(third, fourth)
	add	$a0, $zero, $s2		# $a0 = third
	add	$a1, $zero, $s3		# $a1 = fourth
	jal 	venus			# $v0 = venus(third, fourth)
	add	$s5, $zero, $v0		# beta = $v0
	# gamma = venus(second, third)
	add	$a0, $zero, $s1		# $a0 = second
	add	$a1, $zero, $s2		# $a1 = third
	jal 	venus			# $v0 = venus(second, third)
	add	$s6, $zero, $v0		# gamma = $v0
	# alpha = venus(fourth, first)
	add	$a0, $zero, $s3		# $a0 = fourth
	add	$a1, $zero, $s0		# $a1 = first
	jal 	venus			# $v0 = venus(fourth, first)
	add	$s4, $zero, $v0		# alpha = $v0
	# setup return value
	add	$v0, $s4, $s5		# r.v. = alpha + beta
	add	$v0, $v0, $s6		# r.v. += gamma
	# EPILOGUE
	lw	$s6, 0($sp)		# recover $s6
	lw	$s5, 4($sp)		# recover $s5
	lw	$s4, 8($sp)		# recover $s4
	lw	$s3, 12($sp)		# recover $s3
	lw	$s2, 16($sp)		# recover $s2
	lw	$s1, 20($sp)		# recvoer $s1
	lw	$s0, 24($sp)		# recover $s0
	lw	$ra, 28($sp)		# recover $ra
	addi	$sp, $sp, 32		# deallocate 8 stack slots
	jr	$ra			# return
venus:
	# BODY
	# setup return value
	sll	$t0, $a1, 7		# $t0 = 128 * $a1
	add	$v0, $a0, $t0		# r.v. = $a0 + $t0
	jr	$ra			# return