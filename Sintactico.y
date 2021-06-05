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
t_nodoa *p_cond_mul, *p_func, *p_sent, *p_sel, *p_ce, *p_c, *p_blo;
t_nodoa *p_prog, *p_tdato, *p_l_var, *p_dec, *p_blo_dec, *p_ini;
t_nodoa *p_ini_pri, *p_l_exp, *p_oper, *p_aux2, *p_cuerpo;
t_info *info;
FILE *pf;
t_pila pila_blo;
t_dato_pila dato;

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

%type<intVal> condicion condicion_mul
%type<strVal> expresion

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

        info->valor = "PROG";
        info->indice++;
        p_aux = crear_hoja(info, pf);

        info->valor = "INICIO";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(NULL, p_aux, p_prog, pf);
        crear_nodo(p_blo_dec, p_oper, p_aux, pf);
        p_ini = p_oper;

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
        info->valor = "BLOQUE\nDECLARACIONES";
        info->indice++;
        p_blo_dec = crear_hoja(info, pf);
}

| bloque_declaraciones declaraciones 
{
        printf("bloque_declaraciones ---> bloque_declaraciones declaraciones\n");
        // info->valor = "BLOQUE\nDECLARACIONES";
        // info->indice++;
        // p_aux = crear_hoja(info, pf);

        // crear_nodo(p_blo_dec, p_aux, p_dec, pf);
        // p_blo_dec = p_aux;
}
;
declaraciones: lista_de_variables DECLARACION tipodato P_COMA 
{
        printf("declaraciones ---> lista_de_variables DECLARACION tipodato P_COMA\n");

        // info->valor = ":";
        // info->indice++;
        // p_oper = crear_hoja(info, pf);

        // crear_nodo(p_l_var, p_oper, p_tdato, pf);
        // p_dec = p_oper;
}                 
;

lista_de_variables: ID  
{
        printf("lista_de_variables ---> ID, %s\n",$1);

//         info->valor = $1;
//         info->indice++;
//         p_l_var = crear_hoja(info, pf);
}

| lista_de_variables COMA ID  
{
        printf("lista_de_variables ---> lista_de_variables COMA ID, %s\n", $3);

        // info->valor = "CUERPO";
        // info->indice++;
        // p_oper = crear_hoja(info, pf);

        // info->valor = $3;
        // info->indice++;
        // crear_nodo(p_l_var, p_oper, crear_hoja(info, pf), pf);
        // p_l_var = p_oper;
}
;

tipodato: STRING
{
        // info->valor = "STRING";
        // info->indice++;
        // p_tdato = crear_hoja(info, pf);
}

|CHAR
{
        // info->valor = "CHAR";
        // info->indice++;
        // p_tdato = crear_hoja(info, pf);
}
       
|INTEGER     
{
        // info->valor = "INTEGER";
        // info->indice++;
        // p_tdato = crear_hoja(info, pf);
}
  
|FLOAT
{
        // info->valor = "FLOAT";
        // info->indice++;
        // p_tdato = crear_hoja(info, pf);
}

;

programa: bloque
{
        printf("programa ---> bloque \n");
        p_prog = p_blo;
}
;
bloque: sentencia 
{
        printf("bloque ---> sentencia \n");
        p_blo = p_sent;

        dato = p_blo;
        apilar(&pila_blo, &dato);
}

|bloque sentencia 
{
        printf("bloque ---> bloque sentencia\n");
        info->valor = "BLOQUE";
        info->indice++;
        p_aux = crear_hoja(info, pf);

        desapilar(&pila_blo, &dato);

        crear_nodo(dato, p_aux, p_sent, pf);
        p_blo = p_aux;
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

        crear_nodo(NULL, p_oper, p_f_mod, pf);
        p_func = p_oper;
}

|ESCRIBIR CTE_CADENA P_COMA 
{
        printf("funcion ---> ESCRIBIR CTE_CADENA P_COMA\n");

        info->valor = "WRITE";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = obtenerStringHoja($2);
        info->indice++;
        crear_nodo(NULL, p_oper, crear_hoja(info, pf), pf);
        p_func = p_oper;
}

|ESCANEAR ID P_COMA 
{
        printf("funcion ---> ESCANEAR P_A ID P_C P_COMA\n");

        info->valor = "READ";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = $2;
        info->indice++;
        crear_nodo(NULL, p_oper, crear_hoja(info, pf), pf);
        p_func = p_oper;
}
;
seleccion: IF P_A condicion_mul P_C START bloque END 
{
        printf("seleccion ---> IF P_A condicion_mul P_C START bloque END\n");

        info->valor = "IF";
        info->indice++;
        p_aux = crear_hoja(info, pf);

        crear_nodo(p_cond_mul, p_aux, p_blo, pf);
        p_sel = p_aux;
}
          
