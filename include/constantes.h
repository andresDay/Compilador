#ifndef CONSTANTES_H_INCLUDED
#define CONSTANTES_H_INCLUDED

/* RETORNO GENERAL */
#define ERROR 1
#define TODO_BIEN 0

#define LISTA_DUPLICADO 2
#define LISTA_LLENA 2

#define PILA_VACIA 0
#define PILA_LLENA 1

#define LEXICO_CANTIDAD_GUIONES_BAJOS 1
#define ETIQUETA "_ET_"

// TIPOS DE DATO
#define T_INTEGER "integer"
#define T_FLOAT "float"
#define T_STRING "string"

/* CONSTANTES DE ASSEMBLER */

// Cantidad de bits para representación
#define PRECISION_STRING "db"
#define PRECISION_INTEGER "dd"
#define PRECISION_FLOAT "dd"
#define PRECISION_VARIABLE "dd"

// Aritmética
#define CMD_SUMAR "FADD"
#define CMD_RESTAR "FSUB"
#define CMD_DIVIDIR "FDIV"
#define CMD_MULTIPLICAR "FMUL"

// Operaciones con pila
#define CMD_PUSH "FLD"
#define CMD_POP "FSTP"
#define CMD_LIBERAR "FFREE"

#define CMD_XCH "FXCH"

// Operaciones input/output
#define CMD_OUT_FLOAT "DisplayFloat"
#define CMD_OUT_STRING "DisplayString"
#define CMD_NUEVA_LINEA "newline 1"
#define CMD_IN_FLOAT "GetFloat"

// Comparaciones
#define CMD_CMP "FCOM"
#define CMD_STSW "FSTSW AX"
#define CMD_SAHF "SAHF"

#define CMD_BI "JMP"
#define CMD_BLT "JNAE"
#define CMD_BLE "JBE"
#define CMD_BGT "JNBE"
#define CMD_BGE "JNB"
#define CMD_BEQ "JE"
#define CMD_BNE "JNE"

#define CANTIDAD_CORCHETES 2
#define CANTIDAD_DOS_PUNTOS 1

#endif