#ifndef UTILS_H_INCLUDED
#define UTILS_TS_H_INCLUDED

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <conio.h>
#include <ctype.h>
#include "./constantes.h"
#include "./lista_ts.h"
#include "./arboles.h"

char* obtenerValorString(const char *);
char* obtenerStringHoja(const char *);
char* agregarGuionBajo(const char *);
void guardarAuxiliares(int, t_lista_ts*);
char* obtenerLexemaFloat(const char *);
char* estandarizarString(const char *);
int esCaracterValido(const char);
int esNumero(const char);
int esLetraMin(const char);
int esLetraMayus(const char);
void set_tipo_ids(t_nodoa*, const char*, t_lista_ts*);

#endif