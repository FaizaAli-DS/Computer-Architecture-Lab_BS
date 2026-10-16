; P2-1  Example Assembly Program
; Adds 158 to a number stored in memory
.model small
.stack 100h

.data
number dw -105
sum    dw ?

.code
main proc
    mov ax, @data       ; initialise DS with the data segment address
    mov ds, ax

    mov ax, number      ; AX = -105
    add ax, 158         ; AX = -105 + 158 = 53
    mov sum, ax         ; store the result in memory

    mov ah, 4Ch         ; terminate the program
    int 21h
main endp
end main
