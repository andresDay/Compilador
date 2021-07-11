#include "../include/utils.h"

char *obtenerValorString(const char *s)
{
	int i, largo = strlen(s);
	char *inicio, *resultado;
	resultado = (char *)malloc(sizeof(char) * largo - 1);
	if (resultado == NULL)
	{
		return NULL;
	}
	inicio = resultado;
	while (*s)
	{
		if (*s != '\"' && *s != '\\')
		{
			*resultado = *s;
			resultado++;
			s++;
		}
		else
		{
			s++;
		}
	}
	*resultado = '\0';
	return inicio;
}

char *obtenerStringHoja(const char *s)
{
	int i, largo = strlen(s);
	char *inicio, *resultado;
	resultado = (char *)malloc(sizeof(char) * largo + 3);
	if (resultado == NULL)
	{
		return NULL;
	}
	inicio = resultado;
	while (*s)
	{
		if (*s != '\"')
		{
			*resultado = *s;
			resultado++;
			s++;
		}
		else
		{
			*resultado = '\\';
			resultado++;
			*resultado = '\"';
			resultado++;
			s++;
		}
	}
	*resultado = '\0';
	return inicio;
}

char *agregarGuionBajo(const char *s)
{
	char *resultado;
	resultado = (char *)malloc(sizeof(char) * strlen(s) + LEXICO_CANTIDAD_GUIONES_BAJOS + 1);
	if (resultado == NULL)
	{
		return NULL;
	}
	strcpy(resultado, "_");
	strcat(resultado, s);
	return resultado;
}

void guardarAuxiliares(int cont_auxiliares, t_lista_ts *ts)
{
	int _cont = 1;
	t_dato_lista_ts dato;
	while (_cont <= cont_auxiliares)
	{
		dato.lexema = (char *)malloc(5000);
		sprintf(dato.lexema, "@aux%d", _cont);
		dato.tipo = "id";
		dato.valor = NULL;
		dato.longitud = 0;

		insertar_ordenado_ts(ts, &dato, comparacion_ts);
		_cont++;
	}
}

char *obtenerLexemaFloat(const char *s)
{
	int i, largo = strlen(s);
	char *inicio, *resultado;
	resultado = (char *)malloc(sizeof(char) * largo + 1);
	if (resultado == NULL)
	{
		return NULL;
	}
	inicio = resultado;
	if (*s != '_')
	{
		*resultado = '_';
		resultado++;
	}
	while (*s)
	{
		if (*s != '.')
		{
			*resultado = *s;
			resultado++;
			s++;
		}
		else
		{
			*resultado = '_';
			resultado++;
			s++;
		}
	}
	*resultado = '\0';
	return inicio;
}

char *estandarizarString(const char *s)
{
	char *resultado, *paux;
	resultado = (char *)malloc(sizeof(char) * strlen(s) + 1);
	if (resultado == NULL)
	{
		return NULL;
	}
	strcpy(resultado, s);
	paux = resultado;
	while (*paux != '\0')
	{
		if (!esCaracterValido(*paux))
		{
			*paux = '_';
		}
		else if (esLetraMayus(*paux))
		{
			*paux = tolower(*paux);
		}
		paux++;
	}
	return resultado;
}

int esCaracterValido(const char c)
{
	return esNumero(c) || esLetraMin(c) || esLetraMayus(c) || c == '_';
}

int esNumero(const char c)
{
	return c >= '0' && c <= '9';
}

int esLetraMin(const char c)
{
	return c >= 'a' && c <= 'z';
}

int esLetraMayus(const char c)
{
	return c >= 'A' && c <= 'Z';
}

void set_tipo_ids(t_nodoa *pa, const char *tipo, t_lista_ts *ts)
{
	if (pa == NULL)
	{
		return;
	}

	set_tipo_ids(pa->izq, tipo, ts);
	set_tipo_ids(pa->der, tipo, ts);
	if (pa->izq == NULL && pa->der == NULL)
	{
		// printf("%s, ", pa->info.valor);
		pa->info.tipo = strdup(tipo);
		cambiar_campo_tipo(ts, pa->info.valor, tipo);
	}
}

char* idExists(const t_lista_ts *ts, const char *lexema, int line)
{
	char *res = buscar_tipo(ts, lexema);
	if (res == NULL || strcmp(res, T_ID) == 0)
	{
		printf("\n\n*****************************************************************************************\n");
		printf("ERROR!\n");
		fprintf(stderr, "error: in line %d\n", line);
		fprintf(stderr, "Variable \"%s\" not defined\n", lexema);
		printf("*****************************************************************************************\n\n");
		system("Pause");
		exit(1);
	}

	return res;
}

void validateId(const t_lista_ts *ts, const char *lexema, const char *tipo, int line){

	char *res = idExists(ts, lexema, line);

	if (strcmp(tipo, res) != 0)
	{
		printf("\n\n*****************************************************************************************\n");
		printf("ERROR!\n");
		fprintf(stderr, "error: in line %d\n", line);
		fprintf(stderr, "No se puede asignar un valor de tipo %s a la variable \"%s\" de tipo %s\n", tipo, lexema, res);
		printf("*****************************************************************************************\n\n");
		system("Pause");
		exit(1);
	}
}