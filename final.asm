include number.asm
include macros.asm

.MODEL LARGE
.386
.STACK 200h

.DATA
@aux1                              	dd	?
_4                                 	dd	4.00
_5                                 	dd	5.00
_programa_para_contar_letras__     	db	"PROGRAMA PARA CONTAR LETRAS--"    , '$', 29 dup (?)
cantidadLetras                     	dd	?
i                                  	dd	?
palabra                            	dd	?
variable                           	dd	?

.CODE
START:
MOV EAX, @DATA
MOV DS, EAX
MOV ES, EAX

displayString _programa_para_contar_letras__
newline 1

FLD _5
FLD _4
FPREM
FSTP @aux1

FLD @aux1
FSTP i

displayFloat i , 2
newline 1


_ET_SALIR:
MOV EAX, 4C00H
INT 21h
END START