                org     100h

                section .text
                
        ;El promedio de la suma de los 8 dígitos de su carnet, el resultado del promedio guardarlo en 20Ah 
        ;Suma de los dígitos.
        ;Promedio (este promedio será la DIVISION ENTERA, no trabajaremos con decimales).
        ;Guardar el resultado en el registro 20Ah

        XOR DI, DI ; Limpiar DI
        XOR BL, BL; Limmpiar BX debido que acá se guardará la suma
        MOV word CX, 8d ; colocar 8d en CX (este es el tamaño del carnet)
        jmp iterar
iterar:

        MOV byte BL, [carnet+DI] ; En la primera iteración DI tiene 0, se agarra el primer num.
        ADD [20Ah], BX
        INC DI ; Se incrementa DI en 1, para manejar el registro
        LOOP iterar ; Se repite el loop hasta que CX se cumpla
        
        MOV AX, [20Ah]; Se mueve a AX la sumatoria total, en este caso 24
        DIV DI; Se divide entre DI al ser un contador que estuvo dentro del loop, tiene el valor de 8
        MOV [20AH], AL;El resultado queda en AL, así que se mueve dicho valor de nuevo a [20AH]
        
;exit        
        int 20h
        

        section .data

        carnet DB 0,0,0,5,6,4,1,8 ; int carnet = 00056418
        ; Se trabaja de esta forma representando un arreglo de enteros en lenguaje de alto nivel