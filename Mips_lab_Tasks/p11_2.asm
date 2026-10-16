# P11-2  Loop unrolling: sum of a 16-element array, rolled vs unrolled by 4
        .data
arr:    .word 5, 9, 2, 7, 4, 8, 1, 6, 3, 10, 12, 11, 15, 13, 14, 16
m1:     .asciiz "Rolled loop sum    = "
m2:     .asciiz "\nUnrolled loop sum  = "
m3:     .asciiz "\nInstructions in loop body executed (rolled / unrolled): "
m4:     .asciiz " / "

        .text
        .globl main
main:
        # ---------- rolled loop: 1 element per iteration ----------
        la    $t0, arr         # pointer
        addi  $t1, $t0, 64     # end address = arr + 16*4
        li    $s0, 0           # sum
        li    $s2, 0           # instruction counter (for measurement only)
rolled:
        lw    $t2, 0($t0)
        add   $s0, $s0, $t2
        addi  $t0, $t0, 4
        addi  $s2, $s2, 4      # 4 instructions in this body (incl. bne)
        bne   $t0, $t1, rolled

        # ---------- unrolled loop: 4 elements per iteration ----------
        la    $t0, arr
        li    $s1, 0
        li    $s3, 0
unrolled:
        lw    $t2, 0($t0)
        lw    $t3, 4($t0)
        lw    $t4, 8($t0)
        lw    $t5, 12($t0)
        add   $s1, $s1, $t2
        add   $s1, $s1, $t3
        add   $s1, $s1, $t4
        add   $s1, $s1, $t5
        addi  $t0, $t0, 16     # advance by 4 elements
        addi  $s3, $s3, 10     # 10 instructions in this body (incl. bne)
        bne   $t0, $t1, unrolled

        li    $v0, 4
        la    $a0, m1
        syscall
        li    $v0, 1
        move  $a0, $s0
        syscall
        li    $v0, 4
        la    $a0, m2
        syscall
        li    $v0, 1
        move  $a0, $s1
        syscall
        li    $v0, 4
        la    $a0, m3
        syscall
        li    $v0, 1
        move  $a0, $s2
        syscall
        li    $v0, 4
        la    $a0, m4
        syscall
        li    $v0, 1
        move  $a0, $s3
        syscall
        li    $v0, 10
        syscall
