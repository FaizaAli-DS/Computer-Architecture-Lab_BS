; P6-3  Sentinel-controlled loop: count the vowels in a line typed by the user
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
ask  db 'Type a sentence and press Enter: $'
res  db 'Number of vowels = $'

.code
main proc
    mov ax, @data
    mov ds, ax

    print ask
    mov bx, 0            ; vowel counter
read_loop:
    mov ah, 01h
    int 21h              ; AL = next character
    cmp al, 13           ; Enter key ends the loop
    je  read_end
    or  al, 20h          ; convert letters to lowercase
    cmp al, 'a'
    je  vowel
    cmp al, 'e'
    je  vowel
    cmp al, 'i'
    je  vowel
    cmp al, 'o'
    je  vowel
    cmp al, 'u'
    je  vowel
    jmp read_loop
vowel:
    inc bx
    jmp read_loop
read_end:
    newline
    print res
    mov ax, bx
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
