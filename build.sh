nasm boot/kernel_entry.asm -f elf -o kernel_entry.o
i686-linux-gnu-gcc -fno-pie -ffreestanding -c kernel/kernel.c -o kernel.o

i686-linux-gnu-ld -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary


nasm boot/boot.asm -f bin -o boot.bin


cat boot.bin kernel.bin > os-image.bin
