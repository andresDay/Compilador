#include "../include/assembler.h"

void generar_assembler(const char *path_assembler, t_nodoa *p_arbol, const t_lista_ts *p_ts, int indice)
{
	FILE *pf = fopen(path_assembler, "wt");
	if (pf == NULL)
	{
		printf("No se pudo abrir el archivo %s\n", path_assembler);
		exit(ERROR);
	}

	generar_encabezado(pf);
	generar_declaraciones(pf, p_ts);
	generar_codigo(pf, p_arbol,indice);
	generar_final(pf);

	fclose(pf);
}

void generar_encabezado(FILE *pf)
{
	fprintf(pf, "include number.asm\n");
	fprintf(pf, "include macros2.asm\n\n");
	fprintf(pf, ".MODEL LARGE\n");
	fprintf(pf, ".386\n");
	fprintf(pf, ".STACK 200h\n");
}

void generar_declaraciones(FILE *pf, const t_lista_ts *pl)
{
	fprintf(pf, "\n.DATA\n");
	while (*pl)
	{
		if (es_constante((*pl)->dato.lexema))
		{
			if (strcmp((*pl)->dato.tipo, T_STRING) == 0)
			{
				fprintf(pf, "%-35s\t%-2s\t%-35s, \'$\', %d dup (?)\n", (*pl)->dato.lexema, PRECISION_STRING, obtenerValorString((*pl)->dato.valor), (*pl)->dato.longitud);
			}
			else if (strcmp((*pl)->dato.tipo, T_INTEGER) == 0)
			{
				fprintf(pf, "%-35s\t%-2s\t%s.00\n", (*pl)->dato.lexema, PRECISION_INTEGER, (*pl)->dato.valor);
			}
			else if (strcmp((*pl)->dato.tipo, T_FLOAT) == 0)
			{
				fprintf(pf, "%-35s\t%-2s\t%s.00\n", (*pl)->dato.lexema, PRECISION_FLOAT, (*pl)->dato.valor);
			}
		}
		else
		{
			fprintf(pf, "%-35s\t%-2s\t?\n", (*pl)->dato.lexema, PRECISION_VARIABLE);
		}

		pl = &(*pl)->psig;
	}
}

void generar_codigo(FILE *pf, t_nodoa *p_arbol, int cont)
{
	fprintf(pf, "\n.CODE\n");
	fprintf(pf, "START:\n");
	fprintf(pf, "MOV EAX, @DATA\n");
	fprintf(pf, "MOV DS, EAX\n");
	fprintf(pf, "MOV ES, EAX\n\n");
	t_nodoa *nodo_objetivo;
	t_nodoa *nodo_aux = p_arbol;
	while (nodo_objetivo != NULL)
	{
		nodo_objetivo = obtener_nodo_con_hojas_mas_izq(nodo_aux, pf);
		generar_sentencia(nodo_objetivo, pf, cont);
		if (nodo_objetivo != NULL)
		{
			if (strcmp(nodo_objetivo->info.valor, ">=") == 0 || strcmp(nodo_objetivo->info.valor, "==") == 0)
			{
				cont--;
			}
		}
		eliminar_hijos_hoja(nodo_objetivo);
	}
}

