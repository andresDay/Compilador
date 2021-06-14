#include "../include/pila.h"

void crear_pila (t_pila* pila)
{
   *pila=NULL;
}

int pila_llena(const t_pila* pila)
{
    void* aux;
    aux=malloc(sizeof(t_nodo_pila));
    free(aux);
    return aux==NULL;
}

int pila_vacia(const t_pila*pila)
{
    return *pila ==NULL;
}

int apilar (t_pila* pila ,const t_dato_pila* dato)
{
    t_nodo_pila *nodo;
    nodo=(t_nodo_pila*) malloc(sizeof(t_nodo_pila));
    if(!nodo)
        return PILA_LLENA;
    nodo->dato= *dato;
    nodo->psig=*pila;
    *pila=nodo;
    return TODO_BIEN;
}

int desapilar(t_pila* pila ,t_dato_pila* dato )
{
	t_nodo_pila *nodo;
    if(!*pila)
        return PILA_VACIA;
    nodo=*pila;
    *dato= nodo->dato;
    *pila= nodo->psig;
    free(nodo);
    return TODO_BIEN;
}

int ver_tope(const t_pila* pila ,t_dato_pila* dato )
{
    if(!*pila)
        return PILA_VACIA;
    *dato=(*pila)->dato;
    return TODO_BIEN;
}

void vaciar_pila(t_pila* pila )
{
    t_nodo_pila*nodo;
    while(*pila)
    {
        nodo=*pila;
        *pila=nodo->psig;
        free(nodo);
    }
}
