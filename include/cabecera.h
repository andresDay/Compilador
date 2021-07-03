#ifndef CABECERA_H_INCLUDED
#define CABECERA_H_INCLUDED



#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <float.h>
#include <conio.h>
#include <ctype.h>
#include "../y.tab.h"
#include "./utils.h"
#include "./constantes.h"
#include "./lista_ts.h"
#include "./arboles.h"
#include "./pila.h"
#include "./assembler.h"
extern int yylineno;
extern FILE *yyin;
extern FILE *pf;
t_lista_ts tablaSimbolos;
int indice;

// Tabla de simbolos
int validarCteInt(const int cte);
int validarCteReal(const float real);
int validarCteString(const char *string);
int validarId(const char *id);

void ingresarCteInt(const int cte);
void ingresarCteReal(const float real);
void ingresarCteString(const char *string);
void ingresarId(const char *id);

#endif // CABECERA_H_INCLUDED