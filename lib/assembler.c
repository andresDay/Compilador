#include "../include/assembler.h"

void generar_assembler(const char *path_assembler, t_nodoa *p_arbol, const t_lista_ts *p_ts, int indice)
{
	FILE *pf = fopen(path_assembler, "wt");
	if (pf == NULL)
	{
		printf("No se pudo abrir el archivo %s\n", path_assembler);
		exit(ERROR);
	}

	cont_auxiliares = 1;
	cont_if = 1;
	fflush(pf);
	generar_encabezado(pf);
	fflush(pf);
	generar_declaraciones(pf, p_ts);
	fflush(pf);
	generar_codigo(pf, p_arbol, indice, p_ts);
	fflush(pf);
	generar_final(pf);

	fclose(pf);
}

void generar_encabezado(FILE *pf)
{
	fprintf(pf, "include number.asm\n");
	fflush(pf);
	fprintf(pf, "include macros.asm\n\n");
	fflush(pf);
	fprintf(pf, ".MODEL LARGE\n");
	fflush(pf);
	fprintf(pf, ".386\n");
	fflush(pf);
	fprintf(pf, ".STACK 200h\n");
	fflush(pf);
}

void generar_declaraciones(FILE *pf, const t_lista_ts *pl)
{
	char *aux;
	fprintf(pf, "\n.DATA\n");
	fflush(pf);
	while (*pl)
	{
		if (es_constante((*pl)->dato.lexema))
		{
			if (strcmp((*pl)->dato.tipo, T_STRING) == 0)
			{
				fprintf(pf, "%-35s\t%-2s\t%-35s, \'$\', %d dup (?)\n", (*pl)->dato.lexema, PRECISION_STRING, (*pl)->dato.valor, (*pl)->dato.longitud);
				fflush(pf);
			}
			else if (strcmp((*pl)->dato.tipo, T_INTEGER) == 0)
			{
				fprintf(pf, "%-35s\t%-2s\t%s.00\n", (*pl)->dato.lexema, PRECISION_INTEGER, (*pl)->dato.valor);
				fflush(pf);
			}
			else if (strcmp((*pl)->dato.tipo, T_FLOAT) == 0)
			{
				aux = (char *)obtenerLexemaFloat((*pl)->dato.lexema);
				fprintf(pf, "%-35s\t%-2s\t%s\n", aux, PRECISION_FLOAT, (*pl)->dato.valor);
				fflush(pf);
			}
		}
		else
		{
			fprintf(pf, "%-35s\t%-2s\t?\n", (*pl)->dato.lexema, PRECISION_VARIABLE);
			fflush(pf);
		}

		pl = &(*pl)->psig;
	}
}

void generar_codigo(FILE *pf, t_nodoa *p_arbol, int cont, const t_lista_ts *ts)
{
	fprintf(pf, "\n.CODE\n");
	fflush(pf);
	fprintf(pf, "START:\n");
	fflush(pf);
	fprintf(pf, "MOV EAX, @DATA\n");
	fflush(pf);
	fprintf(pf, "MOV DS, EAX\n");
	fflush(pf);
	fprintf(pf, "MOV ES, EAX\n\n");
	fflush(pf);
	t_nodoa *nodo_objetivo;
	t_nodoa *nodo_aux = p_arbol;
	while (nodo_objetivo != NULL)
	{
		nodo_objetivo = obtener_nodo_con_hojas_mas_izq(nodo_aux, pf);
		generar_sentencia(nodo_objetivo, pf, cont, ts);
		if (nodo_objetivo != NULL)
			eliminar_hijos_hoja(nodo_objetivo);
	}
}

