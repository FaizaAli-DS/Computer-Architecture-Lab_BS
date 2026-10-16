# P10-1  SPIM system calls: read integers and a string, print results
        .data
ask1:   .asciiz "Enter first integer : "
ask2:   .asciiz "Enter second integer: "
askn:   .asciiz "Enter your name     : "
summ:   .asciiz "Sum = "
prodm:  .asciiz "\nProduct = "
hello:  .asciiz "Welcome to the MIPS lab, "
name:   .space 32              # buffer for the name (32 bytes)

        .text
        .globl main
main:
        li    $v0, 4           # print string
        la    $a0, ask1
        syscall
        li    $v0, 5           # read integer -> $v0
        syscall
        move  $s0, $v0

        li    $v0, 4
        la    $a0, ask2
        syscall
        li    $v0, 5
        syscall
        move  $s1, $v0

        li    $v0, 4
        la    $a0, summ
        syscall
        add   $a0, $s0, $s1
        li    $v0, 1           # print integer
        syscall

        li    $v0, 4
        la    $a0, prodm
        syscall
        mul   $a0, $s0, $s1    # pseudo-instruction (mult + mflo)
        li    $v0, 1
        syscall

        li    $v0, 11          # print character: newline
        li    $a0, 10          # ASCII 10 = newline
        syscall

        li    $v0, 4
        la    $a0, askn
        syscall
        li    $v0, 8           # read string: $a0 = buffer, $a1 = length
        la    $a0, name
        li    $a1, 32
        syscall

        li    $v0, 4
        la    $a0, hello
        syscall
        li    $v0, 4
        la    $a0, name
        syscall

        li    $v0, 10
        syscall
