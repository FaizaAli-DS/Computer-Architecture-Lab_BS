; P5-1  Branching: even or odd, and the larger of two signed numbers
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
ask   db 'Enter a digit (0-9): $'
evenm db ' is EVEN$'
oddm  db ' is ODD$'
x     dw -12
y     dw 7
bigm  db 'Larger of X and Y = $'

.code
main proc
    mov ax, @data
    mov ds, ax

    ; ---- if (digit is even) ... else ... ----
    print ask
    mov ah, 01h
    int 21h              ; AL = ASCII digit
    sub al, 30h
    test al, 1           ; ZF = 1 when bit 0 is 0 (even)
    jnz is_odd
    print evenm
    jmp done_eo
is_odd:
    print oddm
done_eo:
    newline

    ; ---- signed comparison: max(X, Y) ----
    mov ax, x
    cmp ax, y            ; compares -12 with 7
    jge x_bigger         ; signed jump: -12 >= 7 is false
    mov ax, y
x_bigger:
    print bigm
    call print_snum
    newline

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
