.model small
.stack 126 
.data

pila segment para stack 'stack '
   dw 64 dup(' ')
pila ends

datos segment para public 'data'
        dia     db 0
        mes     db 0
        anio    dw 0
        n1   db 0
        n2   db 0
        n3      db 0
        n4      db 0
        res     dw 0
        mil     dw 1000
        cien    dw 100
        diez    dw 10
        msg1 db 10,13, "|-----Luis Vejo - 201212527 - HT2-----|$"
        msg2 db 10,13, "|---------------Reloj-----------------|$"
        msg3 db 10,13, " "
               
datos ends
codigo segment
   assume ss:pila,ds:datos,cs:codigo

mensage macro x
   mov ah,06h
   mov dl,x
   int 21h
endm

imprimir macro buffer ;imprime cadena
    mov ax, @data
    mov ds, ax
    mov ah, 09h
    mov dx, offset buffer
    int 21h
endm

inicial proc

   imprimir msg1
   imprimir msg2
   imprimir msg3
   mov ax,datos
   mov ds,ax

        mov ah,2AH  ;funcion que devuelve la fecha
        int 21h
        mov dia,dl     ;movemos el valor del dia a una variable
        mov mes,dh
        mov anio,cx
   

        ; ********* Obtencion y despliegue del dia *********

        mov al,dia     ;cl obtiene la hora y se transiere a al
   aam      ;ax se convierte a BCD
   
   add al,'0'   ;convertimos AL en ASCII
   mov n2,al   ;movemos la parte baja de AX a n2
   add ah,'0'   ;convertimos AH en ASCII
   mov n1,ah   ;movemos la parte alta de AX a n1
   
   mensage n1
        mensage n2
        mensage '/'

        ; ********* Obtencion y despliegue del mes *********

        mov al,mes
   aam      ;ax se convierte a BCD
   
   add al,'0'   ;convertimos AL en ASCII
   mov n2,al   ;movemos la parte baja de AX a n2
   add ah,'0'   ;convertimos AH en ASCII
   mov n1,ah   ;movemos la parte alta de AX a n1

   mensage n1
        mensage n2
        mensage '/'

        ; ********* Obtencion y despliegue del a¤o *********
        mov ax,anio   ;movemos el valor del año a ax
        cwd      ;convertirmos ax en doble palabra (es indispensable para realizar esta división)
        div mil      ;dividimos ax entre mil=1000, AX almacena el cociente y DX el residuo
        aam      ;ax es convertido a BCD
        mov res,dx   ;se lamacena el residuo que esta en dx a la variable RES
        add al,'0'   ;convertimos a ASCII la parte baja de aX que contiene el valor del residuo despues de convertirse en BCD
        mov n1,al   ;movemos el residuo a N!
        mensage n1   ;mostramos el valor del residuo que es el promer numero del año
      
   ;mostramos el segundo numero del año
        mov ax,res
        cwd
        div cien
        aam
        mov res,dx
        add al,'0'
        mov n1,al
        mensage n1

   ;mostramos el tercer numero del año        
        mov ax,res
        cwd
        div diez
        aam
        mov res,dx
        add al,'0'
        mov n1,al
        mensage n1

   ;mostramos el cuarto y ultimo numero del año
        mov ax,res
        aam
        add al,'0'
        mov n1,al
        mensage n1

        mov ah,4ch
   int 21h
inicial endp
codigo ends
   end inicial