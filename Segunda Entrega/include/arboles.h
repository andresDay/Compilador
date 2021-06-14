#ifndef ARBOLES_H_INCLUDED
#define ARBOLES_H_INCLUDED
#include <stdio.h>
#include <string.h>

typedef struct
{
	int indice;//PARA EL GRAPHVIZ
    char* valor;
	char* tipo;//PARA SABER SI ES UNA CTE O UNA STRING
	int etiqueta_escrita;
}t_info;

typedef struct s_nodoa
{
    t_info info;
    struct s_nodoa *izq;
    struct s_nodoa *der;
}t_nodoa;

typedef t_nodoa* t_arbol;

typedef struct
{
	int indice;//PARA EL MANEJO DE ETIQUETAS
	t_nodoa* nodo;
}t_aux;

///-----------------------


void crear_arbol(t_arbol *pa);
int crear_nodo( t_nodoa *, t_nodoa *, t_nodoa *,FILE*);
t_nodoa* crear_hoja(const t_info*, FILE*);
void graficar_arbol(t_arbol *pa);
void graficar_arbol_rec(t_arbol*pa,int n);
t_nodoa* obtener_nodo_con_hojas_mas_izq(t_nodoa *,FILE*);
void eliminar_hijos_hoja(t_nodoa* );
int es_padre_con_hojas(const t_nodoa*);
int es_hoja(const t_nodoa*);

#endif // ARBOLES_H_INCLUDED
