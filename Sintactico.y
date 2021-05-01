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
// %type <ival> ID
// %token<ival> CTE_INT

%token CTE_INT CTE_REAL CTE_CADENA
%token P_COMA DECLARACION COMA C_A C_C AND OR NOT IGUAL DISTINTO MAYOR MENOR MENOR_IGUAL MAYOR_IGUAL
%token ID
%token ASIG P_A P_C 
%token ESCRIBIR ESCANEAR CONCATENAR 
%token DECVAR ENDDEC
%token STRING
%token CHAR INTEGER 
%token IF ELSE WHILE BEGIN END IN DO ENDWHILE
%token OP_MULT OP_DIV OP_SUMA OP_RESTA OP_MOD

%left OP_MULT OP_DIV OP_SUMA OP_RESTA

// %type<ival> expresion
// %type<ival> termino
// %type<ival> factor
// %type<ival> asignacion

%start inicio_prima
%%

inicio_prima: inicio {printf("1 - \n");};

inicio: DECVAR declaraciones ENDDEC programa {printf("2 - \n");}
        | programa {printf("3 - \n");}
;

declaraciones: lista_de_variables DECLARACION tipodato P_COMA {printf("4 - \n");}           
;

lista_de_variables: ID  {printf("5 - \n");}
                    | lista_de_variables COMA ID        {printf("6 - \n");}
;

tipodato: STRING
          |CHAR
          |INTEGER
;

programa: bloque
;
bloque: sentencia
        |bloque sentencia
;
sentencia: ciclo
          |ciclo_especial
          |asignacion
          |seleccion
          |funcion
;
funcion:  ESCRIBIR P_A CTE_CADENA P_C P_COMA {printf(CTE_CADENA);}
          |ESCANEAR P_A ID P_C P_COMA {scanf(ID);}
          |CONCATENAR P_A ID COMA CTE_CADENA P_C P_COMA {strcat(ID,CTE_CADENA);}
;
seleccion: IF P_A condicion_mul P_C BEGIN bloque END 
          |IF P_A condicion_mul P_C BEGIN bloque END ELSE BEGIN bloque END
;

condicion_mul: condicion AND condicion
               | condicion OR condicion
               | NOT condicion
               | condicion
;

condicion: expresion MAYOR expresion
          |expresion MENOR expresion
          |expresion MAYOR_IGUAL expresion
          |expresion MENOR_IGUAL expresion
          |expresion IGUAL expresion
          |expresion DISTINTO expresion
;


asignacion: ID ASIG expresion P_COMA;

expresion:      expresion OP_SUMA termino
                |expresion OP_RESTA termino
                | termino
;
termino:        termino OP_MULT factor
                |termino OP_DIV factor
                |termino OP_MOD factor
                |factor
;
factor:         P_A expresion P_C
		|ID
                |CTE_INT
                |CTE_REAL
;

ciclo: WHILE P_A condicion_mul P_C BEGIN bloque END;

ciclo_especial: WHILE ID IN C_A lista_de_expresiones C_C DO bloque ENDWHILE;

lista_de_expresiones: expresion
                      | lista_de_expresiones COMA expresion
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
