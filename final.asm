include number.asm
include macros.asm

.MODEL LARGE
.386
.STACK 200h

.DATA
@aux1                              	dd	?
@aux2                              	dd	?
Z                                  	dd	?
_1                                 	dd	1.00
_10                                	dd	10.00
_20                                	dd	20.00
_50                                	dd	50.00
_es_false                          	db	"es false"                         , '$', 8 dup (?)
_es_sin_else                       	db	"es sin else"                      , '$', 11 dup (?)
a                                  	dd	?
z                                  	dd	?

.CODE
START:
MOV EAX, @DATA
MOV DS, EAX
MOV ES, EAX

FLD _20
FSTP a

LO QUE TIENE ADENTRO AND
ESTOY DE RUTA
FLD a
FLD _50
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JNA _NoCumple_1

FLD z
FLD _1
FADD
FSTP @aux1

FLD @aux1
FSTP a

FLD a
FLD _1
FADD
FSTP @aux2

FLD @aux2
FSTP z

JMP _FIN_1

_NoCumple_1:

@aux2:
displayString _es_false
newline 1

_FIN_1:

LO QUE TIENE ADENTRO (null)
ESTOY DE RUTA
FLD a
FLD _10
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JNA _NoCumple_2

displayString _es_sin_else
newline 1

_NoCumple_2:

_ET_SALIR:
MOV EAX, 4C00H
INT 21h
END START