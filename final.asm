include number.asm
include macros.asm

.MODEL LARGE
.386
.STACK 200h

.DATA
@aux1                              	dd	?
@aux2                              	dd	?
_2                                 	dd	2.00
_30                                	dd	30.00
_3_6                               	dd	3.6
_4                                 	dd	4.00
_5                                 	dd	5.00
_7                                 	dd	7.00
_8_256                             	dd	8.256
_imprimo_un_entero_                	db	"Imprimo un entero:"               , '$', 18 dup (?)
_imprimo_un_float_                 	db	"Imprimo un float:"                , '$', 17 dup (?)
_imprimo_una_variable_entera_      	db	"Imprimo una variable entera:"     , '$', 28 dup (?)
_imprimo_una_variable_float_       	db	"Imprimo una variable float:"      , '$', 27 dup (?)
a                                  	dd	?
b                                  	dd	?
z                                  	dd	?

.CODE
START:
MOV EAX, @DATA
MOV DS, EAX
MOV ES, EAX

FLD _2
FLD _5
FADD
FSTP @aux1

FLD @aux1
FSTP b

FLD _3_6
FSTP a

displayString _imprimo_una_variable_entera_
newline 1

displayFloat b , 0
newline 1


newline 1

displayString _imprimo_una_variable_float_
newline 1

displayFloat a , 2
newline 1


newline 1

displayString _imprimo_un_entero_
newline 1

displayFloat _4 , 0
newline 1


newline 1

displayString _imprimo_un_float_
newline 1

displayFloat _8_256 , 2
newline 1


newline 1

FLD _7
FLD _30
FPREM
FSTP @aux2

FLD @aux2
FSTP a

displayFloat a , 2
newline 1


_ET_SALIR:
MOV EAX, 4C00H
INT 21h
END START