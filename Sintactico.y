%{
#include <stdio.h>
#include <stdlib.h>
#include "string.h"
#include <conio.h>
#include "y.tab.h"
int yylval;
int yystopparser=0;
FILE  *yyin;
char *yyltext;
char *yytext;

%}
%type <ival> ID
%token<ival> CTE_INT

%token CTE_INT CTE_CADENA
%token P_COMA DECLARACION COMA C_A C_C IGUAL MAYOR MENOR MENOR_IGUAL MAYOR_IGUAL
%token ID
%token OP_SUMA ASIG P_A P_C 
%token ESCRIBIR ESCANEAR CONCATENAR 
%token DECVAR ENDDEC
%token CHAR_ARRAY
%token CHAR INTEGER 
%token IF WHILE BEGIN END
%token OP_MULT OP_DIV OP_SUMA OP_RESTA

%left OP_MULT OP_DIV OP_SUMA OP_RESTA

%type<ival> expresion
%type<ival> termino
%type<ival> factor
%type<ival> asignacion

%start inicio
%%

inicio: DECVAR declaraciones ENDDEC programa
        | DECVAR ENDDEC programa
        | programa
;

declaraciones: ID DECLARACION tipodato P_COMA           
;

tipodato: CHAR_ARRAY
          |CHAR
          |INTEGER
;

programa: bloque
;
bloque: sentencia
        |bloque sentencia
;
sentencia: ciclo
          |asignacion
          |seleccion
          |funcion
;
funcion:  ESCRIBIR P_A CTE_CADENA P_C P_COMA {printf(CTE_CADENA);}
          |ESCANEAR P_A ID P_C P_COMA {scanf(ID);}
          |CONCATENAR P_A ID COMA CTE_CADENA P_COMA {strcat(ID,CTE_CADENA);}
;
seleccion: IF P_A condicion P_C BEGIN bloque END 
          |IF P_A condicion P_C BEGIN bloque END ELSE BEGIN bloque END
;
condicion: expresion MAYOR expresion {$$=$1>$3;}
          |expresion MENOR expresion {$$=$1<$3;}
          |expresion MAYOR_IGUAL expresion {$$=$1>=$3;}
          |expresion MENOR_IGUAL expresion {$$=$1<=$3;}
          |expresion IGUAL expresion {$$=$1==$3;}
;


asignacion: ID ASIG expresion T_COMA {$$=$3;};

expresion:      expresion OP_SUMA termino {$$=$1+$3;}
                |expresion OP_RESTA termino {$$=$1-$3;}
                | termino {$$=$1;}
;
termino:        termino OP_MULT factor {$$= $1*$3;}
                |termino OP_DIV factor {$$=$1/$3;}
                |factor {$$=$1;}
;
factor:         P_A expresion P_C {$$=$2;}
				        |ID{$$=$1;}
                |CTE_INT {$$=$1;}
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
	  yyparse();
  }
     fclose(yyin);
  return 0;
}


int yyerror(void)
{
      printf("Syntax Error\n");
	    system ("Pause");
      exit (1);
}
