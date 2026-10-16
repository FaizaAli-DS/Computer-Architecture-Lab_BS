# P13-1  Virtual-to-physical address translation with a page table
# 16-bit virtual address, page size 4 KB  ->  VPN = upper 4 bits,
# offset = lower 12 bits.  The page table has 16 entries (valid bit, frame no.).
        .data
valid:  .word 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1
frame:  .word 5, 2, 0, 7, 0, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 6
vaddr:  .word 0x1A3C, 0x0004, 0x3FFF, 0x2100, 0x5123, 0x8ABC, 0xF00F, 0x7777
N:      .word 8
hdr:    .asciiz "VA    VPN OFFSET -> PA\n"
tab:    .asciiz "  "
tab3:   .asciiz "   "
arrow:  .asciiz "    -> "
fault:  .asciiz "PAGE FAULT\n"
nl:     .asciiz "\n"
faults: .asciiz "\nPage faults = "

        .text
        .globl main
main:
        li    $v0, 4
        la    $a0, hdr
        syscall
        la    $s0, vaddr
        lw    $s1, N
        li    $s2, 0           # i
        li    $s3, 0           # page-fault counter
next:
        beq   $s2, $s1, finish
        sll   $t0, $s2, 2
        add   $t0, $s0, $t0
        lw    $s4, 0($t0)      # $s4 = virtual address
        srl   $s5, $s4, 12     # VPN    = VA >> 12
        andi  $s6, $s4, 0x0FFF # offset = VA & 0xFFF

        move  $a0, $s4         # print VA, VPN, offset in hex
        li    $a1, 4
        jal   print_hex
        li    $v0, 4
        la    $a0, tab
        syscall
        move  $a0, $s5
        li    $a1, 1
        jal   print_hex
        li    $v0, 4
        la    $a0, tab3
        syscall
        move  $a0, $s6
        li    $a1, 3
        jal   print_hex
        li    $v0, 4
        la    $a0, arrow
        syscall

        sll   $t1, $s5, 2      # look up the page-table entry
        la    $t2, valid
        add   $t2, $t2, $t1
        lw    $t3, 0($t2)
        beq   $t3, $zero, pf   # valid bit = 0 -> page fault
        la    $t2, frame
        add   $t2, $t2, $t1
        lw    $t4, 0($t2)      # frame number
        sll   $t4, $t4, 12     # PA = frame << 12 | offset
        or    $a0, $t4, $s6
        li    $a1, 4
        jal   print_hex
        li    $v0, 4
        la    $a0, nl
        syscall
        j     advance
pf:
        addi  $s3, $s3, 1
        li    $v0, 4
        la    $a0, fault
        syscall
advance:
        addi  $s2, $s2, 1
        j     next
finish:
        li    $v0, 4
        la    $a0, faults
        syscall
        li    $v0, 1
        move  $a0, $s3
        syscall
        li    $v0, 10
        syscall

# print_hex: print the lowest $a1 hex digits of $a0 (leaf procedure)
print_hex:
        move  $t8, $a0
        addi  $t9, $a1, -1     # digit position, from most significant
ph_loop:
        sll   $t7, $t9, 2      # shift = position * 4
        srlv  $t6, $t8, $t7
        andi  $t6, $t6, 0xF
        addi  $a0, $t6, 48     # '0'..'9'
        blt   $t6, 10, ph_put
        addi  $a0, $t6, 55     # 'A'..'F'
ph_put:
        li    $v0, 11
        syscall
        addi  $t9, $t9, -1
        bge   $t9, $zero, ph_loop
        jr    $ra
