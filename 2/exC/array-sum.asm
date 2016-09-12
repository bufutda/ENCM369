# array-sum.asm
# ENCM 369 Winter 2016 Lab 2 Exercise C Part 3

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


# Global variables
	.data
	# int xyz[] = { -8, 16, -32, 64, -128, 256 }
	.globl	xyz	
xyz:	.word	-8, 16, -32, 64, -128, 256

# Hint for checking that the original program works:
# The sum of the six array elements is 168, which will be represented
# as 0x000000a8 in a MIPS GPR.

# Hint for checking that your final version of the program works:
# The minimum of the six array elements is -128, which will be represented
# as 0xffffff80 in a MIPS GPR.


# int main(void)
#
# local variable	register
#   int *p		$s0
#   int *end		$s1
#   int min		$s2  (to be used when students enhance the program)
#   int total		$s3
#	
	.text
	.globl	main
main:
	la	$s0, xyz		# p = foo
	addi	$s1, $s0, 24		# end = p + 6
	add	$s3, $zero, $zero	# total = 0 
	lw 	$s2, ($s0)		# min = *p
L1:
	beq	$s0, $s1, L2		# if (p == end) goto L2
	lw	$t0, ($s0)		# $t0 = *p
	add	$s3, $s3, $t0		# total += $t0
	addi	$s0, $s0, 4		# p++
	slt	$t1, $t0, $s2		# if ($t0 < min) $t1 = 1
	bne	$t1, $zero, L3		# if ($t1 != 0) goto L3
	j	L1
L3:	
	add 	$s2, $t0, $zero		# min = $t0 + 0
	j	L1			# goto L1
L2:		
	add	$v0, $zero, $zero	# return value from main = 0
	jr	$ra
