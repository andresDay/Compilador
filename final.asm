include number.asm
include macros2.asm

.MODEL LARGE
.386
.STACK 200h

.DATA
@aux1                              	dd	?
@aux2                              	dd	?
@aux3                              	dd	?
@aux4                              	dd	?
@aux5                              	dd	?
@aux6                              	dd	?
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
FLD _c
FMUL
FSTP @aux1
FLD a
FLD _@aux1
FADD
FSTP @aux2
FLD e
FLD _f
FADD
FSTP @aux3
FLD d
FLD _@aux3
FDIV
FSTP @aux4
FLD @aux2
FLD _@aux4
FSUB
FSTP @aux5
FLD @aux5
FLD _20
FADD
FSTP @aux6

_ET_SALIR:
MOV EAX, 4C00H
INT 21h
END START