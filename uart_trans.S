.global _uartTransByte
.global _uartTransLine

.include "uart.inc"

_uartTransLine:
	addi sp, sp, -16 # move back store pointer to ad return address to the stack
	sw ra, 12(sp) # store return address to the stack
	li t0, UART_CTRL_ADDR_0 # load the address for the UART base address
	mv t1, x0 # have t1 be the storage of the byte of the line
	mv t5, a2 # store the address of the string to t5 register for easier manipulation

transLine:
	lb t1, (t5)	
	beqz t1, exit_uart # If at end of string character (i.e ascii 0) exit transfer	
	call transByte
	addi t5,t5, 0x1
	j transLine

transByte:
	lw t2, 0(t0)
	li t3, 0x80000000
	bne t2, t3, transByte
	beq t2, t3, wait

_uartTransByte:
	addi sp, sp, -16 # store the return address
	sw ra, 12(sp) # store the return address
	li t0, UART_CTRL_ADDR_0 # loading UART CTRL ADDR
	
	mv t1, a2
	call transByte
	j exit_uart

send:
	sw t1, 0(t0)		
	li t1, 0b11
	sw t1, TXCTRL(t0)
	ret

exit_uart:
	lw ra, 12(sp)
	addi sp, sp, 16
	ret
