; P8-2  Macros with parameters versus procedures
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

; putch: display one character
putch macro char
    push ax
    push dx
    mov dl, char
    mov ah, 02h
    int 21h
    pop dx
    pop ax
endm

; swap: exchange two word variables
swap macro p, q
    push ax
    mov ax, p
    xchg ax, q
    mov p, ax
    pop ax
endm

; sum3: dest = p + q + r  (three word variables)
sum3 macro dest, p, q, r
    push ax
    mov ax, p
    add ax, q
    add ax, r
    mov dest, ax
    pop ax
endm

.data
x     dw 31
y     dw 84
z     dw 15
total dw ?
m1    db 'Before swap: X = $'
m2    db 'After swap : X = $'
my    db ', Y = $'
m3    db 'X + Y + Z  = $'

.code
main proc
    mov ax, @data
    mov ds, ax

    print m1
    mov ax, x
    call print_snum
    print my
    mov ax, y
    call print_snum
    newline

    swap x, y            ; expanded in place by the assembler

    print m2
    mov ax, x
    call print_snum
    print my
    mov ax, y
    call print_snum
    newline

    sum3 total, x, y, z  ; total = 84 + 31 + 15
    print m3
    mov ax, total
    call print_snum
    putch '!'

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
