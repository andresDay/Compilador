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
		if (*s != '\"')
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

void guardarAuxiliares(int cont_auxiliares)
{
	int _cont = 1;
	t_dato_lista_ts dato;
	while ( _cont <= cont_auxiliares)
	{
		dato.lexema = (char*)malloc(5000);
		sprintf(dato.lexema, "@aux%d", _cont);
		dato.tipo = "id";
		dato.valor = NULL;
		dato.longitud = 0;

		insertar_ordenado_ts(&tablaSimbolos, &dato, comparacion_ts);
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
	if(*s != '_'){
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