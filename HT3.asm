;--------------------------------------MACROS------------------------------------------
imprimir macro buffer ;imprime cadena
    mov ax, @data
    mov ds, ax
    mov ah, 09h
    mov dx, offset buffer
    int 21h
endm

close macro
    mov ah, 4ch
    xor al, al
    int 21h
endm

;-----------------------------------Programa-------------------------------------------

.model small
.stack 64 
.data

    msg1 db 10,13, "|-----Luis Vejo - 201212527 - HT2-----|$"
    msg2 db 10,13, "|---------------Reloj-----------------|$"


.code
begin proc far

imprimir msg1
imprimir msg2

begin endp
end