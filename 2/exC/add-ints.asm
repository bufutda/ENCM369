# add-ints.asm
# ENCM 369 Winter 2016 Lab 2 Exercise C Part 2

# Start-up and clean-up code copied from stub1.asm

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


# Global variables.
	.data
	.globl	foo
foo:	.word	0x15
	.globl	bar
bar:	.word	0x2d
	.globl	quux
quux:	.word	0


# Instructions for main	
	.text
	.globl	main
main:
	la	$t0, foo		# $t0 = &foo
	lw	$t1, ($t0)		# $t1 = foo
	la	$t2, bar		# $t2 = &bar
	lw	$t3, ($t2)		# $t3 = bar
	add	$t4, $t1, $t3		# $t4 = $t1 + $t3
	la	$t5, quux		# $t5 = &quux
	sw	$t4, ($t5)		# quux = $t4 
	add	$v0, $zero, $zero	# return value from main = 0
	jr	$ra
