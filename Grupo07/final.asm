include number.asm
include macros.asm

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
@aux7                              	dd	?
_1                                 	dd	1.00
_10                                	dd	10.00
_153                               	dd	153.00
_2                                 	dd	2.00
_20                                	dd	20.00
_25                                	dd	25.00
_26                                	dd	26.00
_3                                 	dd	3.00
_30                                	dd	30.00
_50                                	dd	50.00
_8                                 	dd	8.00
__250                              	dd	-250.00
__25____25_or_bla                  	db	" 25 != 25 or bla"                 , '$', 16 dup (?)
_casi                              	db	"casi"                             , '$', 4 dup (?)
_esto_es_falso                     	db	"esto es falso"                    , '$', 13 dup (?)
_increible_pero_funciona           	db	"INCREIBLE PERO FUNCIONA"          , '$', 23 dup (?)
_ingrese_un_numero_20_             	db	"INGRESE un numero(20)"            , '$', 21 dup (?)
_le_pegaste                        	db	"le pegaste"                       , '$', 10 dup (?)
_posta                             	db	"posta"                            , '$', 5 dup (?)
_toy_dentro_del_if__verdadero      	db	"toy dentro del if, verdadero"     , '$', 28 dup (?)
b                                  	dd	?
i                                  	dd	?

.CODE
START:
MOV EAX, @DATA
MOV DS, EAX
MOV ES, EAX

FLD _25
FRNDINT
FSTP i

FLD _25
FLD _3
FSUB
FSTP @aux1

_StartWhileEspecial_0:

FLD i
FLD @aux1
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JE _ThenWhileEspecial_0

FLD i
FLD __250
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JE _ThenWhileEspecial_0

FLD i
FLD _153
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JE _ThenWhileEspecial_0

FLD i
FLD _25
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JE _ThenWhileEspecial_0

FLD i
FLD _26
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JE _ThenWhileEspecial_0

JMP _EndWhileEspecial_0

_ThenWhileEspecial_0:

displayFloat i , 0
newline 1

FLD i
FLD _1
FADD
FSTP @aux2

FLD @aux2
FRNDINT
FSTP i

FLD i
FLD _26
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JNE _else_0

displayString _toy_dentro_del_if__verdadero
newline 1

FLD _25
FLD _25
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JNE _else_1

FLD i
FLD i
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JNE _else_1

displayString _posta
newline 1

_else_1:

FLD _25
FLD _25
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JNE _then_2

FLD i
FLD _30
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JBE _then_2

JMP _else_2

_then_2:

displayString __25____25_or_bla
newline 1

displayString _ingrese_un_numero_20_
newline 1

GetFloat b
FLD b
FLD _20
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JNE _else_3

displayString _le_pegaste
newline 1

JMP _End_3

_else_3:

displayString _casi
newline 1

_End_3:

_else_2:

JMP _End_2

_else_0:

displayString _esto_es_falso
newline 1

_End_2:

JMP _StartWhileEspecial_0

_EndWhileEspecial_0:

FLD _10
FLD i
FPREM
FSTP @aux3

FLD @aux3
FRNDINT
FSTP i

displayFloat i , 0
newline 1

FLD i
FLD _50
FMUL
FSTP @aux4

FLD @aux4
FLD _8
FDIV
FSTP @aux5

FLD _1
FLD _2
FADD
FSTP @aux6

FLD @aux5
FLD @aux6
FMUL
FSTP @aux7

FLD @aux7
FSTP b

displayFloat b , 2
newline 1

displayString _increible_pero_funciona
newline 1


newline 1


_ET_SALIR:
MOV EAX, 4C00H
INT 21h
END START