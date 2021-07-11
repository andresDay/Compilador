include number.asm
include macros.asm

.MODEL LARGE
.386
.STACK 200h

.DATA
@aux1                              	dd	?
_2                                 	dd	2.00
a                                  	dd	?
b                                  	dd	?
z                                  	dd	?

.CODE
START:
MOV EAX, @DATA
MOV DS, EAX
MOV ES, EAX

FLD _2
FLD _2
FADD
FSTP @aux1

FLD @aux1
FSTP 4

displayInteger 4
newline 1


_ET_SALIR:
MOV EAX, 4C00H
INT 21h
END START