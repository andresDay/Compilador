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
DELIM           [ \t\n\r]
CARACTER    [a-z|A-Z|0-9|=|>|<|!|:|+|-|*|/|?|¿|!|¡|@|%|#|&|°|´|^|`|~|/|\\|-|_|.|,|;|¬||]
VALID_STRING    ({CARACTER}+|{DELIM})*
COMENTARIO_S    -\/{VALID_STRING}\/-
COMENTARIO ({COMENTARIO_S}|-\/{VALID_STRING}{COMENTARIO_S}{VALID_STRING}\/-)+
CTE_CADENA  \"([^\"\\\\]|\\\\.)*\"
CTE_INT     {DIGITO}+
CTE_REAL    ({DIGITO}*\.{DIGITO}+)|({DIGITO}+\.{DIGITO}*)
WRITE       [Ww][rR][Ii][Tt][Ee]
READ        [Rr][Ee][Aa][Dd]
MOD         [Mm][Oo][Dd]
DIV         [Dd][Ii][Vv]

%%

":"         {return DECLARACION;}
";"         { return P_COMA;}
","         { return COMA;}
":="		{ return ASIG;}
"=="        { return IGUAL;}
"!="        { return DISTINTO;}
">"         { return MAYOR;}
"<"         { return MENOR;}
">="        { return MAYOR_IGUAL;}
"<="        { return MENOR_IGUAL;}
"NOT"       { return NOT;}
"AND"       { return AND;}
"OR"        { return OR;}
"+"			{ return OP_SUMA;}
"-"         { return OP_RESTA};
"*"         { return OP_MULT;}
{DIV}       {return OP_DIV;}
{MOD}       {return OP_MOD;}
"("			{ return P_A;}
")"			{ return P_C;}
"["         { return C_A;}
"]"         { return C_C;}
{WRITE}  { return ESCRIBIR;}
{READ}  { return ESCANEAR;}
"concatenar" { return CONCATENAR;}
"DECVAR"    {return DECVAR;}
"ENDDEC"    {return ENDDEC;}
"STRING"    {return STRING;}
"INTEGER"   {return INTEGER;}
"FLOAT"     {return FLOAT;}
"CHAR"      {return CHAR;}
"BEGIN"     {return BEGIN;}
"END"       {return END;}
"IF"        {return IF;}
"ELSE"      {return ELSE;}
"WHILE"     {return WHILE;}
"IN"        {return IN;}
"DO"        {return DO;}
"ENDWHILE"  {return ENDWHILE;}

{ID}		{return ID;}
{CTE_REAL}  {yylval = atof(yytext); return CTE_REAL;}
{CTE_INT}	{ yylval = atoi( yytext ); return CTE_INT;}
{CTE_CADENA}    {return CTE_CADENA;}
{COMENTARIO}

"\n"      		
"\t"
%%