%{
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include "y.tab.h"
FILE  *yyin;
int yylval;

%}

%option noyywrap  
%option yylineno 


DIGITO			[0-9]
LETRA			[a-zA-Z]
ID			{LETRA}({LETRA}|{DIGITO}|_)*
CTE_CADENA  \"([^\"\\\\]|\\\\.)*\"
CTE_INT     {DIGITO}+
COMMENT     "{\/\/}{CTE_CADENA}*"
%%

":"         {return DECLARACION;}
";"         { return P_COMA;}
","         { return COMA;}
"="			{ return ASIG;}
"=="        { return IGUAL;}
">"         { return MAYOR;}
"<"         { return MENOR;}
">="        { return MAYOR_IGUAL;}
"<="        { return MENOR_IGUAL;}
"+"			{ return OP_SUMA;}
"-"         { return OP_RESTA};
"*"         { return OP_MULT;}
"/"         {return OP_DIV;}
"("			{ return P_A;}
")"			{ return P_C;}
"["         { return C_A;}
"]"         { return C_C;}
"escribir"  { return ESCRIBIR;}
"escanear"  {return ESCANEAR;}
"concatenar" {return CONCATENAR;}
"DECVAR"    {return DECVAR;}
"ENDDEC"    {return ENDDEC;}
"char[]"    {return CHAR_ARRAY;}
"integer"   {return INTEGER;}
"char"      {return CHAR;}
"BEGIN"     {return BEGIN;}
"END"       {return END;}
"IF"        {return IF;}
"WHILE"     {return WHILE;}

{ID}		{ return ID;}
{CTE_INT}	{ yylval = atoi( yytext ) ;return CTE_INT;}

"\n"      		
"\t"	//hola soy matias
{COMMENT} //esto ignora comentarios en linea supuestamente