; P4-1  Data transfer instructions: MOV, XCHG, LEA, PUSH/POP, XLAT
.model small
.stack 100h

.data
var1   dw 1111h
var2   dw 2222h
table  db '0123456789ABCDEF'   ; look-up table for XLAT

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ax, var1        ; memory  -> register : AX = 1111h
    mov bx, ax          ; register-> register : BX = 1111h
    mov cx, 0ABCDh      ; immediate-> register: CX = ABCDh
    mov var2, cx        ; register-> memory   : var2 = ABCDh

    xchg ax, cx         ; swap        : AX = ABCDh, CX = 1111h
    xchg ah, al         ; swap bytes  : AX = CDABh

    push ax             ; save AX on the stack
    push bx             ; save BX on the stack
    pop  dx             ; DX = 1111h  (last in, first out)
    pop  si             ; SI = CDABh

    lea bx, table       ; BX = address of the table
    mov al, 0Ch         ; index 12
    xlat                ; AL = table[12] = 'C' (43h)

    mov ah, 4Ch
    int 21h
main endp
end main
