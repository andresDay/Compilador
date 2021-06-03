#include "..\include\arboles.h"
#include <stdio.h>
#include <stdlib.h>
#include "..\include\constantes.h"

///----------------------------

void crear_arbol(t_arbol *pa)
{
    *pa=NULL;
}

int crear_nodo( t_nodoa *hijo_izquierdo, t_nodoa *padre, t_nodoa *hijo_derecho,FILE* pf)
{
	padre->izq=hijo_izquierdo;
	padre->der=hijo_derecho;
	if(padre->izq!=NULL){
		fprintf(pf,"nodo%d->nodo%d\n",padre->info.indice,hijo_izquierdo->info.indice);
	}
	if(padre->der!=NULL){
		fprintf(pf,"nodo%d->nodo%d\n",padre->info.indice,hijo_derecho->info.indice);
	}
	return TODO_BIEN;
}

t_nodoa* crear_hoja(const t_info* d,FILE* pf)
{
	char comillas='"';
	t_nodoa* p_nodo;
	p_nodo=(t_nodoa*)malloc(sizeof(t_nodoa));
    if(p_nodo==NULL){
        return p_nodo;
    }
    p_nodo->izq=NULL;
    p_nodo->der=NULL;
    p_nodo->info=*d;
	printf("nodo%d[label=%c%s%c];\n",d->indice,comillas,d->valor,comillas);
	fprintf(pf,"nodo%d[label=%c%s%c];\n",d->indice,comillas,d->valor,comillas);
	return p_nodo;
}

t_nodoa* obtener_nodo_con_hojas_mas_izq(t_nodoa *p_nodo,FILE* pf)
{
	t_nodoa* p_nodo_objetivo;
	char* aux;
	while(p_nodo!=NULL){
		if(es_padre_con_hojas(p_nodo)==0){
			p_nodo_objetivo=p_nodo;
			return p_nodo_objetivo;
		}
		else if(p_nodo->izq==NULL && p_nodo->der==NULL){
			p_nodo_objetivo=NULL;
			return p_nodo_objetivo;
		}
		else if(strncmp(p_nodo->info.valor,"CUERPO",6)==0){
			if(es_hoja(p_nodo->izq)==0){
				if(p_nodo->info.etiqueta_escrita==0){//DEBO ESCRIBIR LA ETIQUETA DE CUERPO
					p_nodo->info.etiqueta_escrita=1;
					// aux=(char*)transformar_a_etiqueta(p_nodo->info.valor);
					fprintf(pf,"%s:\n",aux);
				}
			}
		}
		if(p_nodo->izq!=NULL){
		}
		if(es_padre_con_hojas(p_nodo->izq)==0){//RETURNO EL HIJO IZQUIERDO
			p_nodo_objetivo=p_nodo->izq;
			return p_nodo_objetivo;
		}
		else if(p_nodo->izq!=NULL && es_hoja(p_nodo->izq)!=0){
			p_nodo=p_nodo->izq; //AVANZO POR IZQUIERDA
		}
		else if(es_padre_con_hojas(p_nodo->der)==0){//RETORNO EL HIJO DERECHO
			p_nodo_objetivo=p_nodo->der;
			return p_nodo_objetivo;
		}
		else if(p_nodo->der!=NULL && es_hoja(p_nodo->der)!=0){
			p_nodo=p_nodo->der; //AVANZO POR DERECHA
		}
		
	}
	return p_nodo_objetivo;
}

int es_hoja(const t_nodoa* nodo)
{
	if(nodo->izq==NULL && nodo->der==NULL){
		return 0;
	}
	return 1;
}

void eliminar_hijos_hoja(t_nodoa* p_nodo)
{
	if(p_nodo==NULL){
		return;
	}
	if(p_nodo->izq!=NULL){
		free(p_nodo->izq);
		p_nodo->izq=NULL;
	}
	if(p_nodo->der!=NULL){
		free(p_nodo->der);
		p_nodo->der=NULL;
	}
}

int es_padre_con_hojas(const t_nodoa* nodo)
{
	if(nodo==NULL){
		return 1;
	}
	if(nodo->izq!=NULL){
		if(es_hoja(nodo->izq)==0){
			if(nodo->der==NULL){
				return 0;
			}
			else if(es_hoja(nodo->der)==0){
				return 0;
			}
		}
		return 1;
	}
	else if(nodo->der!=NULL){
		if(es_hoja(nodo->der)==0){
			return 0;
		}
		return 1;
	}
	return 1;
}

void graficar_arbol(t_arbol *pa)
{
    graficar_arbol_rec(pa,0);
}

void graficar_arbol_rec(t_arbol *pa,int n)
{
    int i;
    if(*pa==NULL){
        return;
    }
    graficar_arbol_rec(&(*pa)->der,n+1);
    for(i=0;i<n;i++){
        printf("\t");
    }
    printf("%s\n",(*pa)->info.valor);
    graficar_arbol_rec(&(*pa)->izq,n+1);
}


