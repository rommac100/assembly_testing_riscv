.global _delay
.include "timer.inc"

_delay:
	addi sp, sp, -16 # store the return address
	sw ra 12[sp] # store the return address]

	li t2, MTIME_ADDR # load timer register
	lw t3, 0(t2)	 # get current time

	
	
