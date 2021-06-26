include number.asm
include macros2.asm

.MODEL LARGE
.386
.STACK 200h

.DATA
_1                                 	dd	1.00
_20                                	dd	20.00
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

FLD b
FLD c
FMUL
FLD a
FLD MULT
FADD
FLD e
FLD f
FADD
FLD d
FLD SUMA
FDIV
FLD SUMA
FLD DIV
FSUB
FLD RESTA
FLD 20
FADD

_ET_SALIR:
MOV EAX, 4C00H
INT 21h
END START