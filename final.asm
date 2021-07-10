include number.asm
include macros.asm

.MODEL LARGE
.386
.STACK 200h

.DATA
@aux1                              	dd	?
_1                                 	dd	1.00
_10                                	dd	10.00
_estoy_dentro_del_bucle            	db	"ESTOY DENTRO DEL BUCLE"           , '$', 22 dup (?)
a                                  	dd	?
z                                  	dd	?

.CODE
START:
MOV EAX, @DATA
MOV DS, EAX
MOV ES, EAX

FLD _1
FSTP a

FLD _1
FSTP z

_StartWhile_0:

FLD a
FLD _10
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JNB _else_0

FLD z
FLD _10
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JNB _else_0

FLD a
FLD _1
FADD
FSTP @aux1

FLD @aux1
FSTP a

displayString _estoy_dentro_del_bucle
newline 1

JMP _StartWhile_0

_else_0:


_ET_SALIR:
MOV EAX, 4C00H
INT 21h
END START