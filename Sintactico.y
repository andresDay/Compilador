%{
#include "./include/cabecera.h"
#include <stdio.h>
#include <stdlib.h>
#include "string.h"
#include <conio.h>
int yylval;
int yylex();
int yyerror();
int yystopparser=0;
FILE  *yyin;
char *yyltext;
char *yytext;
extern int yylineno;


%}
%locations
%union {
int intVal;
double realVal;
char *strVal;
}
%token <intVal>CTE_INT <realVal>CTE_REAL <strVal>CTE_CADENA
%token P_COMA DECLARACION COMA C_A C_C AND OR NOT IGUAL DISTINTO MAYOR MENOR MENOR_IGUAL MAYOR_IGUAL
%token ID
%token ASIG P_A P_C 
%token ESCRIBIR ESCANEAR CONCATENAR 
%token DECVAR ENDDEC
%token STRING
%token CHAR INTEGER FLOAT
%token IF ELSE WHILE START END IN DO ENDWHILE
%token OP_MULT OP_DIV OP_SUMA OP_RESTA OP_MOD

%left OP_MULT OP_DIV OP_SUMA OP_RESTA OP_MOD

%start inicio_prima
%%

inicio_prima:  inicio {printf(" inicio' ---> inicio \n");}
;

inicio: DECVAR bloque_declaraciones ENDDEC programa {printf("inicio ---> DECVAR declaraciones ENDDEC programa\n");}
        | programa {printf(" inicio ---> programa \n");}
;
bloque_declaraciones: declaraciones
                        | bloque_declaraciones declaraciones
;
declaraciones: lista_de_variables DECLARACION tipodato P_COMA {printf(" declaraciones ---> lista_de_variables DECLARACION tipodato P_COMA\n");}                 
;

lista_de_variables: ID  {printf(" lista_de_variables ---> ID\n");}
                    | lista_de_variables COMA ID  {printf(" lista_de_variables ---> lista_de_variables COMA ID\n");}
;

tipodato: STRING
          |CHAR
          |INTEGER
;

programa: bloque
;
bloque: sentencia {printf(" bloque ---> sentencia \n");}
        |bloque sentencia {printf(" bloque ---> bloque sentencia\n");}
;
sentencia: ciclo {printf(" sentencia ---> ciclo \n");}      
          |ciclo_especial {printf(" sentencia ---> ciclo_especial \n");}     
          |asignacion {printf(" sentencia ---> asignacion \n");}
          |seleccion {printf("R15 - sentencia ---> seleccion \n");}
          |funcion {printf("R16 - sentencia ---> funcion \n");}
;
funcion:  ESCRIBIR P_A CTE_CADENA P_C P_COMA {printf("R17 - sentencia ---> funcion \n");}
          |ESCANEAR P_A ID P_C P_COMA {printf("R18 - funcion ---> ESCRIBIR P_A CTE_CADENA P_C P_COMA \n");}
          |CONCATENAR P_A ID COMA CTE_CADENA P_C P_COMA {printf("R19 - funcion ---> ESCANEAR P_A ID P_C P_COMA \n");}
;
seleccion: IF P_A condicion_mul P_C START bloque END {printf("R21 - seleccion ---> IF P_A condicion_mul P_C START bloque END \n");}
          |IF P_A condicion_mul P_C START bloque END ELSE START bloque END {printf("R22 - seleccion ---> IF P_A condicion_mul P_C START bloque END ELSE START bloque END \n");}
;

condicion_mul: condicion AND condicion {printf("R23 - condicion_mul ---> condicion AND condicion \n");}
               | condicion OR condicion {printf("R24 - condicion_mul ---> condicion OR condicion \n");}
               | NOT condicion {printf("R25 - condicion_mul ---> NOT condicion \n");}
               | condicion {printf("R26 - condicion_mul ---> condicion \n");}
;

condicion: expresion MAYOR expresion {printf("R27 - condicion ---> expresion MAYOR expresion \n");}
          |expresion MENOR expresion {printf("R28 - condicion ---> expresion MENOR expresion \n");}
          |expresion MAYOR_IGUAL expresion {printf("R29 - condicion ---> expresion MAYOR_IGUAL expresion \n");}
          |expresion MENOR_IGUAL expresion {printf("R30 - condicion ---> expresion MENOR_IGUAL expresion \n");}
          |expresion IGUAL expresion {printf("R31 - condicion ---> expresion IGUAL expresion \n");}
          |expresion DISTINTO expresion {printf(" - condicion_mul ---> condicion \n");} 
;

asignacion: ID ASIG expresion P_COMA {printf("R33 - asignacion ---> ID ASIG expresion P_COMA \n");}
                | ID ASIG CTE_CADENA P_COMA {printf("R33 - asignacion ---> ID ASIG CTE_CADENA P_COMA \n");}
;

expresion:      expresion OP_SUMA termino  {printf("R34 - expresion ---> expresion OP_SUMA termino \n");}
                |expresion OP_RESTA termino {printf("R35 - expresion ---> expresion OP_RESTA termino \n");}
                | termino {printf("R36 - expresion ---> termino \n");}
;
termino:        termino OP_MULT factor {printf("R37 - termino ---> termino OP_MULT factor \n");}
                |termino OP_DIV factor {printf("R38 - termino ---> termino OP_DIV factor \n");}
                |termino OP_MOD factor {printf("R39 - termino ---> termino OP_MOD factor \n");}
                |factor {printf("R40 - termino ---> factor \n");}
;
factor:         P_A expresion P_C {printf("R41 - factor ---> P_A expresion P_C \n");}
		|ID {printf("R42 - factor ---> ID \n");}
                |CTE_INT {printf("R43 - factor ---> CTE_INT \n");}
                |CTE_REAL {printf("R44 - factor ---> CTE_REAL \n");}
;

ciclo: WHILE P_A condicion_mul P_C START bloque END {printf("R45 - ciclo_normal ---> P_A condicion_mul P_C START bloque END \n");}
         
;
ciclo_especial: WHILE ID IN C_A lista_de_expresiones C_C DO bloque ENDWHILE {printf("R46 - ciclo_especial ---> ID IN C_A lista_de_expresiones C_C DO bloque ENDWHILE \n");}
;
lista_de_expresiones: expresion {printf("R47 - lista_de_expresiones ---> factor \n");}
                      | lista_de_expresiones COMA expresion {printf("R48 - lista_de_expresiones ---> lista_de_expresiones COMA factor \n");}
;

%%


int main(int argc,char *argv[])
{
  if ((yyin = fopen(argv[1], "rt")) == NULL)
  {
	  printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
  }
  else
  {
        crear_lista_ts(&tablaSimbolos);

	yyparse();
  }
     fclose(yyin);
     guardar_lista_en_archivo_ts(&tablaSimbolos, "tablaSimbolos.txt");

  return 0;
}


int yyerror(const char *str)
{
    printf("Syntax Error\n");
    fprintf(stderr,"error: %s in line %d\n", str, yylineno);
    system ("Pause");
    exit (1);
}

