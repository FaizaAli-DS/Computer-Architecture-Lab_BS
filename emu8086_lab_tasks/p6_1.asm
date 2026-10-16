; P6-1  Counted loops with LOOP: print 1..9 and the sum 1+2+...+N
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
nums db 'Counting  : $'
summ db 'Sum 1..N  = $'
n    dw 10

.code
main proc
    mov ax, @data
    mov ds, ax

    ; ---- for i = 1 to 9 : print i ----
    print nums
    mov cx, 9            ; loop counter
    mov dl, '1'
next_digit:
    mov ah, 02h
    int 21h              ; display DL
    inc dl
    loop next_digit      ; CX = CX - 1, jump if CX != 0
    newline

    ; ---- sum = 1 + 2 + ... + N ----
    mov cx, n            ; CX = N = 10
    mov ax, 0
add_next:
    add ax, cx           ; adds N, N-1, ..., 1
    loop add_next
    print summ
    call print_snum      ; 55
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
