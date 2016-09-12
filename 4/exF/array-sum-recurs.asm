# array-sum-recurs.asm
# ENCM 369 Winter 2016 Lab Exercise F

# BEGINNING of start-up & clean-up code.
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
str1:	.asciiz	"Sum of array elements is "

# int main(void)
#
# Variable		Allocation
#   int x[9]		  9 words starting at 0($sp)
#   int sum		  36($sp)
#
	.text
	.globl	main
main:
	addi	$sp, $sp, -64
	sw	$ra, 60($sp)
	
	# Give values of 0x100 ... 0x108 to array elements x[0] .... x[8].
	addi	$t0, $zero, 0x100
	addi	$t1, $zero, 0
L1:	slti	$t2, $t1, 9
	beq	$t2, $zero, L2
	add	$t3, $t0, $t1
	sll	$t4, $t1, 2
	add	$t5, $sp, $t4
	sw	$t3, ($t5)
	addi	$t1, $t1, 1
	j	L1
L2:	
	addi	$a0, $sp, 0		# $a0 = &x[0]
	addi	$a1, $zero, 0		# $a1 = 0
	addi	$a2, $zero, 9		# $a2 = 9	
	jal	array_sum
	sw	$v0, 36($sp)		# sum = rv from array_sum
	
	la	$a0, str1
	addi	$v0, $zero, 4		# syscall: print string
	syscall
	lw	$a0, 36($sp)		# $a0 = sum
	addi	$v0, $zero, 34		# syscall: print int in hex
	syscall
	addi	$a0, $zero, '\n'
	addi	$v0, $zero, 11		# syscall: print char
	syscall
	

	add	$v0, $zero, $zero	# rv from main = 0
			
	lw	$ra, 60($sp)
	addi	$sp, $sp, 64
	jr	$ra

# int array_sum(const int *a, int low, int high)
#
# REMARK: All the arguments and local variables are on stack, not because
# that's efficient, but because it helps in understanding the sequence of
# recursive calls to this procedure. 
#
# Argument/Variable	Allocation
#   a					  16($sp)
#   low				  20($sp)
#   high				  24($sp)
#   int mid			  8($sp)
#   int result			  12($sp)
#
	.text
	.globl	array_sum
array_sum:
	addi	$sp, $sp, -32
	sw	$ra, 28($sp)
	sw	$a2, 24($sp)
	sw	$a1, 20($sp)
	sw	$a0, 16($sp)

	# Note: OK to get args from $a0, $a1, $a2 BEFORE
	# any procedure call is made.
	addi	$t0, $a1, 1
	bne	$t0, $a2, else
	sll	$t1, $a1, 2
	add	$t2, $a0, $t1
	lw	$t3, ($t2)
	sw	$t3, 12($sp)
	j	endif
else:
	add	$t4, $a1, $a2	# $t4 = low + high
	
	# srl dest, src, 1 does integer division by 2, as long as
	# src is zero or positive.
	srl	$t5, $t4, 1	# $t5 = $t4 / 2

	sw	$t5, 8($sp)	# mid = $t5
	add	$a2, $zero, $t5
	jal	array_sum	# outgoing args: a, low, mid
	sw	$v0, 12($sp)	# result = rv from array_sum
	lw	$a0, 16($sp)
	lw	$a1, 8($sp)	
	lw	$a2, 24($sp)
	jal	array_sum	# outgoing args: a, mid, high
	lw	$t6, 12($sp)
	add	$t7, $t6, $v0	# $t7 = result + rv from array_sum
	sw	$t7, 12($sp)
endif:
	lw	$v0, 12($sp)
	
	lw	$ra, 28($sp)
	addi	$sp, $sp, 32
	jr	$ra
