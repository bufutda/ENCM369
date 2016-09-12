# ex3D.asm
# ENCM 369 Winter 2016 Lab 3 Exercise D

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

# int procC(int x)
	.text
	.globl	procC
procC:
	# POINT ONE

	sll	$t0, $a0, 3
	sll	$t1, $a0, 1
	add	$v0, $t0, $t1
	jr	$ra
	
# void procB(int *p, int *q)
	.text
	.globl	procB
procB:
	addi	$sp, $sp, -32
	sw	$ra, 8($sp)
	sw	$s1, 4($sp)
	sw	$s0, 0($sp)
	add	$s0, $a0, $zero
	add	$s1, $a1, $zero
	
L1:
	beq	$s0, $s1, L2
	lw	$a0, ($s0)
	jal	procC
	sw  	$v0, ($s0)
	addi	$s0, $s0, 4
	j	L1
L2:
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$ra, 8($sp)
	addi	$sp, $sp, 32
	jr	$ra
	
# void procA(int s, int *a, int n)
	.text
	.globl	procA
procA:
	addi	$sp, $sp, -32
	sw	$ra, 16($sp)
	sw	$s3, 12($sp)
	sw	$s2, 8($sp)
	sw	$s1, 4($sp)
	sw	$s0, 0($sp)
	add	$s0, $a0, $zero
	add	$s1, $a1, $zero
	add	$s2, $a2, $zero
	
	addi	$s3, $s2, -1
	add	$a0, $s1, $zero
	sll	$t0, $s2, 2
	add	$a1, $s1, $t0
	jal	procB
L3:
	slt	$t0, $s3, $zero
	bne	$t0, $zero, L4
	sll	$t1, $s3, 2
	add	$t2, $s1, $t1
	lw	$t3, ($t2)
	add	$s0, $s0, $t3
	addi	$s3,	$s3, -1
	j	L3
L4:
	add	$v0, $s0, $zero
	
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$s2, 8($sp)
	lw	$s3, 12($sp)
	lw	$ra, 16($sp)
	addi	$sp, $sp, 32
	jr	$ra

# int gg[] = { 2, 3, 4 }
	.data
	.globl	gg
gg:	.word	2, 3, 4

# int main(void)
	.text
	.globl	main
main:
	addi	$sp, $sp, -32
	sw	$ra, 4($sp)
	sw	$s0, 0($sp)
	
	addi	$s0, $zero, 1000
	addi	$a0, $zero, 200
	la	$a1, gg
	addi	$a2, $zero, 3
	jal	procA
	add	$s0, $s0, $v0
	add	$v0, $zero, $zero
	
	lw	$s0, 0($sp)
	lw	$ra, 4($sp)
	addi	$sp, $sp, 32
	jr	$ra
