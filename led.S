.section .text
.global _start

.include "gpio.inc"
.include "clock.inc"

_start:
	li a1, 0b0 #Set div to 0
	li a2, 0x1F #Set trimmer to 31
	# call _setupRingOscc
	call _pwmEn	
	j exit

_setupGPIO:
	addi sp, sp, -16 # store the return address
	sw ra, 12(sp) # store the return address
	li t0, GPIO_CTRL_ADDR
	li t1, GPIO_LED_ADDR 
	sw t1, GPIO_OUTPUT_EN_OFFSET(t0)
	sw t1, GPIO_OUTPUT_XOR_OFFSET(t0)
	lw ra, 12(sp)
	addi sp, sp, 16
	ret

on:
	sw t1, GPIO_OUTPUT_VAL_OFFSET(t0)

exit:
	li a0, 0
	li a1, 0
	li a2, 0
	li a3, 0
	li a7, 93                   # _NR_sys_exit
	ecall                       # system call	

.section .data
msg:
	.string "hello"
