_start:
    add sp, x0, x0
    la sp, stacks + 0x1000
#     lui sp, %hi()
#     addi sp, sp, %lo(0x81000000)
#    slli sp, sp, 32
#    srli sp, sp, 32
    li x1, 0
    /* skip sp */
    li x3, 0
    li x4, 0
    li x5, 0
    li x6, 0
    li x7, 0
    li x8, 0
    li x9, 0
    li x10, 0
    li x11, 0
    li x12, 0
    li x13, 0
    li x14, 0
    li x15, 0
    li x16, 0
    li x17, 0
    li x18, 0
    li x19, 0
    li x20, 0
    li x21, 0
    li x22, 0
    li x23, 0
    li x24, 0
    li x25, 0
    li x26, 0
    li x27, 0
    li x28, 0
    li x29, 0
    li x30, 0
    li x31, 0 
    jal non_main
    li x1, 0x2333
    ecall

    .bss
    .align 12
stacks:
    .skip 0x1000