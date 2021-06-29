;IMPORTANTE: el programa funciona parcialmente.
;La contraseña es "abcde", y la reconoce, pero 
;cuando se dijita, si pone si está correcta o no
;pero también imprime la otra frase seguida,
; o al menos eso pasa en mi máquina
;pero lo importante de ver si está correcta o no lo hace parcialmente c:
        org 	100h

	section	.text

	; print msg1
	mov 	DX, msg1
	call  	EscribirCadena

	; input frase
	mov 	BP, frase
	call  	LeerCadena

        mov     word cx, 5d
        xor     DI, DI
        jmp Comparar


	call	EsperarTecla

	int 	20h



; FUNCIONES

EsperarTecla:
        mov     AH, 01h         
        int     21h
        ret

; Leer cadena de texto desde el teclado
; Salida:       SI: longitud de la cadena 		BP: direccion de guardado
LeerCadena:
        xor     SI, SI          ; SI = 0
while:  
        call    EsperarTecla    ; retorna un caracter en AL
        cmp     AL, 0x0D        ; comparar AL con caracter EnterKey
        je      exit            ; si AL == EnterKey, saltar a exit
        mov     [BP+SI], AL   	; guardar caracter en memoria
        inc     SI              ; SI++
        jmp     while           ; saltar a while
exit:
	mov 	byte [BP+SI], "$"	; agregar $ al final de la cadena
        ret


; Permite escribir en la salida estándar una cadena de caracteres o string, este
; debe tener como terminación el carácter “$”
; Parámetros:	AH: 09h 	DX: dirección de la celda de memoria inicial de la cadena
EscribirCadena:
	mov 	AH, 09h
	int 	21h
	ret

Comparar:
;Bp está guardado la frase colocada
;[password + const] Puedo acceder a caracter de la contraseña     
        mov     AX, [password+DI]
        mov     BX, [frase+DI]
        cmp     AX, BX
        JNE     Malo
        inc     DI
        loop Comparar
        jmp     Bueno

Malo:
        XOR     AX, AX
        mov 	DX, msg3
	jmp  	EscribirCadena
        

Bueno:
        XOR     AX, AX
        mov 	DX, msg2
	jmp  	EscribirCadena
        

section	.data

        password   db      "abcde"

        msg1	db	"Type the password: ", "$"

        msg3    db      "Incorrecto"

        msg2    db      "Bienvenido"

        frase 	times 	20  	db	" " 	