|IF P_A condicion_mul P_C START bloque
{
        p_aux2 = p_blo;
}
END ELSE START bloque END 
{
        printf("seleccion ---> IF P_A condicion_mul P_C START bloque END ELSE START bloque END\n");
        
        info->valor = "CUERPO";
        info->indice++;
        p_cuerpo = crear_hoja(info, pf);
        
        info->valor = "IF";
        info->indice++;
        p_aux = crear_hoja(info, pf);

        crear_nodo(p_aux2, p_cuerpo, p_blo, pf);

        crear_nodo(p_cond_mul, p_aux, p_cuerpo, pf);
        p_sel = p_aux;
}
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

        crear_nodo(p_aux, p_oper, p_cond, pf);
        p_cond_mul = p_oper;
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

        crear_nodo(p_aux, p_oper, p_cond, pf);
        p_cond_mul = p_oper;
}

| NOT condicion 
{
        printf("condicion_mul ---> NOT condicion \n");

        info->valor = "NOT";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(NULL, p_oper, p_cond, pf);
        p_cond_mul = p_oper;
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

        crear_nodo(p_aux, p_oper, p_exp, pf);
        p_cond = p_oper;
}
          
|expresion 
{
        // info->valor = $1;
        // info->indice++;
        p_aux = p_exp;
}
MENOR expresion 
{
        printf("condicion ---> expresion MENOR expresion \n");

        info->valor = "MENOR";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        // info->valor = $3;
        // info->indice++;
        // p_exp = crear_hoja(info, pf);

        crear_nodo(p_aux, p_oper, p_exp, pf);
        p_cond = p_oper;
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

        crear_nodo(p_aux, p_oper, p_exp, pf);
        p_cond = p_oper;
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

        crear_nodo(p_aux, p_oper, p_exp, pf);
        p_cond = p_oper;
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

        crear_nodo(p_aux, p_oper, p_exp, pf);
        p_cond = p_oper;
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

        crear_nodo(p_aux, p_oper, p_exp, pf);
        p_cond = p_oper;
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

        crear_nodo(p_aux, p_oper, p_exp, pf);
        p_asig = p_oper;
}

| ID ASIG CTE_CADENA P_COMA 
{

        printf("asignacion ---> ID ASIG CTE_CADENA P_COMA \n");
        info->valor = $1;
        info->indice++;
        p_aux = crear_hoja(info, pf);
        
        info->valor = "ASIG";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = obtenerStringHoja($3);
        info->indice++; 
        crear_nodo(p_aux, p_oper, crear_hoja(info, pf), pf);
        p_asig = p_oper;
}
;

expresion:      expresion OP_SUMA termino  
{
        printf("expresion ---> expresion OP_SUMA termino \n");
        info->valor = "SUMA";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_exp, p_oper, p_term, pf);
        p_exp = p_oper;
}

|expresion OP_RESTA termino 
{
        printf("expresion ---> expresion OP_RESTA termino \n");
        info->valor = "RESTA";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_exp, p_oper, p_term, pf);
        p_exp = p_oper;
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

        crear_nodo(p_term, p_oper, p_f, pf);
        p_term = p_oper;
}
                
|termino OP_DIV factor 
{
        printf("termino ---> termino OP_DIV factor \n");
        info->valor = "DIV";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_term, p_oper, p_f, pf);
        p_term = p_oper;
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

        crear_nodo(p_f, p_oper, p_f_mod, pf);
        p_f = p_oper;
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
        itoa($1, info->valor, 10);
        info->indice++;
        p_f_mod = crear_hoja(info, pf); 
}

|CTE_REAL 
{
        printf(" factor_mod --> CTE_REAL \n");
        $<realVal>$ = $1;
        info->valor = (char*)malloc(sizeof(char) * 20);
        info->indice++;

	sprintf(info->valor,"%.10f", $1);

        p_f_mod = crear_hoja(info, pf); 
}

|P_A expresion P_C 
{
        printf("factor_mod --> P_A expresion P_C \n");
        // p_f_mod = p_exp;
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

        crear_nodo(p_l_exp, p_oper, p_exp, pf);
}
;

%%


int main(int argc,char *argv[])
{
  if ((yyin = fopen(argv[1], "rt")) == NULL || (pf = fopen("arbol.txt", "wt")) == NULL)
  {
	  printf("\nNo se puede abrir el archivo!");
  }
  else
  {
        crear_lista_ts(&tablaSimbolos);
        crear_pila(&pila_blo);
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


int yyerror(void)
{
    printf("Syntax Error\n");
    fprintf(stderr,"error: in line %d\n", yylineno);
    system ("Pause");
    exit (1);
}

