include number.asm
include macros.asm

.MODEL LARGE
.386
.STACK 200h

.DATA
_5                                 	dd	5.00
_5_5                               	dd	5.5
_5_es_mayor_que_5_5                	db	"5 es mayor que 5.5"               , '$', 18 dup (?)
_5_es_menor_que_5_5                	db	"5 es menor que 5.5"               , '$', 18 dup (?)
a                                  	dd	?
b                                  	dd	?
z                                  	dd	?

.CODE
START:
MOV EAX, @DATA
MOV DS, EAX
MOV ES, EAX

FLD _5
FLD _5_5
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JNA _else_0

displayString _5_es_mayor_que_5_5
newline 1

JMP _End_0

_else_0:

displayString _5_es_menor_que_5_5
newline 1

_End_0:


_ET_SALIR:
MOV EAX, 4C00H
INT 21h
END START