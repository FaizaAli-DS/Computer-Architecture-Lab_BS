; P7-1  Array processing: sum, average, maximum and minimum of a word array
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
arr   dw 45, 12, 78, 3, 56, 91, 27, 64
len   equ 8              ; number of elements
summ  db 'Sum     = $'
avgm  db 'Average = $'
maxm  db 'Maximum = $'
minm  db 'Minimum = $'
total dw ?

.code
main proc
    mov ax, @data
    mov ds, ax

    ; ---- sum and average (SI indexes the array) ----
    mov si, 0
    mov cx, len
    mov ax, 0
sum_loop:
    add ax, arr[si]      ; based-indexed addressing
    add si, 2            ; next word = 2 bytes further
    loop sum_loop
    mov total, ax
    print summ
    call print_snum
    newline
    mov dx, 0
    mov bx, len
    div bx               ; AX = sum / len
    print avgm
    call print_snum
    newline

    ; ---- maximum and minimum (BX points to the array) ----
    lea bx, arr
    mov ax, [bx]         ; max = first element
    mov dx, [bx]         ; min = first element
    mov cx, len-1
mm_loop:
    add bx, 2
    cmp [bx], ax
    jle not_max
    mov ax, [bx]
not_max:
    cmp [bx], dx
    jge not_min
    mov dx, [bx]
not_min:
    loop mm_loop
    print maxm
    call print_snum
    newline
    mov ax, dx
    print minm
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
