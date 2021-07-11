

.MODEL LARGE
.386
.STACK 200h

.DATA
    byte_val db -48
    
    .CODE
START:
MOV EAX, @DATA
MOV DS, EAX
MOV ES, EAX
    mov al, byte_val ; dividend
    cbw              ; sign-extend AL into AH
    mov bl, 5        ; divisor
    idiv bl          ; quotient AL = - 9 , remainder AH = -3
    
_ET_SALIR:
MOV EAX, 4C00H
INT 21h
END START