; P6-2  Nested loops (triangle of stars) and a while loop (factorial)
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
rows  dw 5
facm  db '6! = $'

.code
main proc
    mov ax, @data
    mov ds, ax

    ; ---- nested loop: row r prints r stars ----
    mov bx, 1            ; BX = current row
outer:
    mov cx, bx           ; inner loop runs BX times
inner:
    mov dl, '*'
    mov ah, 02h
    int 21h
    loop inner
    newline
    inc bx
    cmp bx, rows
    jbe outer            ; repeat while row <= 5

    ; ---- while (n > 1) { fact = fact * n; n-- } ----
    mov ax, 1            ; fact
    mov cx, 6            ; n
while_top:
    cmp cx, 1
    jbe while_end        ; exit when n <= 1
    mul cx               ; DX:AX = AX * CX
    dec cx
    jmp while_top
while_end:
    print facm
    call print_snum      ; 720
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
