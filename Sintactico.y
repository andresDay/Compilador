%{
#include "./include/cabecera.h"
int yylex();
int yyerror();
int yystopparser=0;
FILE  *yyin;
char *yyltext;
char *yytext;
extern int yylineno;

//DECLARACION DE VARIABLES GLOBALES
t_nodoa *p_f_mod, *p_exp, *p_f, *p_term, *p_asig, *p_aux, *p_cond;
t_nodoa *p_cond_mul, *p_func, *p_sent, *p_sel, *p_ce, *p_c, p_blo;
t_nodoa *p_prog, *p_tdato, *p_l_var, *p_dec, *p_blo_dec, *p_ini;
t_nodoa *p_ini_pri, *p_l_exp, *p_oper;
t_info *info;
FILE *pf;

%}
%locations

%union {
int intVal;
double realVal;
char *strVal;
char *comp
}

%token <intVal>CTE_INT <realVal>CTE_REAL <strVal>CTE_CADENA
%token P_COMA DECLARACION COMA C_A C_C AND OR NOT <comp>IGUAL <comp>DISTINTO <comp>MAYOR <comp>MENOR <comp>MENOR_IGUAL <comp>MAYOR_IGUAL
%token <strVal>ID
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

inicio_prima:  inicio {
        printf("inicio' ---> inicio \n");

        p_ini_pri = p_ini;
}
;

inicio: DECVAR bloque_declaraciones ENDDEC programa 
{
        printf("inicio ---> DECVAR bloque_declaraciones ENDDEC programa\n");

        info->valor = "INICIO";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        p_ini = crear_nodo(NULL, p_oper, crear_nodo(NULL, p_prog, p_blo_dec, pf), pf);
}

| programa 
{
        printf("inicio ---> programa \n");
        p_ini = p_prog;
}
;
bloque_declaraciones: declaraciones 
{
        printf("bloque_declaraciones ---> declaraciones\n");

        p_blo_dec = p_dec;
}

| bloque_declaraciones declaraciones 
{
        printf("bloque_declaraciones ---> bloque_declaraciones declaraciones\n");

        p_blo_dec = crear_nodo(NULL, p_blo_dec, p_dec, pf);
}
;
declaraciones: lista_de_variables DECLARACION tipodato P_COMA 
{
        printf("declaraciones ---> lista_de_variables DECLARACION tipodato P_COMA\n");

        info->valor = "DECLARACION";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        p_dec = crear_nodo(NULL, p_oper, p_l_var, pf);
}                 
;

lista_de_variables: ID  
{
        printf("lista_de_variables ---> ID\n");

        info->valor = $1;
        info->indice++;
        p_l_var = crear_hoja(info, pf);
}

| lista_de_variables COMA ID  
{
        printf("lista_de_variables ---> lista_de_variables COMA ID\n");

        info->valor = "COMA";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = $3;
        info->indice++;
        p_l_var = crear_nodo(p_l_var, p_oper, crear_hoja(info, pf));
}
;

tipodato: STRING
|CHAR       
|INTEGER       
|FLOAT
;

programa: bloque
{
        p_prog = p_blo;
}
;
bloque: sentencia 
{
        printf("bloque ---> sentencia \n");
        p_blo = p_sent;
}

|bloque 
{
        p_aux = p_blo;
}
sentencia 
{
        printf("bloque ---> bloque sentencia\n");

        p_blo = crear_nodo(p_sent, p_aux, NULL, pf);
}
;
sentencia: ciclo 
{
        printf("sentencia ---> ciclo \n");
        p_sent = p_c;
}      
 
|ciclo_especial 
{
        printf("sentencia ---> ciclo_especial \n");
        p_sent = p_ce;
}

|asignacion 
{
        printf("sentencia ---> asignacion \n");
        p_sent = p_asig;
}

|seleccion 
{
        printf("sentencia ---> seleccion \n");
        p_sent = p_sel;
}

|funcion 
{
        printf("sentencia ---> funcion \n");
        p_sent = p_func;
}
;

funcion:  ESCRIBIR factor_mod P_COMA 
{
        printf("funcion ---> ESCRIBIR P_A factor_mod P_C P_COMA\n");

        info->valor = "WRITE";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        p_func = crear_nodo(p_f_mod, p_oper, NULL, pf);
}

