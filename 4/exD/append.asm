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


	.data
S1:	.asciiz	""
S2:	.asciiz	"W"
S3:	.asciiz	"inter "
S4:	.asciiz	"2"
S5:	.asciiz	"016"
S6:	.asciiz	" ENCM 369"
NEWLINE:.asciiz	"\n"
	.text
	
# int main(void)
main:
	addi	$sp, $sp, -32
	sw	$ra, 28($sp)
	sw	$s0, 24($sp)
	
	add	$s0, $sp, $zero
	sb	$zero, ($s0)	# str[0] = '\0'
  
  	add	$a0, $s0, $zero
  	la	$a1, S1
  	jal	append
  	
  	add	$a0, $s0, $zero
  	la	$a1, S2
  	jal	append
  	
  	add	$a0, $s0, $zero
  	la	$a1, S3
  	jal	append
  	
  	add	$a0, $s0, $zero
  	la	$a1, S4
  	jal	append
  	
  	add	$a0, $s0, $zero
  	la	$a1, S5
  	jal	append
  	
  	add	$a0, $s0, $zero
  	la	$a1, S1
  	jal	append
  	
  	add	$a0, $s0, $zero
  	la	$a1, S6
  	jal	append
  	
  	add	$a0, $sp, $zero
  	li	$v0, 4
  	syscall
  	la	$a0, NEWLINE
  	li	$v0, 4
  	syscall
  	
  	add	$v0, $zero, $zero
  	
  	lw	$s0, 24($sp)
  	lw	$ra, 28($sp)
  	add	$sp, $sp, 32
  	jr	$ra
  	

# void append(char *dest, const char *src)
append:
	add	$t0, $zero, $zero	# i = 0
L1:	add	$t3, $a0, $t0		# $t3 = dest + i
	lb	$t3, ($t3)		# $t3 = dest[i]
	beq	$t3, $zero, L2		# if ($t3 == 0) goto L2
	addi	$t0, $t0, 1		# i++
    	j	L1
L2:	add	$t1, $zero, $zero	# j = 0
L3:	add	$t3, $a1, $t1		# $t3 = src + j
	lb	$t2, ($t3)		# c = src[j]
	add	$t3, $a0, $t0		# $t3 = dest + i
	sb	$t2, ($t3)		# dest[i] = c
	addi	$t0, $t0, 1		# i++
	addi	$t1, $t1, 1		# j++
	beq	$t2, $zero, L4		# if (c == 0) goto L4
	j	L3
L4:	jr	$ra
