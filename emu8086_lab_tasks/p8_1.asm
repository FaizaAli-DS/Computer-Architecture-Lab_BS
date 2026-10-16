; P8-1  Procedures: parameters in registers, parameters on the stack, recursion
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
n1   dw 150
n2   dw 275
m1   db 'square(12)        = $'
m2   db 'add_two(150, 275) = $'
m3   db 'factorial(7)      = $'

.code
main proc
    mov ax, @data
    mov ds, ax

    ; (1) parameter passed in a register
    mov ax, 12
    call square          ; returns AX = 144
    print m1
    call print_snum
    newline

    ; (2) parameters passed on the stack
    push n1
    push n2
    call add_two         ; returns AX = 425
    add sp, 4            ; caller removes the 2 parameters
    print m2
    call print_snum
    newline

    ; (3) recursive procedure
    mov ax, 7
    call fact            ; returns AX = 5040
    print m3
    call print_snum
    newline

    mov ah, 4Ch
    int 21h
main endp

; square: AX = AX * AX
square proc
    push dx
    mul ax
    pop dx
    ret
square endp

; add_two: AX = first parameter + second parameter (both on the stack)
add_two proc
    push bp
    mov bp, sp           ; [bp+2] = return address
    mov ax, [bp+4]       ; second value pushed (n2)
    add ax, [bp+6]       ; first value pushed  (n1)
    pop bp
    ret
add_two endp

; fact: AX = AX!  (recursive: n! = n * (n-1)!)
fact proc
    cmp ax, 1
    jbe fact_base        ; 0! = 1! = 1
    push ax              ; save n
    dec ax
    call fact            ; AX = (n-1)!
    pop bx               ; BX = n
    mul bx               ; AX = n * (n-1)!
    ret
fact_base:
    mov ax, 1
    ret
fact endp

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
