;------------------------------Macros------------------------------
envioChar macro caracter
    mov ah, 06h
    mov dl, caracter
    int 21h
endm

print macro buffer  ;imprime cadena de texto
    mov ax, @data
    mov ds, ax
    mov ah, 09h     
    mov dx, offset buffer   
    int 21h
endm

clear macro ;limpia
    mov ah, 00h
	mov al, 03h
	int 10h
endm

mostrar macro v1, v2
    add al, '0'
    mov v2, al
    add ah, '0'
    mov v1, ah
endm

;-------------------------------Programa-----------------------------
.model small
.stack
.data

    carrito      equ 0dh     ;retorno de carro
    linea      equ 0ah     ;nueva linea
    signoDolar   equ '$'     ;signo de signoDolar
    nuevaLinea  db linea,carrito,signoDolar

    dia     db 0
    mes     db 0
    anio     dw 0
    hora    db 0
    minutos  db 0
    segundos  db 0
    n1    db 0
    n2    db 0
    n3    db 0
    n4    db 0
    res     dw 0
    millar     dw 1000
    centenas    dw 100
    decenas    dw 10

    fila     db 0
    columna  db 0 

.code
main proc far
    push ds
    mov si, 0
    push si
    mov ax, @data
    mov ds, ax
    mov es, ax

    mov ah, 00h ;aqui se centra el texto para el reloj
    mov al, 03H
    int 10h

    mov fila, 10d 
    mov columna, 30d
    mov si, 0

    mov ah, 02h
    mov dh, fila
    mov dl, columna
    mov bh, 0
    int 10h

;---------------------------Fecha-----------------------

    mov ah, 2AH ;interrupcion para la fecha del sistema
    int 21h

    mov dia, dl ;se mueven las variables
    mov mes, dh
    mov anio, cx

    mov al, dia ;dia
    aam

    mostrar n1, n2

    envioChar n1
    envioChar n2
    envioChar '/'

    mov al, mes ;mes
    aam

    mostrar n1, n2

    envioChar n1
    envioChar n2
    envioChar '/'

    mov ax, anio ;anio
    cwd
    div millar
    aam
    mov res, dx
    add al, '0'
    mov n1, al
    envioChar n1

    mov ax, res 
    cwd
    div centenas
    aam
    mov res, dx
    add al, '0'
    mov n2, al
    envioChar n2

    mov ax, res 
    cwd
    div decenas
    aam
    mov res, dx
    add al, '0'
    mov n3, al
    envioChar n3   

    mov ax, res
    aam
    add al, '0'
    mov n4, al
    envioChar n4

    envioChar '-'
;-------------------------Hora-----------------------------------------

    mov ah, 2ch ;interrupcion para la hora del sistema
    int 21h

    mov hora, CH ;se mueven las variables
    mov minutos, cl
    mov segundos, dh

    mov al, hora ;hora
    aam

    mostrar n1, n2

    envioChar n1
    envioChar n2
    envioChar ':'

    mov al, minutos ;minutos
    aam

    mostrar n1, n2

    envioChar n1
    envioChar n2
    envioChar ':'

    mov al, segundos ;segundo
    aam

    mostrar n1, n2

    envioChar n1
    envioChar n2

    print nuevaLinea
    
    CALL DELAY
    clear

    DELAY proc
		mov si, 700d
		mov di, 700d
		delay1:
			dec si
			jz finDelay
			mov di, 700d
			delay2:
				dec di
				jz delay1
			jmp delay2
		finDelay:
		ret
	DELAY endp

    salir:
        mov ah, 4ch
        int 21h

main endp
end main