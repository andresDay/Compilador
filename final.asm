include number.asm
include macros.asm

.MODEL LARGE
.386
.STACK 200h

.DATA
_1                                 	dd	1.00
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

FLD _1
FSTP a

displayFloat a , 2
newline 1

_ET_SALIR:
MOV EAX, 4C00H
INT 21h
END START