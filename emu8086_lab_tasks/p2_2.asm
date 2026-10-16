; P2-2  Data definition directives and displaying a message
.model small
.stack 100h

.data
msg     db 'Welcome to Computer Architecture Lab!$'
byteVar db 25            ; 8-bit variable
wordVar dw 1000          ; 16-bit variable
list    db 1, 2, 3, 4    ; array of 4 bytes
buffer  db 5 dup(0)      ; 5 bytes initialised to 0

.code
main proc
    mov ax, @data
    mov ds, ax

    lea dx, msg          ; DX = offset of the message
    mov ah, 09h          ; DOS function 09h: display string ending in '$'
    int 21h

    mov al, byteVar      ; AL = 25 (19h)
    mov bx, wordVar      ; BX = 1000 (03E8h)
    mov cl, list+2       ; CL = third element = 3

    mov ah, 4Ch
    int 21h
main endp
end main
