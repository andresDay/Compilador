#ifndef ASSEMBLER_H_INCLUDED
#define ASSEMBLER_H_INCLUDED

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "./constantes.h"
#include "./lista_ts.h"
#include "./arboles.h"
#include "./utils.h"

void generar_assembler(const char*, t_nodoa*, const t_lista_ts*,int);
void generar_sentencia(t_nodoa* ,FILE* ,int);
int es_constante(const char*);
void generar_encabezado(FILE*);
void generar_declaraciones(FILE*, const t_lista_ts*);
void generar_codigo(FILE*, t_nodoa*,int);
void generar_final(FILE*);
char* transformar_a_etiqueta(const char*);
char *obtenerValorOperando(const char *);

int cont_auxiliares;

#endif //ASSEMBLER_H_INCLUDED