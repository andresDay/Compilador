include number.asm
include macros.asm

.MODEL LARGE
.386
.STACK 200h

.DATA
_escribo_un_salto                  	db	"escribo un salto"                 , '$', 16 dup (?)
_escribo_un_test                   	db	"escribo un test"                  , '$', 15 dup (?)
a                                  	dd	?
b                                  	dd	?
c                                  	dd	?
d                                  	dd	?
e                                  	dd	?
f                                  	dd	?
palabra                            	dd	?
var                                	dd	?
z                                  	dd	?

.CODE
START:
MOV EAX, @DATA
MOV DS, EAX
MOV ES, EAX

displayString _escribo_un_test
newline 1

newline 1

displayString _escribo_un_salto
newline 1

_ET_SALIR:
MOV EAX, 4C00H
INT 21h
END START