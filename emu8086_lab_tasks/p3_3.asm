; P3-3  Buffered string input (INT 21h, AH = 0Ah) and hexadecimal display
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
prompt db 'Enter your name: $'
hello  db 'Hello, $'
lenmsg db 'Length of name (hex) = $'
buf    db 20             ; byte 0: maximum characters allowed
       db ?              ; byte 1: characters actually typed (filled by DOS)
       db 20 dup('$')    ; bytes 2..: the characters themselves

.code
main proc
    mov ax, @data
    mov ds, ax

    print prompt
    lea dx, buf
    mov ah, 0Ah          ; buffered keyboard input
    int 21h
    newline

    print hello
    lea dx, buf+2        ; the typed text starts at buf+2
    mov ah, 09h
    int 21h
    newline

    print lenmsg
    mov al, buf+1        ; number of characters typed
    mov bl, al
    mov cl, 4
    shr al, cl           ; high nibble
    call hex_digit
    mov al, bl
    and al, 0Fh          ; low nibble
    call hex_digit

    mov ah, 4Ch
    int 21h
main endp

; hex_digit: display the value 0..15 in AL as one hex character
hex_digit proc
    cmp al, 9
    jbe hd_num
    add al, 7            ; 'A'..'F' are 7 places after '9'+1
hd_num:
    add al, 30h
    mov dl, al
    mov ah, 02h
    int 21h
    ret
hex_digit endp
end main
