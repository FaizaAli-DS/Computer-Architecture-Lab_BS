# P9-2  Memory access with load/store: z = x + y - 5
        .data
x:      .word 120
y:      .word -45
z:      .word 0
msg:    .asciiz "z = x + y - 5 = "

        .text
        .globl main
main:
        lw    $t0, x           # $t0 = Mem[x] = 120
        lw    $t1, y           # $t1 = Mem[y] = -45
        add   $t2, $t0, $t1    # $t2 = 75
        addi  $t2, $t2, -5     # $t2 = 70
        sw    $t2, z           # Mem[z] = 70

        li    $v0, 4           # print the message
        la    $a0, msg
        syscall
        li    $v0, 1           # print z (read back from memory)
        lw    $a0, z
        syscall

        li    $v0, 10
        syscall
