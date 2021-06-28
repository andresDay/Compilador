include number.asm
include macros2.asm

.MODEL LARGE
.386
.STACK 200h

.DATA
_1                                 	dd	1.00
_2                                 	dd	2.00
a                                  	dd	?
b                                  	dd	?
c                                  	dd	?
d                                  	dd	?
e                                  	dd	?
f                                  	dd	?
z                                  	dd	?

.CODE
START:
MOV EAX, @DATA
MOV DS, EAX
MOV ES, EAX

FLD _1
FSTP a

FLD _1
FSTP b

FLD _1
FSTP c

FLD _1
FSTP d

FLD _1
FSTP e

FLD _1
FSTP f

FLD _2
FSTP z

displayFloat z , 2
newline 1

_ET_SALIR:
MOV EAX, 4C00H
INT 21h
END START