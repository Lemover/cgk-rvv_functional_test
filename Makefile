####################################
# This intends to be a simple test suit for RISC-V Vector Extension (RVV)
# licensed under BSD-3-Clause
####################################

####################
# basic info
####################

CROSS_PATH = /nfs/home/zhangzifei/rvv/cgk/rvv/build/bin
PREFIX = llvm-
CC = ${CROSS_PATH}/clang-12
OBJCOPY = ${CROSS_PATH}/${PREFIX}objcopy
OBJDUMP = ${CROSS_PATH}/${PREFIX}objdump
LDSCRIPT = linker.ld
C_SOURCES = $(shell find ./ -name '*.c')

# BUILD_DIR = build

# Note that we use clang to compile RVV assembly
# CFLAGS = -menable-experimental-extensions -march=rv64gv1p0 -nostdlib -nostdinc -T ${LDSCRIPT} -fno-builtin -ffreestanding  -mabi=lp64  -mcmodel=medium
CFLAGS = -menable-experimental-extensions -march=rv64gv0p9 -nostdlib -T ${LDSCRIPT} -mcmodel=medany
####################
# build rules
####################

OBJECTS = $(notdir $(C_SOURCES:.c=.elf))
OBJECTS_BIN = $(OBJECTS:.elf=.bin)
OBJECTS_DISASSEMBLY = $(OBJECTS:.elf=.disass)

all: VIRTUAL_TARGET

${OBJECTS}: %.elf: %.c
	$(CC) start.S $< $(CFLAGS) -o $@

%.bin: ${OBJECTS}
	$(OBJCOPY) -O binary $< $@

%.disass: ${OBJECTS}
	$(OBJDUMP) -d $< > $@

DEBUG: ${OBJECTS}
	@echo "DEBUG"
	@echo $<

VIRTUAL_TARGET: ${DEBUG} ${OBJECTS_BIN} ${OBJECTS_DISASSEMBLY}
	cp main.bin RV_BOOT.bin
	@echo "Voila!"

clean:
	rm *.elf
	rm *.bin
	rm *.disass
	rm *.o
