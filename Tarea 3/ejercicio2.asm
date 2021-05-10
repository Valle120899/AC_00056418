        org     100h

        section .text

;Obtener el factorial del numero 5 (5! = 120 -> 78 en hexadecimal) y guardar el resultado en 20Bh

        MOV     word CX, 5d ; Le ponemos 5 debido que este es el tamaño del 5!
        XOR     DI, DI ; Limpiar DI
        XOR     AX, AX; Se limpia debido que contiene FFFF inicialmente
        XOR     BX, BX; Se limpia al ser la variable a ocuparse para multiplicar

        INC     DI ;Para que comience en 1
        INC     AX; Se incrementa AX para que la multiplicación comience con 1
        jmp     iterar ; Se hace jump a iterar

iterar:
        MOV     BX, DI ; Se pasa el valor de DI a BX 
        MUL     BX ;Debido que DI irá incrementando y luego el valor se pasa a BX, simula lo que es un factorial
        INC     DI; incrementar en 1
        LOOP    iterar
        MOV     [20BH], AX ;Finalmente se mueve de AX a [20BH]

exit:
        int     20h