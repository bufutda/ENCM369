# bad-align.asm
# Part of ENCM 369 Winter 2016 Lab 3 Exercise A

	.data
		# int words[] = { 0x01234567, 0x89abcdef };
words:	.word	0x01234567, 0x89abcdef

	.text
	la	$t0, words	# $t0 = &words[0]
	lw	$t1, 0($t0)	# this load will be fine
	lw	$t2, 4($t0)	# this load will also work
	lw	$t3, 2($t0)	# try lw with address not a multiple of 4
	addi	$v0, $zero, 10	# $v0 = syscall code for exit
	syscall
