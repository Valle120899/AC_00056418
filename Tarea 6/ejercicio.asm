	org 	100h

	section	.text

        ;print clave
	mov     DX, ayuda
        call    EscribirCadena
        
        ; print msg1
	mov 	DX, msg1
	call  	EscribirCadena

	; input frase
	mov 	BP, frase
	call  	LeerCadena

        ;Verificacion
        ;call Verificar

	call	EsperarTecla

	int 	20h

	section	.data

ayuda   db      "La clave es: abcde$"
msg1	db	"Ingresa una clave: ", "$"
clave   db      "abcde"
msg3    db      "Bienvenido"
msg4    db      "Incorrecto"
frase 	times 	20  	db	" " 	

; FUNCIONES

EsperarTecla:
        mov     AH, 01h         
        int     21h
        ret
LeerCadena:
        xor     SI, SI      
while:  
        call    EsperarTecla    
        cmp     AL, 0x0D      
        je      exit            
        mov     [BP+SI], AL   
        inc     SI             
        jmp     while          
exit:
	mov 	byte [BP+SI], "$"	
        ret

EscribirCadena:
	mov 	AH, 09h
	int 	21h
	ret

Verificar:
        mov dx, clave
        mov ax, frase
        je Bueno
        je Malo
Bueno:
        mov dx, msg3
        call EscribirCadena
        ret
Malo:
        mov dx, msg4
        call EscribirCadena
        ret
;cmpsb