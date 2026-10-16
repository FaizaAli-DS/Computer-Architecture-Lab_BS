; P1-1  Observing registers, flags and byte ordering
.model small
.stack 100h
.data
value dd 0A2B1C3D4h          ; 32-bit value stored in memory

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ax, 1234h            ; AH = 12h, AL = 34h
    mov bl, ah               ; BL = 12h
    mov bh, al               ; BH = 34h  -> BX = 3412h

    mov al, 0FFh
    add al, 1                ; AL = 00h  -> CF = 1, ZF = 1

    mov al, 7Fh
    add al, 1                ; AL = 80h  -> OF = 1, SF = 1

    mov cx, word ptr value   ; low word  (stored first)  CX = C3D4h
    mov dx, word ptr value+2 ; high word (stored second) DX = A2B1h

    mov ah, 4Ch              ; return to operating system
    int 21h
main endp
end main
