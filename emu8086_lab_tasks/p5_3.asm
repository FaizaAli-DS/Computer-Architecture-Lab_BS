; P5-3  Signed vs unsigned comparison of the same bit patterns
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
m1 db 'Unsigned: 0FFh > 01h ? $'
m2 db 'Signed  : 0FFh > 01h ? $'
yes db 'YES$'
no  db 'NO$'

.code
main proc
    mov ax, @data
    mov ds, ax

    mov al, 0FFh         ; 255 unsigned, -1 signed
    mov bl, 01h

    print m1
    cmp al, bl
    ja  u_yes            ; JA uses CF and ZF (unsigned)
    print no
    jmp u_done
u_yes:
    print yes
u_done:
    newline

    print m2
    cmp al, bl
    jg  s_yes            ; JG uses SF, OF and ZF (signed)
    print no
    jmp s_done
s_yes:
    print yes
s_done:

    mov ah, 4Ch
    int 21h
main endp
end main
