; P5-2  Multi-way branching (if / else-if / else): grade from marks
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
marks  dw 74
mmsg   db 'Marks = $'
gmsg   db '   Grade = $'

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ax, marks
    print mmsg
    call print_snum
    print gmsg

    cmp ax, 85           ; if (marks >= 85) grade = 'A'
    jae grade_a
    cmp ax, 70           ; else if (marks >= 70) grade = 'B'
    jae grade_b
    cmp ax, 55           ; else if (marks >= 55) grade = 'C'
    jae grade_c
    cmp ax, 50           ; else if (marks >= 50) grade = 'D'
    jae grade_d
    mov dl, 'F'          ; else grade = 'F'
    jmp show
grade_a:
    mov dl, 'A'
    jmp show
grade_b:
    mov dl, 'B'
    jmp show
grade_c:
    mov dl, 'C'
    jmp show
grade_d:
    mov dl, 'D'
show:
    mov ah, 02h
    int 21h

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
