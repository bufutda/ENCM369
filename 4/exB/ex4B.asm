# ex4B.asm
# ENCM 369 Winter 2016 Lab 4 Exercise B

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

#	void my_strcpy(char *dest, const char *src)
#	  Leaf procedure: dest is $a0, src is $a1.
#
	.text
	.globl	my_strcpy
my_strcpy:
L1:	lbu	$t0, ($a1)		# $t0 = *src
	beq	$t0, $zero, L2		# if ($t0 == '\0') goto L2
	sb	$t0, ($a0)			# *dest = bits 7-0 of $t0
	addi	$a0, $a0, 1		# src++
	addi	$a1, $a1, 1		# dest++
	j	L1
L2:	sb	$zero, ($a0)		# *dest = '\0'
	jr	$ra

# char my_dest[32];	
	.data
	.align	5	# Align next data at address that is a multiple of 32.
	.globl	my_dest
my_dest:	.space 32
	
#	int main(void)
#
	.data
	.align	5	# Align next data at address that is a multiple of 32.
str1:	.asciiz	 "This is Lab 4 Exercise B."
	.text
	.globl	main
main:
	# Prologue only needs to save $ra
	addi	$sp, $sp, -32
	sw	$ra, 0($sp)
	
	# Body is AL for my_strcpy(my_dest, "This is Lab 4 Exercise B.")
	la	$a0, my_dest		# $a0 = my_dest
	la	$a1, str1		# $a1 = "This is [...]"
	jal	my_strcpy
	
	# Epilogue
	lw	$ra, 0($sp)
	addi	$sp, $sp, 32
	jr	$ra
