# P10-2  Procedures in MIPS: a leaf procedure and a recursive procedure
        .data
m1:     .asciiz "max(17, 42) = "
m2:     .asciiz "\nfactorial(6) = "

        .text
        .globl main
main:
        li    $a0, 17          # arguments in $a0, $a1
        li    $a1, 42
        jal   max              # $ra = return address, jump to max
        move  $s0, $v0         # result returned in $v0

        li    $v0, 4
        la    $a0, m1
        syscall
        li    $v0, 1
        move  $a0, $s0
        syscall

        li    $a0, 6
        jal   fact
        move  $s0, $v0
        li    $v0, 4
        la    $a0, m2
        syscall
        li    $v0, 1
        move  $a0, $s0
        syscall

        li    $v0, 10
        syscall

# ---- max(a, b): leaf procedure, needs no stack frame ----
max:
        move  $v0, $a0
        bge   $a0, $a1, max_done   # if a >= b return a
        move  $v0, $a1             # else return b
max_done:
        jr    $ra

# ---- fact(n) = n * fact(n-1): non-leaf, saves $ra and $a0 on the stack ----
fact:
        addi  $sp, $sp, -8     # make room for 2 words
        sw    $ra, 4($sp)      # save return address
        sw    $a0, 0($sp)      # save argument n
        li    $t0, 2
        bge   $a0, $t0, fact_rec
        li    $v0, 1           # base case: n < 2 -> 1
        addi  $sp, $sp, 8
        jr    $ra
fact_rec:
        addi  $a0, $a0, -1
        jal   fact             # $v0 = fact(n-1)
        lw    $a0, 0($sp)      # restore n
        lw    $ra, 4($sp)      # restore return address
        addi  $sp, $sp, 8      # pop the stack frame
        mul   $v0, $a0, $v0    # n * fact(n-1)
        jr    $ra
