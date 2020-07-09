# Makefile for Assembly Testing hifive1-revb
# See Link for example makefile: https://github.com/dwelch67/sifive_samples/blob/master/hifive1b/blinker01/Makefile

RISCVGNU 	= riscv32-unknown-elf

AOPS 		= -march=rv32imac -mabi=ilp32 # Assembly compilation arugments

all : led.o 

DEPS 		:= led.S pwm.S clock.S
OBJS 		:= led.o


clean :
	rm -f *.o
	rm -f *.elf
	rm -f *.bin
	rm -f *.list
	rm -f *.hex

led.o : led.S
	$(RISCVGNU)-as $(AOPS) $(DEPS) -o $(OBJS)
	$(RISCVGNU)-ld $(OBJS) -T memmap -o led.elf 
	$(RISCVGNU)-objcopy led.elf -O ihex led.hex
