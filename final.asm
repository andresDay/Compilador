include number.asm
include macros.asm

.MODEL LARGE
.386
.STACK 200h

.DATA
@aux1                              	dd	?
@aux10                             	dd	?
@aux11                             	dd	?
@aux12                             	dd	?
@aux13                             	dd	?
@aux14                             	dd	?
@aux15                             	dd	?
@aux16                             	dd	?
@aux17                             	dd	?
@aux18                             	dd	?
@aux2                              	dd	?
@aux3                              	dd	?
@aux4                              	dd	?
@aux5                              	dd	?
@aux6                              	dd	?
@aux7                              	dd	?
@aux8                              	dd	?
@aux9                              	dd	?
_0                                 	dd	0.00
_1                                 	dd	1.00
_2                                 	dd	2.00
_20                                	dd	20.00
_25                                	dd	25.00
_2_25                              	dd	2.25
_3                                 	dd	3.00
_3_5                               	dd	3.5
_4                                 	dd	4.00
_5                                 	dd	5.00
_6                                 	dd	6.00
_9                                 	dd	9.00
__4_5                              	dd	-4.5
__5                                	dd	-5.00
___ingrese_exit_para_salir__       	db	"--INGRESE EXIT PARA SALIR--"      , '$', 27 dup (?)
_es_una_palabra_corta              	db	"es una palabra corta"             , '$', 20 dup (?)
_es_una_palabra_larga              	db	"es una palabra larga"             , '$', 20 dup (?)
_es_una_palabra_no_tan_larga       	db	"es una palabra no tan larga"      , '$', 27 dup (?)
_ingresa_una_palabra_              	db	"ingresa una palabra:"             , '$', 20 dup (?)
_la_cantidad_es_total              	db	"la cantidad es total"             , '$', 20 dup (?)
_programa_para_contar_letras__     	db	"PROGRAMA PARA CONTAR LETRAS--"    , '$', 29 dup (?)
cantidadLetras                     	dd	?
i                                  	dd	?
palabra                            	dd	?
variable                           	dd	?

.CODE
START:
MOV EAX, @DATA
MOV DS, EAX
MOV ES, EAX

displayString _programa_para_contar_letras__
newline 1

displayString ___ingrese_exit_para_salir__
newline 1

displayString _ingresa_una_palabra_
newline 1

FLD _0
FRNDINT
FSTP i

FLD __4_5
FSTP variable

FLD i
FLD _2
FADD
FSTP @aux1

_StartWhileEspecial_0:

FLD variable
FLD @aux1
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JE _ThenWhileEspecial_0

FLD _2_25
FLD _2
FMUL
FSTP @aux2

FLD variable
FLD @aux2
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JE _ThenWhileEspecial_0

FLD variable
FLD _3_5
FSUB
FSTP @aux3

FLD variable
FLD @aux3
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JE _ThenWhileEspecial_0

FLD _4
FLD _4
FPREM
FSTP @aux4

FLD variable
FLD @aux4
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JE _ThenWhileEspecial_0

FLD _9
FLD _2
FDIV
FSTP @aux5

FLD variable
FLD @aux5
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JE _ThenWhileEspecial_0

JMP _EndWhileEspecial_0

_ThenWhileEspecial_0:

FLD i
FLD _1
FADD
FSTP @aux6

FLD @aux6
FRNDINT
FSTP i

FLD _4
FLD _6
FADD
FSTP @aux7

_StartWhileEspecial_1:

FLD variable
FLD @aux7
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JE _ThenWhileEspecial_1

FLD i
FLD _4
FMUL
FSTP @aux8

FLD variable
FLD @aux8
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JE _ThenWhileEspecial_1

FLD __5
FLD _4
FADD
FSTP @aux9

FLD variable
FLD @aux9
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JE _ThenWhileEspecial_1

JMP _EndWhileEspecial_1

_ThenWhileEspecial_1:

FLD i
FLD _5
FADD
FSTP @aux10

FLD @aux10
FRNDINT
FSTP i

JMP _StartWhileEspecial_1

_EndWhileEspecial_1:

JMP _StartWhileEspecial_0

_EndWhileEspecial_0:

FLD _0
FSTP palabra

_StartWhile_3:

FLD palabra
FLD _2
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JE _else_0

FLD palabra
FLD _1
FADD
FSTP @aux11

FLD @aux11
FSTP palabra

_StartWhile_2:

FLD i
FLD _3
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JE _else_1

FLD i
FLD _1
FADD
FSTP @aux12

FLD @aux12
FRNDINT
FSTP i

JMP _StartWhile_2

_else_1:

FLD i
FLD _1
FADD
FSTP @aux13

FLD @aux13
FRNDINT
FSTP i

FLD i
FLD _20
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JNA _else_2

FLD palabra
FLD _4
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JNE _else_2

FLD cantidadLetras
FLD _25
FXCH
FCOM
FSTSW ax
SAHF
FFREE
JB _else_3

displayString _es_una_palabra_larga
newline 1

displayFloat palabra , 2
newline 1

FLD _6
FLD i
FPREM
FSTP @aux14

FLD @aux14
FSTP variable

JMP _End_3

_else_3:

displayString _es_una_palabra_no_tan_larga
newline 1

displayFloat palabra , 2
newline 1

FLD i
FLD _6
FDIV
FSTP @aux15

FLD @aux15
FSTP variable

_End_3:

JMP _End_2

_else_2:

displayString _es_una_palabra_corta
newline 1

_End_2:

displayString _la_cantidad_es_total
newline 1

FLD _0
FRNDINT
FSTP i

displayString _ingresa_una_palabra_
newline 1

JMP _StartWhile_3

_else_0:

FLD _2
FLD _3
FADD
FSTP @aux16

FLD _2
FLD @aux16
FPREM
FSTP @aux17

FLD palabra
FLD @aux17
FMUL
FSTP @aux18

FLD @aux18
FRNDINT
FSTP i


newline 1

displayFloat palabra , 2
newline 1


newline 1

displayFloat i , 0
newline 1


_ET_SALIR:
MOV EAX, 4C00H
INT 21h
END START