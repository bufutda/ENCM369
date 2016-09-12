# switch1.asm
# ENCM 369 Winter 2016 Lab 4 Exercise E

# BEGINNING of start-up & clean-up code.
	.data
exit_msg_1:
	.asciiz "***About to exit. main returned "
exit_msg_2:
	.asciiz ".***\n"
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
	.data
main_str1:	.asciiz "The English spelling of "
main_str2:	.asciiz " has "
	.text
#
# Use $s0 for i and $s1 for s.
#
	.globl	main
main:
	# prologue
	addi	$sp, $sp, -32
	sw	$ra, 8($sp)
	sw	$s1, 4($sp)
	sw	$s0, 0($sp)
       
	# body
	addi	$s0, $zero, -1		# i = -1
L1:
	slti	$t0, $s0, 13		# $t0 = (i < 13)
	beq	$t0, $zero, L2		# if ( ! $t0) goto L2
	add	$a0, $s0, $zero	# $a0 = i
	jal	letter_count
	add	$s1, $v0, $zero		# s = r.v. from letter_count

	la	$a0, main_str1		# $a0 = main_str1
	addi	$v0, $zero, 4		# print string
	syscall
	add	$a0, $s0, $zero	# $a0 = i
	addi	$v0, $zero, 1		# print int
	syscall
	la	$a0, main_str2		# $a0 = main_str2
	addi	$v0, $zero, 4		# print string
	syscall
	add	$a0, $s1, $zero	# $a0 = s
	addi	$v0, $zero, 4		# print string
	syscall

	addi	$s0, $s0, 1		# i++
	j	L1
L2:
	add	$v0, $zero, $zero	# r.v. = 0

	# epilogue
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$ra, 8($sp)
	addi	$sp, $sp, 32
	jr	$ra
       

# const char * letter_count(int k)
#
	.data
	# Set up string constants used by letter_count
four_let:	.asciiz "four letters.\n"
three_let:	.asciiz "three letters.\n"
five_let:	.asciiz "five letters.\n"
unknown:	.asciiz "an unknown number of letters.\n"

	# Set up an array of instruction addresses.  Each .word directive
	# will result in the initialization of a memory word with the
	# address of an instruction within the letter_count procedure.
	# This kind of array of addresses is sometimes called a "jump table".
jump_table:
	.word	case_0_4_5_9	# index 0 in table
	.word	case_1_2_6_10	# index 1
	.word	case_1_2_6_10	# index 2
	.word	case_3_7_8	# index 3
	.word	case_0_4_5_9	# index 4
	.word	case_0_4_5_9	# index 5
	.word	case_1_2_6_10	# index 6
	.word	case_3_7_8	# index 7
	.word	case_3_7_8	# index 8
	.word	case_0_4_5_9	# index 9
	.word	case_1_2_6_10	# index 10

	.text
	.globl	letter_count
letter_count:
	# Since this is a leaf procedure, we can allocate result in $v0
	# to save having to copy anything into $v0 at the end of the
	# procedure.

	# If k is < 0 or > 10, we want to branch
	# to the instructions for the default case.
	slti	$t0, $a0, 0		# $t0 = (k < 0)
	bne	$t0, $zero, default	# if ($t0) goto default
	slti	$t1, $a0, 11		# $t1 = (k < 11) [opposite of k > 10]
	beq	$t1, $zero, default	# if (!$t1) goto default

	# If this point has been reached, we use k as an index into the jump
	# table.  We get an appropriate instruction address to jump to
	# by copying an instruction address from the jump table into $t5,
	# then using a jr instruction that is NOT a procedure return.
	sll	$t2, $a0, 2		# $t2 = 4 * k
	la	$t3, jump_table	# $t3 = &jump_table[0]
	add	$t4, $t3, $t2		# $t4 = &jump_table[k]
	lw	$t5, ($t4)			# $t5 = instruction address from jump table 
	jr	$t5				# goto the address found in the jump table
case_0_4_5_9:
	la	$v0, four_let		# result = four_let
	j	end_switch
case_1_2_6_10:
	la	$v0, three_let		# result = three_let
	j	end_switch
case_3_7_8:
	la	$v0, five_let		# result = five_let
	j	end_switch	  
default:
	la	$v0, unknown		# result = unknown
end_switch:	  
	jr	$ra
