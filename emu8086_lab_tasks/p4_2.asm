; P4-2  Arithmetic instructions: evaluate  result = (A * B + C) / D
.model small
.stack 100h

print macro msg          ; display a '$'-terminated string (AX, DX preserved)
    push ax
    push dx
    lea dx, msg
    mov ah, 09h
    int 21h
    pop dx
    pop ax
endm

newline macro            ; carriage return + line feed (AX, DX preserved)
    push ax
    push dx
    mov dl, 13
    mov ah, 02h
    int 21h
    mov dl, 10
    mov ah, 02h
    int 21h
    pop dx
    pop ax
endm

.data
numA dw 25
numB dw 12
numC dw 7
numD dw 9
m1   db 'A * B         = $'
m2   db 'A * B + C     = $'
m3   db '(A*B + C) / D = $'
m4   db 'remainder     = $'
m5   db 'C - A         = $'

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ax, numA
    mul numB               ; DX:AX = A * B = 300 (unsigned multiply)
    print m1
    call print_snum
    newline

    add ax, numC           ; AX = 307
    print m2
    call print_snum
    newline

    mov dx, 0           ; clear DX before a 16-bit divide
    div numD               ; AX = 307 / 9 = 34, DX = 307 mod 9 = 1
    mov bx, dx          ; keep the remainder
    print m3
    call print_snum
    newline
    print m4
    mov ax, bx
    call print_snum
    newline

    mov ax, numC
    sub ax, numA           ; AX = C - A = 7 - 25 = -18 (negative result, SF = 1)
    print m5
    call print_snum

    mov ah, 4Ch
    int 21h
main endp

; print_snum: display the signed number in AX in decimal
print_snum proc
    push ax
    push bx
    push cx
    push dx
    test ax, ax
    jns ps_pos
    push ax
    mov dl, '-'          ; negative: print the sign
    mov ah, 02h
    int 21h
    pop ax
    neg ax               ; make it positive (two's complement)
ps_pos:
    mov cx, 0
    mov bx, 10
ps_div:
    mov dx, 0
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne ps_div
ps_out:
    pop dx
    add dl, 30h
    mov ah, 02h
    int 21h
    loop ps_out
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_snum endp
end main