|ESCRIBIR CTE_CADENA P_COMA 
{
        printf("funcion ---> ESCRIBIR P_A CTE_CADENA P_C P_COMA\n");

        info->valor = "WRITE";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = $2;
        info->indice++;
        p_func = crear_nodo(crear_hoja(info, pf), p_oper, NULL, pf);
}

|ESCANEAR ID P_COMA 
{
        printf("funcion ---> ESCANEAR P_A ID P_C P_COMA\n");

        info->valor = "READ";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = $2;
        info->indice++;
        p_func = crear_nodo(crear_hoja(info, pf), p_oper, NULL, pf);
}
;
seleccion: IF P_A condicion_mul P_C START bloque END {printf("seleccion ---> IF P_A condicion_mul P_C START bloque END\n");}
          |IF P_A condicion_mul P_C START bloque END ELSE START bloque END {printf("seleccion ---> IF P_A condicion_mul P_C START bloque END ELSE START bloque END\n");}
;

condicion_mul: condicion 
{
        p_aux = p_cond;
}
AND condicion 
{
        printf("condicion_mul ---> condicion AND condicion \n");

        info->valor = "AND";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        p_cond_mul = crear_nodo(p_aux, p_oper, p_cond, pf);
}

| condicion 
{
        p_aux = p_cond;
}
OR condicion 
{
        printf("condicion_mul ---> condicion OR condicion \n");

        info->valor = "OR";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        p_cond_mul = crear_nodo(p_aux, p_oper, p_cond, pf);
}

| NOT condicion 
{
        printf("condicion_mul ---> NOT condicion \n");

        info->valor = "NOT";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        p_cond_mul = crear_nodo(NULL, p_oper, p_cond, pf);
}

| condicion 
{
        printf("condicion_mul ---> condicion \n");
        p_cond_mul = p_cond;
}
;

condicion: expresion 
{
        info->valor = $1;
        info->indice++;
        p_aux = crear_hoja(info, pf);
}
MAYOR expresion 
{
        printf("condicion ---> expresion MAYOR expresion \n");

        info->valor = "MAYOR";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = $3;
        info->indice++;
        p_exp = crear_hoja(info, pf);

        p_cond = crear_hoja(p_aux, p_oper, p_exp, pf);
}
          
|expresion 
{
        info->valor = $1;
        info->indice++;
        p_aux = crear_hoja(info, pf);
}
MENOR expresion 
{
        printf("condicion ---> expresion MENOR expresion \n");

        info->valor = "MENOR";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = $3;
        info->indice++;
        p_exp = crear_hoja(info, pf);

        p_cond = crear_hoja(p_aux, p_oper, p_exp, pf);
}

|expresion 
{
        info->valor = $1;
        info->indice++;
        p_aux = crear_hoja(info, pf);
}
MAYOR_IGUAL expresion 
{
        printf("condicion ---> expresion MAYOR_IGUAL expresion \n");

        info->valor = "MAYOR O IGUAL";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = $3;
        info->indice++;
        p_exp = crear_hoja(info, pf);

        p_cond = crear_hoja(p_aux, p_oper, p_exp, pf);
}
          
|expresion 
{
        info->valor = $1;
        info->indice++;
        p_aux = crear_hoja(info, pf);
}
MENOR_IGUAL expresion 
{
        printf("condicion ---> expresion MENOR_IGUAL expresion \n");

        info->valor = "MENOR O IGUAL";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = $3;
        info->indice++;
        p_exp = crear_hoja(info, pf);

        p_cond = crear_hoja(p_aux, p_oper, p_exp, pf);
}

|expresion
{
        info->valor = $1;
        info->indice++;
        p_aux = crear_hoja(info, pf);
}  
IGUAL expresion 
{
        printf("condicion ---> expresion IGUAL expresion \n");

        info->valor = "IGUAL";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = $3;
        info->indice++;
        p_exp = crear_hoja(info, pf);

        p_cond = crear_hoja(p_aux, p_oper, p_exp, pf);
}

|expresion 
{
        info->valor = $1;
        info->indice++;
        p_aux = crear_hoja(info, pf);
} 
DISTINTO expresion 
{
        printf("expresion DISTINTO expresion\n");

        info->valor = "DISTINTO";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = $3;
        info->indice++;
        p_exp = crear_hoja(info, pf);

        p_cond = crear_hoja(p_aux, p_oper, p_exp, pf);
} 
;

