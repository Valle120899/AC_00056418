                org     100h

                section .text
                
        ;Hacer un programa utilizando una o más subrutinas donde, con la ayuda de un arreglo de elementos numéricos 
        ;con tamaño de 1 byte, se separe los números pares e impares. (100%)

        ;El arreglo debe contener 10 números y debe estar declarado en la directiva "section .data". 

        ;Los pares colocarlos en la dirección 0300H y los impares colocarlos a partir de la dirección 0320H. 

        XOR DI, DI ; Limpiar DI, se ocupará para manejar el arreglo general
        XOR SI, SI ; Limpiar SI, se ocupará para manejar los registros pares
        XOR BP, BP ; Limpiar BP, se ocupará para manejar los registros impares

        call For ;Se manda a llamar a la función
        
        int 20h
        

        section .data

        nums DB 1,2,3,4,5,6,7,8,9,8, 0xA ; Arreglo con números dígitos con pares e impares
        ; Tipo DB para que sea de tamaño 1 byte
        ;Se pone 0xA para ocuparla a posterior como una condición de paro o break

;Funciones
For:
        mov bx, 2d ;Se mueve 2d debido que este es el dato por el que se dividirá para ver si es par o no
        Mov byte AL, [nums + DI] ;Se ueve como tipo byte a AL para realizarse la divisón ahí.

        cmp AL, 0xA ;Se verifica la condición de break
        je end
        
        div bx ;División entre el registro+DI /2

        cmp DX,0d ;Primera verificación, se ve si el residuo es 0
        je ProcesoPar ;Si es 0 se manda a llamar a la subrutina ProcesoPar

        cmp DX,1d ;Segunda verificación, se ve si el residuo no es 0
        je ProcesoImpar ;Si no es 0, se manda a llamar a la subrutina ProcesoImpar

        jmp For;Como si fuese una función recursiva hasta que se cumpla la condición de break
end:
        ret ;Para retornar al main

ProcesoPar:
        mov byte BL, [nums+DI] ;Se mueve a BL el dato debido que no se puede mover a 300h de forma directa
        mov [300h+SI], BL ;Se mueve a 300H+SI
        inc DI;Se incrementa DI debido que es el contador GENERAL con el que se maneja el arreglo
        inc SI;Se incrementa SI debido que es el contador local para 300H
        jmp For;Se regresa a la subrutina for

ProcesoImpar:
        mov byte BL, [nums+DI];Se mueve a BL el dato debido que no se puede mover a 320H de forma directa
        mov [320h+BP], BL;Se mueve a 320H+BP
        inc DI;Se incrementa DI debido que es el contador GENERAL con el que se maneja el arreglo
        inc BP;Se incrementa BP debido que es el contador local para 320H
        jmp For;Se regresa a la subrutina for

