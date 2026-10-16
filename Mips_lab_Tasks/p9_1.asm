# P9-1  First MIPS program: arithmetic and logical instructions on registers
        .text
        .globl main
main:
        li    $t0, 25          # $t0 = 25          (pseudo-instruction: addiu)
        li    $t1, 12          # $t1 = 12
        add   $t2, $t0, $t1    # $t2 = 25 + 12 = 37
        sub   $t3, $t0, $t1    # $t3 = 25 - 12 = 13
        addi  $t4, $t0, -5     # $t4 = 25 - 5  = 20   (immediate operand)
        and   $t5, $t0, $t1    # $t5 = 11001 AND 01100 = 01000 = 8
        or    $t6, $t0, $t1    # $t6 = 11001 OR  01100 = 11101 = 29
        sll   $t7, $t1, 2      # $t7 = 12 << 2 = 48  (multiply by 4)

        li    $v0, 1           # syscall 1: print integer in $a0
        move  $a0, $t2
        syscall
        li    $v0, 11          # syscall 11: print character in $a0
        li    $a0, ' '
        syscall
        li    $v0, 1
        move  $a0, $t7
        syscall

        li    $v0, 10          # syscall 10: exit
        syscall
