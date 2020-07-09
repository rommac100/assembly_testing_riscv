.section .text
.global _setupRingOscc

.include "clock.inc"
# assumes a2= trimmer, a1 = divider
_setupRingOscc:
	addi sp, sp, -16 # move back store pointer to ad return address to the stack
	sw ra, 12(sp) # store return address to the stack
	li t0, PRCI_BASE 
	mv t1, a2 # move a2 to t1 ( trimmer effectively)
	slli t1, t1, 0xC # make it so t1 is at the correct position to be ored
	or t1, t1, a1
	sw t1, HFROSC_CLK_OFFSET(t0)
	lw ra, 12(sp)
	addi sp,sp,16
	ret

	
	
