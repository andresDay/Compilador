#include "../include/utils.h"

char* obtenerValorString(const char *s)
{
	int i, largo = strlen(s);
	char *inicio, *resultado;
	resultado = (char*) malloc(sizeof(char) * largo - 1);
	if(resultado == NULL)
	{
		return NULL;
	}
	inicio = resultado;
	while(*s) {
		if( *s != '\"')
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

char* obtenerStringHoja(const char *s){
	int i, largo = strlen(s);
	char *inicio, *resultado;
	resultado = (char*) malloc(sizeof(char) * largo + 3 );
	if(resultado == NULL)
	{
		return NULL;
	}
	inicio = resultado;
	while(*s) {
		if( *s != '\"')
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