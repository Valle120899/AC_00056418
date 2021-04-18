        org     100h

        section .text


;Escribir cuatro iniciales de su nombre completo empezando en la dirección de memoria 200h (25%):
;Rodrigo Andres Valle Morales

        mov	word [200h], 52h
        mov	word [201h], 41h
        mov	word [202h], 56h
        mov	word [203h], 4Dh

;Luego, copiar a los siguientes registros los códigos ASCII de los caracteres guardados en 200h (75%):

;Copiar el valor de 200h a AX usando direccionamiento directo. 52

        mov     AL, [200h]

;Copiar el valor de 201h a CX usando direccionamiento indirecto por registro. 41

        mov     BX, 201h
        mov	CL, [BX]

;Copiar el valor de 202h a DX usando direccionamiento indirecto base más índice.  56

        mov 	DL, [202h+DI]
	mov	[202h+DI], DL

;Copiar el valor de 203h a DI usando direccionamiento relativo por registro. 4D

        mov	DI, [DI+203h]

        int     20h


