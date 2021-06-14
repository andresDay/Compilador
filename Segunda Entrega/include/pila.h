#ifndef PILA_H_INCLUDED
#define PILA_H_INCLUDED

#include <stdio.h>
#include <stdlib.h>
#include "./constantes.h"
#include "./arboles.h"

typedef t_nodoa* t_dato_pila;
typedef struct s_nodo_pila
{
    t_dato_pila dato;
    struct s_nodo_pila *psig;
} t_nodo_pila;
typedef t_nodo_pila* t_pila;

void crear_pila (t_pila*);
int pila_llena(const t_pila*);
int pila_vacia(const t_pila*);
int apilar (t_pila*,const t_dato_pila*);
int desapilar(t_pila*,t_dato_pila*);
int ver_tope(const t_pila*,t_dato_pila*);
void vaciar_pila (t_pila*);

#endif // PILA_H_INCLUDED
