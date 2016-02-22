CC=sdcc
CFLAGS=-mz80 --std-sdcc99 --reserve-regs-iy --max-allocs-per-node 30000
ASM=sdasz80
AFLAGS=-p -g -o

game_of_life.8xp: game_of_life.bin
	binpac8x.py -O conway game_of_life.bin

game_of_life.bin: game_of_life.ihx
	hex2bin game_of_life.ihx

game_of_life.ihx: game_of_life.c inc/tios_crt0.rel inc/ti84plus.rel inc/fastcopy.rel
	$(CC) $(CFLAGS) --code-loc 0x9D9B --data-loc 0 --no-std-crt0 \
		inc/tios_crt0.rel inc/ti84plus.rel inc/fastcopy.rel game_of_life.c

inc/ti84plus.rel: inc/ti84plus.c
	$(CC) $(CFLAGS) -c inc/ti84plus.c -o  inc/ti84plus.rel

inc/fastcopy.rel: inc/fastcopy.asm
	$(ASM) $(AFLAGS) inc/fastcopy.asm

inc/tios_crt0.rel: inc/tios_crt0.s
	$(ASM) $(AFLAGS) inc/tios_crt0.s

.PHONY: clean
clean:
	rm -f game_of_life.8xp game_of_life.bin game_of_life.bin game_of_life.ihx
	rm -f *.asm *.lst *.sym *.lk *.map *.noi *.rel
	rm -f inc/*.rel inc/*.sym inc/*.lk inc/*.map inc/*.noi
	rm -f inc/ti84plus.asm
