#ifndef UTILS_H_INCLUDED
#define UTILS_TS_H_INCLUDED

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "./cabecera.h"
#include "./constantes.h"

char* obtenerValorString(const char *);
char* obtenerStringHoja(const char *);
char* agregarGuionBajo(const char *);
void guardarAuxiliares(int);
char* obtenerLexemaFloat(const char *);
char* estandarizarString(const char *);
int esCaracterValido(const char);
int esNumero(const char);
int esLetraMin(const char);
int esLetraMayus(const char);

#endif