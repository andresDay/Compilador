include number.asm
include macros.asm

.MODEL LARGE
.386
.STACK 200h

.DATA
@aux1                              	dd	?
@aux2                              	dd	?
@cero                              	dd	?
@uno                               	dd	?
_1                                 	dd	1.00
_10                                	dd	10.00
_11                                	dd	11.00
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

_COMP1:

FLD a
FLD _10
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JNA _COMP_FALSE1

_COMP2:

FLD a
FLD _11
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JNA _COMP_FALSE2

_COMP_FALSE1:
JMP _COMP2

displayString _soy_mayor
newline 1

JMP _IF_END1

_COMP_FALSE2:

displayString _no_soy_mayor
newline 1

_IF_END1:

FLD _21
FSTP a


_ET_SALIR:
MOV EAX, 4C00H
INT 21h
END START