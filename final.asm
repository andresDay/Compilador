include number.asm
include macros.asm

.MODEL LARGE
.386
.STACK 200h

.DATA
_10                                	dd	10.00
_5                                 	dd	5.00
_es_false                          	db	"es false"                         , '$', 8 dup (?)
_es_true                           	db	"es true"                          , '$', 7 dup (?)
a                                  	dd	?
z                                  	dd	?

.CODE
START:
MOV EAX, @DATA
MOV DS, EAX
MOV ES, EAX

FLD _5
FSTP a

FLD a
FLD _10
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JNA _ENDIF_1

displayString _es_true
newline 1

BI _ENDIF_1

_ELSE_1

displayString _es_false
newline 1

_ENDIF_1

_ET_SALIR:
MOV EAX, 4C00H
INT 21h
END START