# demo.asm
# ENCM 369 Winter 2016 Lab 4 Exercise D
#
# Simple example of allocation and use of an array of chars within the stack
# frame of a procedure.

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

# int main(void)
#
# var		   allocation
#   char foo[6]	      6 bytes starting at 0($sp)
#
	.text
	.globl	main
main:
	addi	$sp, $sp, -32		# Will use only 6 bytes, not all 32.
	addi	$t0, $zero, 'H'
	sb	$t0, 0($sp)		# foo[0] = 'H'
	addi	$t0, $zero, 'e'
	sb	$t0, 1($sp)		# foo[1] = 'e'
	addi	$t0, $zero, 'y'
	sb	$t0, 2($sp)		# foo[2] = 'y'
	addi	$t0, $zero, '!'
	sb	$t0, 3($sp)		# foo[3] = '!'
	addi	$t0, $zero, '\n'
	sb	$t0, 4($sp)		# foo[4] = '\n'
	addi	$t0, $zero, '\0'
	sb	$t0, 5($sp)		# foo[5] = '\0'
	
	# printf("%s", foo) ...
	addi	$a0, $sp, 0		# $a0 = &foo[0]
	addi	$v0, $zero, 4		# syscall code: print string
	syscall
	
	add	$v0,$zero, $zero	# r.v. = 0
        addi	$sp, $sp, 32
	jr	$ra