asignacion: ID ASIG expresion P_COMA 
{
        printf("asignacion ---> ID ASIG expresion P_COMA \n");
        info->valor = "ASIG";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = $1;
        info->indice++;
        p_aux = crear_hoja(info, pf);

        p_asig = crear_nodo(p_aux, p_oper, p_exp, pf);
}

| ID ASIG CTE_CADENA P_COMA 
{
        printf("asignacion ---> ID ASIG CTE_CADENA P_COMA \n");
        info->valor = "ASIG";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = $1;
        info->indice++;
        p_aux = crear_hoja(info, pf);

        info->valor = $3;
        info->indice++; 
        p_asig = crear_nodo(p_aux, p_oper, crear_hoja(info, pf), pf);
}
;

expresion:      expresion OP_SUMA termino  
{
        printf("expresion ---> expresion OP_SUMA termino \n");
        info->valor = "SUMA";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        p_exp = crear_nodo(p_exp, p_oper, p_term, pf);
}

|expresion OP_RESTA termino 
{
        printf("expresion ---> expresion OP_RESTA termino \n");
        info->valor = "RESTA";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        p_exp = crear_nodo(p_exp, p_oper, p_term, pf);
}

|termino 
{
        printf("expresion ---> termino \n");
        p_exp = p_term;
}
;

termino:        termino OP_MULT factor 
{
        printf("termino ---> termino OP_MULT factor \n");
        info->valor = "MULT";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        p_term = crear_nodo(p_term, p_oper, p_f, pf);
}
                
|termino OP_DIV factor 
{
        printf("termino ---> termino OP_DIV factor \n");
        info->valor = "DIV";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        p_term = crear_nodo(p_term, p_oper, p_f, pf);
}                

|factor 
{
        printf("termino ---> factor \n");
        p_term = p_f;
}
;
factor: factor OP_MOD factor_mod 
{
        printf("factor --> factor OP_MOD factor_mod \n");
        info->valor = "MOD";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        p_f = crear_nodo(p_f, p_oper, p_f_mod, pf);
}
        
| factor_mod 
{
        printf(" factor --> factor_mod \n");
        p_f = p_f_mod;
}
; 
factor_mod: ID  
{
        printf(" factor_mod --> ID \n");
        $<strVal>$ = $1;
        info->valor = $1;
        info->indice++;
        p_f_mod = crear_hoja(info, pf); 
}

|CTE_INT 
{
        printf(" factor_mod --> CTE_INT \n");
        $<intVal>$ = $1;
        info->valor = $1;
        info->indice++;
        p_f_mod = crear_hoja(info, pf); 
}

|CTE_REAL 
{
        printf(" factor_mod --> CTE_REAL \n");
        $<realVal>$ = $1;
        info->valor = $1;
        info->indice++;
        p_f_mod = crear_hoja(info, pf); 
}

|P_A expresion P_C 
{
        printf("factor_mod --> P_A expresion P_C \n");
        p_f_mod = p_exp;
}
;

ciclo: WHILE P_A condicion_mul P_C START bloque END {printf("ciclo ---> WHILE P_A condicion_mul P_C START bloque END \n");}
         
;
ciclo_especial: WHILE ID IN C_A lista_de_expresiones C_C DO bloque ENDWHILE {printf("ciclo_especial ---> WHILE ID IN C_A lista_de_expresiones C_C DO bloque ENDWHILE\n");}
;
lista_de_expresiones: expresion 
{
        printf("lista_de_expresiones ---> expresion\n");
        p_l_exp = p_exp;
}

| lista_de_expresiones COMA expresion 
{
        printf("lista_de_expresiones ---> lista_de_expresiones COMA expresion\n");

        info->valor = "COMA";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        p_l_exp = crear_nodo(p_l_exp, p_oper, p_exp, pf);
}
;

%%


int main(int argc,char *argv[])
{
  if ((yyin = fopen(argv[1], "rt")) == NULL || pf = fopen("arbol.txt", "wt") == NULL)
  {
	  printf("\nNo se puede abrir el archivo!");
  }
  else
  {
        crear_lista_ts(&tablaSimbolos);
        info=(t_info*)malloc(sizeof(t_info));
        indice=0;
        info->indice=-1;
        fprintf(pf,"digraph G {\n");

	yyparse();

        fprintf(pf,"}");
        fclose(pf);
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

