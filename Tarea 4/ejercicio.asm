                org     100h

                section .text
                
        ;Hacer un programa utilizando una o más subrutinas donde, con la ayuda de un arreglo de elementos numéricos 
        ;con tamaño de 1 byte, se separe los números pares e impares. (100%)

        ;El arreglo debe contener 10 números y debe estar declarado en la directiva "section .data". 

        ;Los pares colocarlos en la dirección 0300H y los impares colocarlos a partir de la dirección 0320H. 

        XOR DI, DI ; Limpiar DI, se ocupará para manejar el arreglo 
        XOR SI, SI ; Limpiar SI, se ocupará para manejar los registros impares
        mov bx, 2d; Se ocupará para hacer la división entre 2 y comprobar si es par o no

        call Impar
        ;Se vuelven a limpiar DI y SI para utilizarse en la siguiente subrutina
        XOR DI, DI 
        XOR SI, SI

        call Par
        
        int 20h
        

        section .data

        nums DB 1,2,3,4,5,6,7,8,9, 0xA ; Arreglo con números del 1 al 10 para pares e impares
        ; Tipo DB para que sea de tamaño 1 byte
        ;Se pone 0xA para ocuparla a posterior como una condición de paro

;Funciones
Par:
        MOV CL, [nums+DI]
        MOV AX, CX

        div bx 

        cmp AH,0
        jnz ProcesoPar ;Se ocupa jnz para saber que el valor AH es distinto de 0
        
        cmp CX, 8AH ;Por alguna razón al llegar a la posición 10 en vez de guardar
        ;0xA guarda 8A, y esto no ocurre con lo que es en la subrutina de impares
        ;entonces se ocupa el 8A como punto de paro
        Je end   

        INC DI 
        jmp Par 


Impar:
        MOV CL, [nums+DI] ;Se mueve a CL los valores del arreglo
        MOV AX, CX ; Se mueve a AX debido que ahí se efectúa la división

        div bx ;Bx tiene el valor de 2, así que se divide entre 2 esperando el residuo

        cmp AH,0 ;se verifica que el residuo en AH sea 0, por lo tanto se guardarán los impares
        Je ProcesoImpar ;Se manda a llamar la subrutina de proceso impar

        cmp CX, 0xA ;Se ocupa esta comparación para hacer el break al encontrar 0xA
        Je end   

        INC DI ; Se incrementa DI en 1 para manejar el arreglo
        jmp Impar ; Se repite hasta que se encuentre 0xA

end:
        ret ;regresa al main

ProcesoImpar:
        Mov AL, [nums+DI] ;Se mueve a AL lo que sería el valor impar
        Mov [0320H+SI], AL ;Finalmente se mueve a la posición 320 + SI dicho valor
        INC DI ;Se incrementa DI para que no ocurra un bucle
        INC SI ;Se incrementa SI para rellenar posterior la siguiente posición de 320
        jmp Impar ;Se vuelve a la subrutina de impares

ProcesoPar:
        Mov AL, [nums+DI] 
        Mov [0300H+SI], AL
        INC DI
        INC SI
        jmp Par

