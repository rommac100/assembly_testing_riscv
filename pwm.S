.global _pwmEn

.include "pwm.inc"
.include "gpio.inc"
	
_pwmEn:
	addi sp, sp, -16 # move back store pointer to ad return address to the stack
	sw ra, 12(sp) # store return address to the stack
	li t3, GPIO_LED_ADDR
	li t2, GPIO_CTRL_ADDR
	li t0, PWM1_BASE # Store default ctrl address for pwm0
	li t1, 0x00001002 # Set pwmscale = F, zerocmp=1, pwmalways=1,pwmoneshot=1
	sw x0, PWMCFG(t0)
	sw x0, PWMCMP0(t0)
	sw x0, PWMCMP1(t0)
	sw x0, PWMCMP2(t0)
	sw x0, PWMCMP3(t0)
	sw x0, PWMSCALE(t0)
	sw x0, PWMCOUNT(t0)
	sw t1, PWMCFG(t0) # Set frequency to roughly 1khz, continously send
	li t1, 0x1FFF # setting duty cycle to 50%
	sw t1, PWMCMP1(t0)
	sw t1, PWMCMP2(t0)
	sw t1, PWMCMP3(t0)
	sw x0, PWMCOUNT(t0)
	sw t3, GPIO_IOF_OFFSET_EN(t2)
	sw t3, GPIO_IOF_OFFSET_SEL(t2)
	
exit_pwm:
	lw ra, 12(sp)
	addi sp, sp, 16
	ret
