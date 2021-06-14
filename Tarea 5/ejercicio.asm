org 100h

    section .text
    MOV DI, 0d
    MOV CX, 4d ;Para hacer la iteración de los 4 nombres

    call modotexto
    call moverPrimeraPos
    call Escribir
    call esperartecla
    call exit

    modotexto: 
        MOV AH, 0h ; activa modo texto
        MOV AL, 03h ; modo gráfico deseado, 03h denota un tamaño de 80x25 (80 columnas, 25 filas)
        INT 10h
        RET
    moverPrimeraPos:
    ;Acá se deja especificado desde el inicio la posición que tomará el primer nombre
        MOV AH, 02h ; posiciona el cursor en pantalla.
        MOV DH, 8 ;fila en la que se mostrará el cursor
        MOV DL, 20 ;columna en la que se mostrará el cursor
        MOV BH, 0h ; número de página
        INT 10h
        RET
    Escribir: ;utilizando interrupcion DOS
        MOV AH, 09h ; escribe cadena en pantalla según posición del cursor
        ;Se ocupa DI que se incrementa en cada posicion para hacer una comparación para ver que 
        ;Palabra debe de imprimir en cada iteración
        cmp DI,0d
        je Dato1

        cmp DI, 1d
        je Dato2

        cmp DI, 2d
        je Dato3

        cmp DI, 3d
        je Dato4

        LOOP Escribir

        RET
        
    esperartecla:
        MOV AH, 00h ; espera buffer del teclado para avanzar en la siguiente instrucción
        INT 16h
        ret
    exit:
        int 20h;Termina el programa

    Dato1:
        MOV DH, 10
        INC DI
        MOV DX, Primero
        int 21h
        ;Ahora se deja acá preparada la siguiente posición que tomará el cursor en pantalla
        mov ah, 02h
        mov dh, 10 
        mov dl, 20
        mov bh, 0h
        int 10h

        jmp Escribir

    Dato2:
        INC DI
        MOV DX, Segundo
        int 21h
        ;Ahora se deja acá preparada la siguiente posición que tomará el cursor en pantalla
        mov ah, 02h
        mov dh, 12
        mov dl, 20
        mov bh, 0h
        int 10h

        jmp Escribir

    Dato3:
        INC DI
        MOV DX, Tercero
        int 21h
        ;Ahora se deja acá preparada la siguiente posición que tomará el cursor en pantalla
        mov ah, 02h
        mov dh, 14
        mov dl, 20
        mov bh, 0h
        int 10h
        jmp Escribir

    Dato4:
        ;No es necesario dejar acá una última posición en pantalla, al ser el último dato
        INC DI
        MOV DX, Cuarto
        int 21h
        jmp Escribir

section .data
;Se pone el $ para que ensamblador reconozca que ahí termina la cadena
Primero DB "Rodrigo $"
Segundo DB "Andres $" 
Tercero DB "Valle $"
Cuarto DB "Morales $"