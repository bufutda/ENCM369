# overflow.asm
# Part of ENCM 369 Winter 2016 Lab 3 Exercise A

	.text
	li	$t0, 0x7fffffff		# $t0 = largest signed int
	addi	$t0, $t0, 1		# try to do $t0 += 1
	addi	$v0, $zero, 10		# $v0 = syscall code for exit
	syscall
