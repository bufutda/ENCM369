# do_output.asm
# ENCM 369 Winter 2016 Lab 4 Exercise A

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
myword:
	.word 0x00216948

# int main(void)
	.text
	.globl	main
main:
	# Attention: syscalls are NOT procedure calls, so this particular
	# main is leaf. No prologue is needed.

	# Body of main ...

	# (Note: SPIM was the MIPS simulator used in ENCM 369 before the switch to MARS.)
	# Demonstrate some syscalls common to SPIM and MARS ...
	addi	$a0, $zero, 'E'		# $a0 = 'E'
	addi	$v0, $zero, 11		# code 11: print character
	syscall 
	addi	$a0, $zero, '\n'	# $a0 = '\n'
	addi	$v0, $zero, 11		# code 11: print character
	syscall 

	la	$t0, myword		# $t0 = &myword
					# MARS syscalls DON'T touch t-registers, 
					# so we can use the address in $t0 many times.

	lw	$a0, ($t0)		# $a0 = myword, assuming myword is an int													
	addi	$v0, $zero, 1		# code 1: print int
	syscall 
	addi	$a0, $zero, '\n'
	addi	$v0, $zero, 11
	syscall 

	lbu	$a0, ($t0)		# $a0 = myword[0], assuming myword is a 4-char array													
	addi	$v0, $zero, 11		# code 11: print character
	syscall 
	addi	$a0, $zero, '\n'
	addi	$v0, $zero, 11
	syscall 

	add	$a0, $zero, $t0		# $a0 = &myword
	addi	$v0, $zero, 4		# code 4: print string
	syscall 
	addi	$a0, $zero, '\n'
	addi	$v0, $zero, 11
	syscall 
	
	# Demonstrate some MARS syscalls not available in SPIM ...
	add	$a0, $zero, $t0		# $a0 = &myword
	addi	$v0, $zero, 34		# code 34: print word in hex
	syscall 
	addi	$a0, $zero, '\n'
	addi	$v0, $zero, 11
	syscall 
	
	lw	$a0, ($t0)		# $a0 = myword, assuming myword is an int
	addi	$v0, $zero, 34		# code 34: print word in hex
	syscall 
	addi	$a0, $zero, '\n'
	addi	$v0, $zero, 11
	syscall 
	
	lw	$a0, ($t0)		# $a0 = myword, assuming myword is an int
	addi	$v0, $zero, 35		# code 35: print word in binary
	syscall 
	addi	$a0, $zero, '\n'
	addi	$v0, $zero, 11
	syscall 
	
	add	$v0, $zero, $zero	# return value from main = 0
	
	# No epilogue needed.
	jr	$ra
