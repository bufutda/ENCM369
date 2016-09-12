# swap.asm
# ENCM 369 Winter 2016 Lab 3 Exercise F

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

# int foo[] =  { 0x700, 0x600, 0x500, 0x400, 0x300, 0x200, 0x100 }
	.data
        .globl	foo
foo:	.word	0x700, 0x600, 0x500, 0x400, 0x300, 0x200, 0x100

# int main(void)
#
        .text
        .globl  main
main:
	addi	$sp, $sp, -32
 	sw 	$ra, 0($sp)

	la	$t0, foo	# $t0 = &foo[0]
	addi	$a0, $t0, 0	# $a0 = &foo[0]
	addi	$a1, $t0, 24	# $a1 = &foo[6]
	jal	swap
	
	la	$t0, foo	# $t0 = &foo[0]
	addi	$a0, $t0, 4	# $a0 = &foo[1]
	addi	$a1, $t0, 20	# $a1 = &foo[5]
	jal	swap

	la	$t0, foo	# $t0 = &foo[0]
	addi	$a0, $t0, 8	# $a0 = &foo[2]
	addi	$a1, $t0, 16	# $a1 = &foo[4]
	jal	swap

	add	$v0, $zero, $zero		
	lw	$ra, 0($sp)
	addi	$sp, $sp, 32
	jr	$ra

# void swap(int *left, int *right)
#
	.text
	.globl  swap
swap:
  	lw	$t0, ($a1)	# $t0 = *right
  	lw	$t1, ($a0)	# $t1 = *left
  	sw	$t1, ($a1)	# *right = $t1
  	sw	$t0, ($a0)	# *left = $t0
	jr	$ra
