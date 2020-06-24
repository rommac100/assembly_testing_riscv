# Makefile for Assembly Testing hifive1-revb
# See Link for example makefile: https://github.com/dwelch67/sifive_samples/blob/master/hifive1b/blinker01/Makefile

RISCVGNU = riscv32-unknown-elf

AOPS = -march=rv32imac -mabi=ilp32 # Assembly compilation arugments

all : led.o 

clean :
	rm -f *.o
	rm -f *.elf
	rm -f *.bin
	rm -f *.list
	rm -f *.hex

led.o : led.S
	$(RISCVGNU)-as $(AOPS) led.S -o led.o
	$(RISCVGNU)-ld led.o -T memmap -o led.elf 
	$(RISCVGNU)-objcopy led.elf -O ihex led.hex
