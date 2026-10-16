# P12-1  Direct-mapped cache simulator
# Cache: 8 lines, block size 16 bytes  ->  offset = 4 bits, index = 3 bits,
#        tag = remaining upper bits.   Address trace is read from memory.
        .data
trace:  .word 0, 4, 16, 20, 132, 0, 36, 40, 132, 16   # byte addresses
N:      .word 10
valid:  .space 32              # 8 valid bits (one word each)
tags:   .space 32              # 8 tags
hdr:    .asciiz "Address\tIndex\tTag\tResult\n"
hitm:   .asciiz "\tHIT\n"
missm:  .asciiz "\tMISS\n"
sp2:    .asciiz "\t"
resm:   .asciiz "\nHits = "
ofm:    .asciiz " out of "

        .text
        .globl main
main:
        li    $v0, 4
        la    $a0, hdr
        syscall
        la    $s0, trace
        lw    $s1, N
        li    $s2, 0           # i
        li    $s3, 0           # hit counter
next:
        beq   $s2, $s1, finish
        sll   $t0, $s2, 2
        add   $t0, $s0, $t0
        lw    $t1, 0($t0)      # $t1 = address
        srl   $t2, $t1, 4      # drop the 4 offset bits
        andi  $t3, $t2, 7      # index = next 3 bits
        srl   $t4, $t2, 3      # tag   = the rest

        move  $a0, $t1         # print address, index and tag
        li    $v0, 1
        syscall
        li    $v0, 4
        la    $a0, sp2
        syscall
        move  $a0, $t3
        li    $v0, 1
        syscall
        li    $v0, 4
        la    $a0, sp2
        syscall
        move  $a0, $t4
        li    $v0, 1
        syscall

        sll   $t5, $t3, 2      # word offset of this cache line
        la    $t6, valid
        add   $t6, $t6, $t5
        la    $t7, tags
        add   $t7, $t7, $t5
        lw    $t8, 0($t6)      # valid bit
        lw    $t9, 0($t7)      # stored tag
        beq   $t8, $zero, miss # line empty -> miss
        bne   $t9, $t4, miss   # different tag -> miss (conflict)
        addi  $s3, $s3, 1      # hit
        li    $v0, 4
        la    $a0, hitm
        syscall
        j     advance
miss:
        li    $t8, 1           # bring the block into the cache
        sw    $t8, 0($t6)
        sw    $t4, 0($t7)
        li    $v0, 4
        la    $a0, missm
        syscall
advance:
        addi  $s2, $s2, 1
        j     next
finish:
        li    $v0, 4
        la    $a0, resm
        syscall
        move  $a0, $s3
        li    $v0, 1
        syscall
        li    $v0, 4
        la    $a0, ofm
        syscall
        move  $a0, $s1
        li    $v0, 1
        syscall
        li    $v0, 10
        syscall
