# exB.asm
# ENCM 369 Winter 2016 Lab 3 Exercise B

# BEGINNING of start-up & clean-up code
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

# int fill(int *a, int n)
# Put 0x11 into a[0], 0x22 into a[1], and so on up to and including a[n-1].
#
# arg/var		allocation
#  a			  $a0
#  n			  $a1
#  int sum		  $t0
#  int * past_last	  $t1
#
	.text
	.globl	fill
fill:
	addi	$t0, $zero, 0x11	# sum = 0x11
	sll	$t2, $a1, 2		# $t2 = n * 4
	add	$t1, $a0, $t2		# past_last = a + n
L1:
	beq	$a0, $t1, L2		# if (a == past_last) goto L2
	sw	$t0, ($a0)		# *a = sum
	addi	$t0, $t0, 0x11		# sum += 0x11
	addi	$a0, $a0, 4		# a++
	j	L1
L2:
	jr	$ra
	
# int xyz[3]
	.data
	.globl	xyz
xyz:	.word	0, 0, 0
	
# int main(void)
	.text
	.globl	main
main:
	# prologue
	addi	$sp, $sp, -32		# allocate 8 words
	sw	$ra, 20($sp)		# offset used just to make the point that 20 = 0x14.
	
	# body
	la	$a0, xyz		# $a0 = &xyz[0]
	addi	$a1, $zero, 5		# $a1 = 5
	jal	fill
	add	$v0, $zero, $zero	# return value from main = 0
	
	# epilogue
	lw	$ra, 20($sp)
	addi	$sp, $sp, 32
	jr	$ra
