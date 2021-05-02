%{
#include "./include/cabecera.h"
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
%token ESCRIBIR ESCANEAR 
%token DECVAR ENDDEC
%token STRING
%token CHAR INTEGER FLOAT
%token IF ELSE WHILE START END IN DO ENDWHILE
%token OP_MULT OP_DIV OP_SUMA OP_RESTA OP_MOD

%left OP_MULT OP_DIV OP_SUMA OP_RESTA OP_MOD

%start inicio_prima
%%

inicio_prima:  inicio {printf("inicio' ---> inicio \n");}
;

inicio: DECVAR bloque_declaraciones ENDDEC programa {printf("inicio ---> DECVAR bloque_declaraciones ENDDEC programa\n");}
        | programa {printf("inicio ---> programa \n");}
;
bloque_declaraciones: declaraciones {printf("bloque_declaraciones ---> declaraciones\n");}
                        | bloque_declaraciones declaraciones {printf("bloque_declaraciones ---> bloque_declaraciones declaraciones\n");}
;
declaraciones: lista_de_variables DECLARACION tipodato P_COMA {printf("declaraciones ---> lista_de_variables DECLARACION tipodato P_COMA\n");}                 
;

lista_de_variables: ID  {printf("lista_de_variables ---> ID\n");}
                    | lista_de_variables COMA ID  {printf("lista_de_variables ---> lista_de_variables COMA ID\n");}
;

tipodato: STRING
          |CHAR
          |INTEGER
          |FLOAT
;

programa: bloque
;
bloque: sentencia {printf("bloque ---> sentencia \n");}
        |bloque sentencia {printf("bloque ---> bloque sentencia\n");}
;
sentencia: ciclo {printf("sentencia ---> ciclo \n");}      
          |ciclo_especial {printf("sentencia ---> ciclo_especial \n");}     
          |asignacion {printf("sentencia ---> asignacion \n");}
          |seleccion {printf("sentencia ---> seleccion \n");}
          |funcion {printf("sentencia ---> funcion \n");}
;

funcion:  ESCRIBIR factor_mod P_COMA {printf("funcion ---> ESCRIBIR P_A factor_mod P_C P_COMA\n");}
          |ESCRIBIR CTE_CADENA P_COMA {printf("funcion ---> ESCRIBIR P_A CTE_CADENA P_C P_COMA\n");}
          |ESCANEAR ID P_COMA {printf("funcion ---> ESCANEAR P_A ID P_C P_COMA\n");}
;
seleccion: IF P_A condicion_mul P_C START bloque END {printf("seleccion ---> IF P_A condicion_mul P_C START bloque END\n");}
          |IF P_A condicion_mul P_C START bloque END ELSE START bloque END {printf("seleccion ---> IF P_A condicion_mul P_C START bloque END ELSE START bloque END\n");}
;

condicion_mul: condicion AND condicion {printf("condicion_mul ---> condicion AND condicion \n");}
               | condicion OR condicion {printf("condicion_mul ---> condicion OR condicion \n");}
               | NOT condicion {printf("condicion_mul ---> NOT condicion \n");}
               | condicion {printf("condicion_mul ---> condicion \n");}
;

condicion: expresion MAYOR expresion {printf("condicion ---> expresion MAYOR expresion \n");}
          |expresion MENOR expresion {printf("condicion ---> expresion MENOR expresion \n");}
          |expresion MAYOR_IGUAL expresion {printf("condicion ---> expresion MAYOR_IGUAL expresion \n");}
          |expresion MENOR_IGUAL expresion {printf("condicion ---> expresion MENOR_IGUAL expresion \n");}
          |expresion IGUAL expresion {printf("condicion ---> expresion IGUAL expresion \n");}
          |expresion DISTINTO expresion {printf("expresion DISTINTO expresion\n");} 
;

asignacion: ID ASIG expresion P_COMA {printf("asignacion ---> ID ASIG expresion P_COMA \n");}
                | ID ASIG CTE_CADENA P_COMA {printf("asignacion ---> ID ASIG CTE_CADENA P_COMA \n");}
;

expresion:      expresion OP_SUMA termino  {printf("expresion ---> expresion OP_SUMA termino \n");}
                |expresion OP_RESTA termino {printf("expresion ---> expresion OP_RESTA termino \n");}
                | termino {printf("expresion ---> termino \n");}
;
termino:        termino OP_MULT factor {printf("termino ---> termino OP_MULT factor \n");}
                |termino OP_DIV factor {printf("termino ---> termino OP_DIV factor \n");}                
                |factor {printf("termino ---> factor \n");}
;
factor: factor OP_MOD factor_mod {printf("factor --> factor OP_MOD factor_mod \n");}
        | factor_mod {printf(" factor --> factor_mod \n");}
; 
factor_mod: ID  {printf(" factor_mod --> ID \n");}         
        |CTE_INT {printf(" factor_mod --> CTE_INT \n");}
        |CTE_REAL {printf(" factor_mod --> CTE_REAL \n");}
        |P_A expresion P_C {printf("factor_mod --> P_A expresion P_C \n");}
;

ciclo: WHILE P_A condicion_mul P_C START bloque END {printf("ciclo ---> WHILE P_A condicion_mul P_C START bloque END \n");}
         
;
ciclo_especial: WHILE ID IN C_A lista_de_expresiones C_C DO bloque ENDWHILE {printf("ciclo_especial ---> WHILE ID IN C_A lista_de_expresiones C_C DO bloque ENDWHILE\n");}
;
lista_de_expresiones: expresion {printf("lista_de_expresiones ---> expresion\n");}
                      | lista_de_expresiones COMA expresion {printf("lista_de_expresiones ---> lista_de_expresiones COMA expresion\n");}
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
     guardar_lista_en_archivo_ts(&tablaSimbolos, "ts.txt");

  return 0;
}


int yyerror(const char *str)
{
    printf("Syntax Error\n");
    fprintf(stderr,"error: %s in line %d\n", str, yylineno);
    system ("Pause");
    exit (1);
}

