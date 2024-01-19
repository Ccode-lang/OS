# Compile kernel objects
nasm boot/kernel_entry.asm -f elf -o kernel_entry.o
i686-linux-gnu-gcc -fno-pie -ffreestanding -c kernel/kernel.c -o kernel.o
i686-linux-gnu-gcc -fno-pie -ffreestanding -c kernel/util.c -o util.o

# Compile drivers
i686-linux-gnu-gcc -fno-pie -ffreestanding -c drivers/ports.c -o ports.o
i686-linux-gnu-gcc -fno-pie -ffreestanding -c drivers/screen.c -o screen.o

# Link kernel and drivers
i686-linux-gnu-ld -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o util.o ports.o screen.o --oformat binary

# Compile boot sector
nasm boot/boot.asm -f bin -o boot.bin

# Concatenate Kernel and boot sector
cat boot.bin kernel.bin > os-image.bin
