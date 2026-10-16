# P11-1  Vector operations: C = A + B, dot product A.B, scaling 3*A
        .data
A:      .word 2, 4, 6, 8, 10, 12, 14, 16
B:      .word 1, 3, 5, 7, 9, 11, 13, 15
C:      .space 32              # 8 words x 4 bytes
N:      .word 8
mC:     .asciiz "C = A + B : "
mDot:   .asciiz "\nA . B     = "

        .text
        .globl main
main:
        la    $s0, A           # base addresses
        la    $s1, B
        la    $s2, C
        lw    $s3, N           # number of elements
        li    $t0, 0           # i = 0
        li    $s4, 0           # dot = 0
loop:
        beq   $t0, $s3, done   # while (i < N)
        sll   $t1, $t0, 2      # byte offset = i * 4
        add   $t2, $s0, $t1
        lw    $t3, 0($t2)      # A[i]
        add   $t2, $s1, $t1
        lw    $t4, 0($t2)      # B[i]
        add   $t5, $t3, $t4    # A[i] + B[i]
        add   $t2, $s2, $t1
        sw    $t5, 0($t2)      # C[i] = A[i] + B[i]
        mul   $t6, $t3, $t4
        add   $s4, $s4, $t6    # dot += A[i] * B[i]
        addi  $t0, $t0, 1      # i++
        j     loop
done:
        li    $v0, 4
        la    $a0, mC
        syscall
        li    $t0, 0
print:                         # print the elements of C
        beq   $t0, $s3, pdone
        sll   $t1, $t0, 2
        add   $t2, $s2, $t1
        lw    $a0, 0($t2)
        li    $v0, 1
        syscall
        li    $v0, 11
        li    $a0, 32          # space
        syscall
        addi  $t0, $t0, 1
        j     print
pdone:
        li    $v0, 4
        la    $a0, mDot
        syscall
        li    $v0, 1
        move  $a0, $s4
        syscall
        li    $v0, 10
        syscall
