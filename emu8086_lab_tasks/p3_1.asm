; P3-1  Macros for input/output: read a lowercase letter, display it in uppercase
.model small
.stack 100h

; ---------- macro definitions ----------
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

readch macro             ; read one key with echo, result in AL
    mov ah, 01h
    int 21h
endm

putch macro char           ; display one character
    mov dl, char
    mov ah, 02h
    int 21h
endm

.data
prompt db 'Enter a lowercase letter: $'
result db 'In uppercase: $'

.code
main proc
    mov ax, @data
    mov ds, ax

    print prompt
    readch               ; AL = ASCII code of the key, e.g. 'g' = 67h
    mov bl, al
    sub bl, 20h          ; 'a'(61h) - 20h = 'A'(41h)
    newline
    print result
    putch bl

    mov ah, 4Ch
    int 21h
main endp
end main
