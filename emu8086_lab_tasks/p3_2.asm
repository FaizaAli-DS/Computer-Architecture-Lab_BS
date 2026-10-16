; P3-2  Data conversion: ASCII digits -> number -> decimal display
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
msg1 db 'Enter first digit : $'
msg2 db 'Enter second digit: $'
msg3 db 'Sum = $'
num1 db ?

.code
main proc
    mov ax, @data
    mov ds, ax

    print msg1
    mov ah, 01h          ; read first digit, e.g. '7' = 37h
    int 21h
    sub al, 30h          ; ASCII -> number : 37h - 30h = 7
    mov num1, al
    newline

    print msg2
    mov ah, 01h          ; read second digit
    int 21h
    sub al, 30h
    add al, num1         ; AL = binary sum (0..18)
    newline

    mov ah, 0            ; AX = sum
    push ax
    print msg3
    pop ax
    call print_num       ; number -> decimal ASCII on screen

    mov ah, 4Ch
    int 21h
main endp

; print_num: display the unsigned number in AX in decimal
print_num proc
    push ax
    push bx
    push cx
    push dx
    mov cx, 0            ; digit counter
    mov bx, 10
pn_div:
    mov dx, 0
    div bx               ; AX = AX / 10, DX = remainder (next digit)
    push dx              ; save digit on stack
    inc cx
    cmp ax, 0
    jne pn_div
pn_out:
    pop dx               ; digits come out in the correct order
    add dl, 30h          ; number -> ASCII
    mov ah, 02h
    int 21h
    loop pn_out
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_num endp
end main