void generar_sentencia(t_nodoa *p_nodo, FILE *pf, int cont)
{
	char *string_guion_bajo_est, *aux;
	char *etiqueta;
	char cadena_aux[100];
	if (p_nodo == NULL)
	{
		return;
	}
	if (strcmp(p_nodo->info.valor, "WRITE") == 0)
	{ //ES UNA SENTENCIA DE WRITE

		// if(strcmp(p_nodo->der->info.tipo,T_STRING)==0){
		// 	string_guion_bajo_est = (char*)obtenerValorString(p_nodo->der->info.valor);
		// 	fprintf(pf,"displayString %s\nnewline 1\n",string_guion_bajo_est);
		// }
		// else{
		// 	fprintf(pf,"displayFloat %s , 2\nnewline 1\n",p_nodo->der->info.valor);
		// }
	}
	else if (strcmp(p_nodo->info.valor, "READ") == 0)
	{	//ES UNA SENTENCIA DE READ
		// fprintf(pf,"getFloat %s\n",p_nodo->der->info.valor);
	}
	else if (p_nodo->der != NULL && strcmp(p_nodo->der->info.valor, "SALIR") == 0)
	{ //ES UN NODO SALIR
		fprintf(pf, "JMP _ET_SALIR\n");
	}
	else if (strcmp(p_nodo->info.valor, ">=") == 0)
	{	//ES LA VALIDACION DEL PIVOTE
		// fprintf(pf,"FLD %s\n",p_nodo->izq->info.valor);
		// fprintf(pf,"FLD _@uno\n");
		// fprintf(pf,"FXCH\nFCOM\nFSTSW\tAX\nSAHF\nFFREE\n");
		// sprintf(cadena_aux,"%d",cont);
		// etiqueta=(char*)malloc(sizeof(cadena_aux)+sizeof("CUERPO"));
		// strcpy(etiqueta,"CUERPO");
		// strcat(etiqueta,cadena_aux);
		// aux=transformar_a_etiqueta(etiqueta);
		// fprintf(pf,"JNB %s\n",aux);
	}
	else if (strcmp(p_nodo->info.valor, "==") == 0)
	{	//ES LA COMPARACION CON EL PIVOTE
		// fprintf(pf,"FLD %s\n",p_nodo->izq->info.valor);
		// aux=(char*)agregar_guion_bajo(p_nodo->der->info.valor);
		// fprintf(pf,"FLD %s\n",aux);
		// fprintf(pf,"FXCH\nFCOM\nFSTSW\tAX\nSAHF\nFFREE\n");
		// sprintf(cadena_aux,"%d",cont);
		// etiqueta=(char*)malloc(sizeof(cadena_aux)+sizeof("CUERPO"));
		// strcpy(etiqueta,"CUERPO");
		// strcat(etiqueta,cadena_aux);
		// aux=transformar_a_etiqueta(etiqueta);
		// fprintf(pf,"JE %s\n",aux);
	}
	else if (strcmp(p_nodo->info.valor, "=") == 0)
	{	//ES UNA ASIGNACION
		// if(strcmp(p_nodo->der->info.valor,"+")==0){
		// 	fprintf(pf,"FSTP %s\n",p_nodo->izq->info.valor);
		// }
		// else if(strcmp(p_nodo->der->info.valor,"0")==0){
		// 	fprintf(pf,"FLD _@cero\n");
		// 	fprintf(pf,"FSTP %s\n",p_nodo->izq->info.valor);
		// }
		// else{
		// 	fprintf(pf,"FLD %s\n",p_nodo->der->info.valor);
		// 	fprintf(pf,"FSTP %s\n",p_nodo->izq->info.valor);
		// }
	}
	else if (strcmp(p_nodo->info.valor, "SUMA") == 0)
	{ //ES UNA SUMA
		fprintf(pf, "FLD %s\n", p_nodo->izq->info.valor);
		fprintf(pf, "FLD %s\n", p_nodo->der->info.valor);
		fprintf(pf, "FADD\n");
	}
	else if (strcmp(p_nodo->info.valor, "RESTA") == 0)
	{ //ES UNA RESTA
		fprintf(pf, "FLD %s\n", p_nodo->izq->info.valor);
		fprintf(pf, "FLD %s\n", p_nodo->der->info.valor);
		fprintf(pf, "FSUB\n");
	}
	else if (strcmp(p_nodo->info.valor, "MULT") == 0)
	{ //ES UNA MULTIPLICACION
		fprintf(pf, "FLD %s\n", p_nodo->izq->info.valor);
		fprintf(pf, "FLD %s\n", p_nodo->der->info.valor);
		fprintf(pf, "FMUL\n");
	}
	else if (strcmp(p_nodo->info.valor, "DIV") == 0)
	{ //ES UNA DIVISION
		fprintf(pf, "FLD %s\n", p_nodo->izq->info.valor);
		fprintf(pf, "FLD %s\n", p_nodo->der->info.valor);
		fprintf(pf, "FDIV\n");
	}
}

void generar_final(FILE *pf)
{
	fprintf(pf, "\n_ET_SALIR:");
	fprintf(pf, "\nMOV EAX, 4C00H\n");
	fprintf(pf, "INT 21h\n");
	fprintf(pf, "END START");
}

char *transformar_a_etiqueta(const char *s)
{
	char *resultado, *paux;
	int len_etiqueta = strlen(ETIQUETA);
	resultado = (char *)malloc(sizeof(char) * (len_etiqueta + strlen(s)) + 1);
	if (resultado == NULL)
	{
		return NULL;
	}
	strcpy(resultado, ETIQUETA);
	strcat(resultado, s);
	return resultado;
}

int es_constante(const char *s)
{
	return *s == '_';
}
