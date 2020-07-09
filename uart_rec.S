.global _uartRecByte

.include "uart.inc"

_uartRecByte:
	addi sp, sp, -16 # move back store pointer to ad return address to the stack
	sw ra, 12(sp) # store return address to the stack
	li t0, UART_CTRL_ADDR_0 # Load UART CTRL Address
	li t1, 0x1
	sw t1, RXCTRL(t0) # just enable the rx pin

receive:
	lw t1, RXDATA(t0)  # get current Register read data
	mv t2, x0 
	and t2, t1,t2
	beqz t2, receive
	mv a2, t1

exit_rec:
	addi sp, sp, 16
	lw ra, 12(sp)
	mv t1, x0
	sw t1, RXCTRL(t0)
	ret
	
