include number.asm
include macros.asm

.MODEL LARGE
.386
.STACK 200h

.DATA
_1                                 	dd	1.00
_21                                	dd	21.00
_no_soy_mayor                      	db	"NO SOY MAYOR"                     , '$', 12 dup (?)
_soy_mayor                         	db	"SOY MAYOR"                        , '$', 9 dup (?)
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

FLD a
FLD a
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JNB _else_0

displayString _soy_mayor
newline 1

JMP _End_0

_else_0:

a:
displayString _no_soy_mayor
newline 1

_End_0:

FLD _21
FSTP a


_ET_SALIR:
MOV EAX, 4C00H
INT 21h
END START