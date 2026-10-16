; P7-2  Linear search and bubble sort on a byte array
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
list   db 29, 7, 18, 3, 25, 11
n      equ 6
key    db 25
foundm db 'Key 25 found at index $'
nfm    db 'Key not found$'
beforem db 'Before sort: $'
afterm db 'After sort : $'

.code
main proc
    mov ax, @data
    mov ds, ax

    ; ---- linear search ----
    mov si, 0
    mov cx, n
    mov al, key
search:
    cmp list[si], al
    je  found
    inc si
    loop search
    print nfm
    jmp search_end
found:
    print foundm
    mov ax, si
    call print_snum      ; index 4
search_end:
    newline

    print beforem
    call show_list
    newline

    ; ---- bubble sort (ascending) ----
    mov cx, n-1          ; number of passes
pass:
    push cx
    mov si, 0
compare:
    mov al, list[si]
    cmp al, list[si+1]
    jbe no_swap
    xchg al, list[si+1]  ; swap the two neighbours
    mov list[si], al
no_swap:
    inc si
    loop compare
    pop cx
    loop pass

    print afterm
    call show_list

    mov ah, 4Ch
    int 21h
main endp

; show_list: display all elements of list separated by spaces
show_list proc
    push si
    push cx
    push ax
    mov si, 0
    mov cx, n
sl_next:
    mov al, list[si]
    mov ah, 0
    call print_snum
    mov dl, ' '
    mov ah, 02h
    int 21h
    inc si
    loop sl_next
    pop ax
    pop cx
    pop si
    ret
show_list endp

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