void generar_sentencia(t_nodoa *p_nodo, FILE *pf, int cont, const t_lista_ts *ts)
{
	char *string_guion_bajo_est, *aux;
	char *etiqueta;
	char cadena_aux[100], *num, *aux2, base[5] = "@aux";
	num = (char *)malloc(sizeof(char *));
	// aux2 = strdup("");
	// aux = strdup("");
	// etiqueta = strdup("");
	// string_guion_bajo_est= strdup("FALOPA");

	if (p_nodo == NULL)
	{
		return;
	}
	if (strcmp(p_nodo->info.valor, "WRITE") == 0)
	{ //ES UNA SENTENCIA DE WRITE

		if (esCteOrString(p_nodo->der->info.valor))
		{
			printf("\n\n------------------------------\n\nEs constante string\n\n-----------------------------\n\n");
			if (strcmp(p_nodo->der->info.tipo, T_STRING) == 0)
			{
				string_guion_bajo_est = (char *)estandarizarString(obtenerValorString(p_nodo->der->info.valor));
				fprintf(pf, "displayString %s\nnewline 1\n", agregarGuionBajo(string_guion_bajo_est));
				fflush(pf);
			}
			else if (strcmp(p_nodo->der->info.tipo, T_INTEGER) == 0)
			{
				fprintf(pf, "displayFloat %s , 2\nnewline 1\n", p_nodo->der->info.valor);
				fflush(pf);
			}
			else if (strcmp(p_nodo->der->info.tipo, T_FLOAT) == 0)
			{
				aux = (char *)obtenerLexemaFloat(p_nodo->der->info.valor);
				fprintf(pf, "displayFloat %s , 2\nnewline 1\n", aux);
				fflush(pf);
			}
		}
		else
		{
			char *tipo = buscar_tipo(ts, p_nodo->der->info.valor);
			printf("\n\n------------------------------\n\nNo es constante string\nTipo: %s\n\n-----------------------------\n\n", p_nodo->der->info.tipo);
			if (strcmp(tipo, T_STRING) == 0)
			{
				fprintf(pf, "displayString %s\nnewline 1\n", p_nodo->der->info.valor);
				fflush(pf);
			}
			else if (strcmp(tipo, T_INTEGER) == 0)
			{
				fprintf(pf, "displayFloat %s , 0\nnewline 1\n", p_nodo->der->info.valor);
			}
			else if (strcmp(tipo, T_FLOAT) == 0)
			{
				fprintf(pf, "displayFloat %s , 2\nnewline 1\n", p_nodo->der->info.valor);
				fflush(pf);
			}
			else if (strcmp(p_nodo->der->info.tipo, T_NEWLINE) == 0)
			{
				fprintf(pf, "\nnewline 1\n");
				fflush(pf);
			}
		}
		fprintf(pf, "\n");
		fflush(pf);
	}
	else if (strcmp(p_nodo->info.valor, "READ STRING") == 0)
	{	//ES UNA SENTENCIA DE READ
		// fprintf(pf,"getFloat %s\n",p_nodo->der->info.valor);
	}
	else if (p_nodo->der != NULL && strcmp(p_nodo->der->info.valor, "SALIR") == 0)
	{ //ES UN NODO SALIR
		fprintf(pf, "JMP _ET_SALIR\n");
		fflush(pf);
	}
	else if (strcmp(p_nodo->info.valor, "LISTA") == 0)
	{ //ES UN NODO SALIR
		fprintf(pf, "JMP %s\n\n", p_nodo->info.etiquetaEnd);
		fprintf(pf, "%s:\n\n", p_nodo->info.etiquetaThen);
	}
	else if (strcmp(p_nodo->info.valor, "WHILE_ESP") == 0)
	{ //ES UN NODO SALIR
		fprintf(pf, "JMP %s\n\n", p_nodo->info.etiquetaStart);
		fprintf(pf, "%s:\n\n", p_nodo->info.etiquetaEnd);
	}
	else if (strcmp(p_nodo->info.valor, "==") == 0)
	{		
		if (strcmp(p_nodo->info.etiquetaStart, "") != 0)
			fprintf(pf, "%s:\n\n", p_nodo->info.etiquetaStart);
		fflush(pf);	
	
		aux = (char *)obtenerValorOperando(p_nodo->izq->info.valor);
		fprintf(pf, "FLD %s\n", aux);
		fflush(pf);
		aux = (char *)obtenerValorOperando(p_nodo->der->info.valor);
		fprintf(pf, "FLD %s\n", aux);
		fflush(pf);
		fprintf(pf, "FXCH\n");
		fflush(pf);
		fprintf(pf, "FCOM\n");
		fflush(pf);
		fprintf(pf, "FSTSW ax\n");
		fflush(pf);
		fprintf(pf, "SAHF\n");
		fflush(pf);
		fprintf(pf, "FFREE\n");
		fflush(pf);
		//Si no hay cond entonces es condicion simple
		fprintf(pf, "JE %s\n\n", p_nodo->info.etiquetaThen);
		fflush(pf);
	}
	else if (strcmp(p_nodo->info.valor, "IGUAL") == 0)
	{ //ES LA COMPARACION CON EL PIVOTE
		if (p_nodo->info.esWhile == 1)
		{
			if (strcmp(p_nodo->info.etiquetaStart, "") != 0)
				fprintf(pf, "%s:\n\n", p_nodo->info.etiquetaStart);
			fflush(pf);
			p_nodo->info.esWhile = 0;
		}
		aux = (char *)obtenerValorOperando(&p_nodo->izq->info);
		fprintf(pf, "FLD %s\n", aux);
		aux = (char *)obtenerValorOperando(&p_nodo->der->info);
		fprintf(pf, "FLD %s\n", aux);
		fflush(pf);
		fprintf(pf, "FXCH\n");
		fflush(pf);
		fprintf(pf, "FCOM\n");
		fflush(pf);
		fprintf(pf, "FSTSW ax\n");
		fflush(pf);
		fprintf(pf, "SAHF\n");
		fflush(pf);
		fprintf(pf, "FFREE\n");
		fflush(pf);
		//Si no hay cond entonces es condicion simple

		if (p_nodo->info.cond == NULL || strcmp(p_nodo->info.cond, "AND") == 0)
		{
			fprintf(pf, "JNE %s\n\n", p_nodo->info.etiquetaElse);
			fflush(pf);
		}
		else if (strcmp(p_nodo->info.cond, "OR") == 0)
		{
			fprintf(pf, "JE %s\n\n", p_nodo->info.etiquetaThen);
			fflush(pf);
		}
		else if (strcmp(p_nodo->info.cond, "NOT") == 0)
		{
			fprintf(pf, "JE %s\n\n", p_nodo->info.etiquetaElse);
			fflush(pf);
		}
	}
	else if (strcmp(p_nodo->info.valor, "DISTINTO") == 0)
	{ //ES LA COMPARACION CON EL PIVOTE
		if (p_nodo->info.esWhile == 1)
		{
			fprintf(pf, "%s:\n\n", p_nodo->info.etiquetaStart);
			fflush(pf);
			p_nodo->info.esWhile = 0;
		}
		aux = (char *)obtenerValorOperando(p_nodo->izq->info.valor);
		fprintf(pf, "FLD %s\n", aux);
		fflush(pf);
		aux = (char *)obtenerValorOperando(p_nodo->der->info.valor);
		fprintf(pf, "FLD %s\n", aux);
		fflush(pf);
		fprintf(pf, "FXCH\n");
		fflush(pf);
		fprintf(pf, "FCOM\n");
		fflush(pf);
		fprintf(pf, "FSTSW ax\n");
		fflush(pf);
		fprintf(pf, "SAHF\n");
		fflush(pf);
		fprintf(pf, "FFREE\n");
		fflush(pf);
		//Si no hay cond entonces es condicion simple

		if (p_nodo->info.cond == NULL || strcmp(p_nodo->info.cond, "AND") == 0)
		{
			fprintf(pf, "JE %s\n\n", p_nodo->info.etiquetaElse);
			fflush(pf);
		}
		else if (strcmp(p_nodo->info.cond, "OR") == 0)
		{
			fprintf(pf, "JNE %s\n\n", p_nodo->info.etiquetaThen);
			fflush(pf);
		}
		else if (strcmp(p_nodo->info.cond, "NOT") == 0)
		{
			fprintf(pf, "JNE %s\n\n", p_nodo->info.etiquetaElse);
			fflush(pf);
		}
	}
	else if (strcmp(p_nodo->info.valor, "ASIG") == 0)
	{ 
		//ES UNA ASIGNACION
		if (strcmp(p_nodo->der->info.tipo, T_STRING) == 0)
		{
			// string_guion_bajo_est = (char *)estandarizarString(obtenerValorString(p_nodo->der->info.valor));
			// fprintf(pf, "FLD %s\n", agregarGuionBajo(string_guion_bajo_est));
		}
		else
		{
			aux = (char *)obtenerValorOperando(&p_nodo->der->info);
			fprintf(pf, "FLD %s\n", aux);
			fflush(pf);
		}
		fprintf(pf, "FSTP %s\n\n", p_nodo->izq->info.valor);
		fflush(pf);
	}
	else if (strcmp(p_nodo->info.valor, "SUMA") == 0)
	{ //ES UNA SUMA
		aux = (char *)obtenerValorOperando(&p_nodo->izq->info);
		fprintf(pf, "FLD %s\n", aux);
		aux = (char *)obtenerValorOperando(&p_nodo->der->info);
		fprintf(pf, "FLD %s\n", aux);
		fflush(pf);
		fprintf(pf, "FADD\n");
		fflush(pf);
		fprintf(pf, "FSTP %s%d\n\n", "@aux", cont_auxiliares);
		fflush(pf);

		itoa(cont_auxiliares, num, 10);
		aux2 = strdup(base);
		strcat(aux2, num);
		p_nodo->info.valor = aux2;
		p_nodo->info.tipo = T_FLOAT;
		cont_auxiliares++;
	}
	else if (strcmp(p_nodo->info.valor, "RESTA") == 0)
	{ //ES UNA RESTA
		aux = (char *)obtenerValorOperando(&p_nodo->izq->info);
		fprintf(pf, "FLD %s\n", aux);
		aux = (char *)obtenerValorOperando(&p_nodo->der->info);
		fprintf(pf, "FLD %s\n", aux);
		fflush(pf);
		fprintf(pf, "FSUB\n");
		fflush(pf);
		fprintf(pf, "FSTP %s%d\n\n", "@aux", cont_auxiliares);
		fflush(pf);

		itoa(cont_auxiliares, num, 10);
		aux2 = strdup(base);
		strcat(aux2, num);
		p_nodo->info.valor = aux2;
		p_nodo->info.tipo = T_FLOAT;
		cont_auxiliares++;
	}
	else if (strcmp(p_nodo->info.valor, "MULT") == 0)
	{ //ES UNA MULTIPLICACION
		aux = (char *)obtenerValorOperando(&p_nodo->izq->info);
		fprintf(pf, "FLD %s\n", aux);
		aux = (char *)obtenerValorOperando(&p_nodo->der->info);
		fprintf(pf, "FLD %s\n", aux);
		fflush(pf);
		fprintf(pf, "FMUL\n");
		fflush(pf);
		fprintf(pf, "FSTP %s%d\n\n", "@aux", cont_auxiliares);
		fflush(pf);

		itoa(cont_auxiliares, num, 10);
		aux2 = strdup(base);
		strcat(aux2, num);
		p_nodo->info.valor = aux2;
		p_nodo->info.tipo = T_FLOAT;
		cont_auxiliares++;
	}
	else if (strcmp(p_nodo->info.valor, "DIV") == 0)
	{ //ES UNA DIVISION
		aux = (char *)obtenerValorOperando(&p_nodo->izq->info);
		fprintf(pf, "FLD %s\n", aux);
		aux = (char *)obtenerValorOperando(&p_nodo->der->info);
		fprintf(pf, "FLD %s\n", aux);
		fflush(pf);
		fprintf(pf, "FDIV\n");
		fflush(pf);
		fprintf(pf, "FSTP %s%d\n\n", "@aux", cont_auxiliares);
		fflush(pf);

		itoa(cont_auxiliares, num, 10);
		aux2 = strdup(base);
		strcat(aux2, num);
		p_nodo->info.valor = aux2;
		p_nodo->info.tipo = T_FLOAT;
		cont_auxiliares++;
	}
	else if (strcmp(p_nodo->info.valor, "MOD") == 0)
	{ //ES UN MOD
		aux = (char *)obtenerValorOperando(p_nodo->der->info.valor);
		fprintf(pf, "FLD %s\n", aux);
		fflush(pf);
		aux = (char *)obtenerValorOperando(p_nodo->izq->info.valor);
		fprintf(pf, "FLD %s\n", aux);
		fflush(pf);
		fprintf(pf, "FPREM\n");
		fflush(pf);
		fprintf(pf, "FSTP %s%d\n\n", "@aux", cont_auxiliares);
		fflush(pf);

		itoa(cont_auxiliares, num, 10);
		aux2 = strdup(base);
		strcat(aux2, num);
		p_nodo->info.valor = aux2;
		p_nodo->info.tipo = T_FLOAT;
		cont_auxiliares++;
	}
	else if (strcmp(p_nodo->info.valor, "THEN") == 0)
	{
		//ES UN BLOQUE THEN
		fflush(pf);
		fprintf(pf, "JMP %s\n\n", p_nodo->info.etiquetaEnd);
		fflush(pf);
		fprintf(pf, "%s:\n\n", p_nodo->info.etiquetaElse);
		fflush(pf);
	}
	else if (strcmp(p_nodo->info.valor, "IF") == 0)
	{
		//ES UNA SELECCIÓN
		fprintf(pf, "%s:\n\n", p_nodo->info.etiquetaEnd);
		fflush(pf);
	}
	else if (strcmp(p_nodo->info.valor, "IF_ELSE") == 0)
	{
		//ES UNA SELECCIÓN CON ELSE
		fprintf(pf, "%s:\n\n", p_nodo->info.etiquetaEnd);
		fflush(pf);
	}
	else if (strcmp(p_nodo->info.valor, "OR") == 0)
	{
		//ES UNA SELECCIÓN CON ELSE
		fprintf(pf, "JMP %s\n\n", p_nodo->info.etiquetaElse);
		fflush(pf);
		fprintf(pf, "%s:\n\n", p_nodo->info.etiquetaThen);
		fflush(pf);
	}
	else if (strcmp(p_nodo->info.valor, "WHILE") == 0)
	{
		fprintf(pf, "JMP %s\n\n", p_nodo->info.etiquetaStart);
		fflush(pf);
		fprintf(pf, "%s:\n\n", p_nodo->info.etiquetaEnd);
		fflush(pf);
	}
	else if (strcmp(p_nodo->info.valor, "MAYOR") == 0)
	{
		if (p_nodo->info.esWhile == 1)
		{
			fprintf(pf, "%s:\n\n", p_nodo->info.etiquetaStart);
			fflush(pf);
			p_nodo->info.esWhile = 0;
		}
		aux = (char *)obtenerValorOperando(&p_nodo->izq->info);
		fprintf(pf, "FLD %s\n", aux);
		aux = (char *)obtenerValorOperando(&p_nodo->der->info);
		fprintf(pf, "FLD %s\n", aux);
		fflush(pf);
		fprintf(pf, "FXCH\n");
		fflush(pf);
		fprintf(pf, "FCOM\n");
		fflush(pf);
		fprintf(pf, "FSTSW ax\n");
		fflush(pf);
		fprintf(pf, "SAHF\n");
		fflush(pf);
		fprintf(pf, "FFREE\n");
		fflush(pf);
		//Si no hay cond entonces es condicion simple

		if (p_nodo->info.cond == NULL || strcmp(p_nodo->info.cond, "AND") == 0)
		{
			fprintf(pf, "JNA %s\n\n", p_nodo->info.etiquetaElse);
			fflush(pf);
		}
		else if (strcmp(p_nodo->info.cond, "OR") == 0)
		{
			fprintf(pf, "JA %s\n\n", p_nodo->info.etiquetaThen);
			fflush(pf);
		}
		else if (strcmp(p_nodo->info.cond, "NOT") == 0)
		{
			fprintf(pf, "JA %s\n\n", p_nodo->info.etiquetaElse);
			fflush(pf);
		}
	}
	else if (strcmp(p_nodo->info.valor, "MENOR") == 0)
	{
		if (p_nodo->info.esWhile == 1)
		{
			fprintf(pf, "%s:\n\n", p_nodo->info.etiquetaStart);
			fflush(pf);
			p_nodo->info.esWhile = 0;
		}
		aux = (char *)obtenerValorOperando(&p_nodo->izq->info);
		fprintf(pf, "FLD %s\n", aux);
		aux = (char *)obtenerValorOperando(&p_nodo->der->info);
		fprintf(pf, "FLD %s\n", aux);
		fflush(pf);
		fprintf(pf, "FXCH\n");
		fflush(pf);
		fprintf(pf, "FCOM\n");
		fflush(pf);
		fprintf(pf, "FSTSW ax\n");
		fflush(pf);
		fprintf(pf, "SAHF\n");
		fflush(pf);
		fprintf(pf, "FFREE\n");
		fflush(pf);
		//Si no hay cond entonces es condicion simple

		if (p_nodo->info.cond == NULL || strcmp(p_nodo->info.cond, "AND") == 0)
		{
			fprintf(pf, "JNB %s\n\n", p_nodo->info.etiquetaElse);
			fflush(pf);
		}
		else if (strcmp(p_nodo->info.cond, "OR") == 0)
		{
			fprintf(pf, "JB %s\n\n", p_nodo->info.etiquetaThen);
			fflush(pf);
		}
		else if (strcmp(p_nodo->info.cond, "NOT") == 0)
		{
			fprintf(pf, "JB %s\n\n", p_nodo->info.etiquetaElse);
			fflush(pf);
		}
	}
	else if (strcmp(p_nodo->info.valor, "MENOR O IGUAL") == 0)
	{
		if (p_nodo->info.esWhile == 1)
		{
			// fprintf(pf, "%s:\n\n", p_nodo->info.etiquetaStart);
			fflush(pf);
			p_nodo->info.esWhile = 0;
		}
		aux = (char *)obtenerValorOperando(&p_nodo->izq->info);
		fprintf(pf, "FLD %s\n", aux);
		aux = (char *)obtenerValorOperando(&p_nodo->der->info);
		fprintf(pf, "FLD %s\n", aux);
		fflush(pf);
		fprintf(pf, "FXCH\n");
		fflush(pf);
		fprintf(pf, "FCOM\n");
		fflush(pf);
		fprintf(pf, "FSTSW ax\n");
		fflush(pf);
		fprintf(pf, "SAHF\n");
		fflush(pf);
		fprintf(pf, "FFREE\n");
		fflush(pf);
		//Si no hay cond entonces es condicion simple
		fflush(pf);
		if (p_nodo->info.cond == NULL || strcmp(p_nodo->info.cond, "AND") == 0)
			fprintf(pf, "JA %s\n\n", p_nodo->info.etiquetaElse);
		else if (strcmp(p_nodo->info.cond, "OR") == 0)
			fprintf(pf, "JBE %s\n\n", p_nodo->info.etiquetaThen);
		else if (strcmp(p_nodo->info.cond, "NOT") == 0)
			fprintf(pf, "JBE %s\n\n", p_nodo->info.etiquetaElse);
		fflush(pf);
	}
	else if (strcmp(p_nodo->info.valor, "MAYOR O IGUAL") == 0)
	{
		if (p_nodo->info.esWhile == 1)
		{
			fprintf(pf, "%s:\n\n", p_nodo->info.etiquetaStart);
			fflush(pf);
			p_nodo->info.esWhile = 0;
		}
		aux = (char *)obtenerValorOperando(&p_nodo->izq->info);
		fprintf(pf, "FLD %s\n", aux);
		aux = (char *)obtenerValorOperando(&p_nodo->der->info);
		fprintf(pf, "FLD %s\n", aux);
		fflush(pf);
		fprintf(pf, "FXCH\n");
		fflush(pf);
		fprintf(pf, "FCOM\n");
		fflush(pf);
		fprintf(pf, "FSTSW ax\n");
		fflush(pf);
		fprintf(pf, "SAHF\n");
		fflush(pf);
		fprintf(pf, "FFREE\n");
		fflush(pf);
		//Si no hay cond entonces es condicion simple
		fflush(pf);
		if (p_nodo->info.cond == NULL || strcmp(p_nodo->info.cond, "AND") == 0)
			fprintf(pf, "JB %s\n\n", p_nodo->info.etiquetaElse);
		else if (strcmp(p_nodo->info.cond, "OR") == 0)
			fprintf(pf, "JAE %s\n\n", p_nodo->info.etiquetaThen);
		else if (strcmp(p_nodo->info.cond, "NOT") == 0)
			fprintf(pf, "JAE %s\n\n", p_nodo->info.etiquetaElse);

		fflush(pf);
	}
}

void generar_final(FILE *pf)
{
	fprintf(pf, "\n_ET_SALIR:");
	fflush(pf);
	fprintf(pf, "\nMOV EAX, 4C00H\n");
	fflush(pf);
	fprintf(pf, "INT 21h\n");
	fflush(pf);
	fprintf(pf, "END START");
	fflush(pf);
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

int esCteOrString(const char *s)
{
	return (*s >= '0' && *s <= '9') || *s == '"' || *s == '\\';
}

char *obtenerValorOperando(const t_info* info)
{
	char *res;
	if (*(info->valor) >= '0' && *(info->valor) <= '9')
	{
		res = obtenerLexemaFloat(info->valor);
	}
	else
	{
		res = strdup(info->valor);
	}

	return res;
}