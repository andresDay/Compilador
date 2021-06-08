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
t_nodoa *p_ini_pri, *p_l_exp, *p_oper, *p_aux2, *p_cuerpo, *p_id;
t_info *info;
FILE *pf;
t_pila pila_blo;
t_pila pila_cond;
t_pila pila_expr;
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
        printf("%d - inicio' ---> inicio \n", yylineno);

        p_ini_pri = p_ini;
}
;

inicio: DECVAR bloque_declaraciones ENDDEC programa 
{
        printf("%d - inicio ---> DECVAR bloque_declaraciones ENDDEC programa\n", yylineno);

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
        printf("%d - inicio ---> programa \n", yylineno);

        p_ini = p_prog;
}
;
bloque_declaraciones: declaraciones 
{
        printf("%d - bloque_declaraciones ---> declaraciones\n", yylineno);
        info->valor = "BLOQUE\nDECLARACIONES";
        info->indice++;
        p_blo_dec = crear_hoja(info, pf);
}

| bloque_declaraciones declaraciones 
{
        printf("%d - bloque_declaraciones ---> bloque_declaraciones declaraciones\n", yylineno);
        // info->valor = "BLOQUE\nDECLARACIONES";
        // info->indice++;
        // p_aux = crear_hoja(info, pf);

        // crear_nodo(p_blo_dec, p_aux, p_dec, pf);
        // p_blo_dec = p_aux;
}
;
declaraciones: lista_de_variables DECLARACION tipodato P_COMA 
{
        printf("%d - declaraciones ---> lista_de_variables DECLARACION tipodato P_COMA\n", yylineno);

        // info->valor = ":";
        // info->indice++;
        // p_oper = crear_hoja(info, pf);

        // crear_nodo(p_l_var, p_oper, p_tdato, pf);
        // p_dec = p_oper;
}                 
;

lista_de_variables: ID  
{
        printf("%d - lista_de_variables ---> ID\n", yylineno);

//         info->valor = $1;
//         info->indice++;
//         p_l_var = crear_hoja(info, pf);
}

| lista_de_variables COMA ID  
{
        printf("%d - lista_de_variables ---> lista_de_variables COMA ID\n", yylineno);

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
        printf("%d - programa ---> bloque \n", yylineno);
        p_prog = p_blo;
}
;
bloque: sentencia 
{
        printf("%d - bloque ---> sentencia \n", yylineno);
        p_blo = p_sent;

        dato = p_blo;
        apilar(&pila_blo, &dato);
}

|bloque sentencia 
{
        printf("%d - bloque ---> bloque sentencia\n", yylineno);
        info->valor = "BLOQUE";
        info->indice++;
        p_aux = crear_hoja(info, pf);

        desapilar(&pila_blo, &dato);

        crear_nodo(dato, p_aux, p_sent, pf);

        p_blo = p_aux;

        dato = p_aux;
        apilar(&pila_blo,&dato);
}
;

sentencia: ciclo 
{
        printf("%d - sentencia ---> ciclo \n", yylineno);
        p_sent = p_c;
}      
 
|ciclo_especial 
{
        printf("%d - sentencia ---> ciclo_especial \n", yylineno);
        p_sent = p_ce;
}

|asignacion 
{
        printf("%d - sentencia ---> asignacion \n", yylineno);
        p_sent = p_asig;
}

|seleccion 
{
        printf("%d - sentencia ---> seleccion \n", yylineno);
        p_sent = p_sel;
}

|funcion 
{
        printf("%d - sentencia ---> funcion \n", yylineno);
        p_sent = p_func;
}
;

funcion:  ESCRIBIR factor_mod P_COMA 
{
        printf("%d - funcion ---> ESCRIBIR P_A factor_mod P_C P_COMA\n", yylineno);

        info->valor = "WRITE";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(NULL, p_oper, p_f_mod, pf);
        p_func = p_oper;
}

|ESCRIBIR CTE_CADENA P_COMA 
{
        printf("%d - funcion ---> ESCRIBIR CTE_CADENA P_COMA\n", yylineno);

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
        printf("%d - funcion ---> ESCANEAR P_A ID P_C P_COMA\n", yylineno);

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
        printf("%d - seleccion ---> IF P_A condicion_mul P_C START bloque END\n", yylineno);

        info->valor = "IF";
        info->indice++;
        p_aux = crear_hoja(info, pf);

        desapilar(&pila_cond, &dato);
        desapilar(&pila_blo, &p_blo);

        crear_nodo(dato, p_aux, p_blo, pf);
        p_sel = p_aux;
}
          
|IF P_A condicion_mul P_C START bloque END ELSE START bloque END 
{
        printf("%d - seleccion ---> IF P_A condicion_mul P_C START bloque END ELSE START bloque END\n", yylineno);
        
        info->valor = "CUERPO";
        info->indice++;
        p_cuerpo = crear_hoja(info, pf);
        
        info->valor = "IF";
        info->indice++;
        p_aux = crear_hoja(info, pf);

     
        desapilar(&pila_blo,&dato);        
        p_aux2 = dato;  
        
        desapilar(&pila_blo, &dato);
        desapilar(&pila_cond, &p_cond_mul);

        crear_nodo(p_aux2, p_cuerpo, dato , pf);
        crear_nodo(p_cond_mul, p_aux, p_cuerpo, pf);
        p_sel = p_aux;
}
;

condicion_mul: condicion 
{
        p_aux = p_cond;
        dato = p_aux;
        apilar(&pila_cond,&dato);
        
}
AND condicion 
{
        printf("%d - condicion_mul ---> condicion AND condicion \n", yylineno);

        info->valor = "AND";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        desapilar(&pila_cond,&dato);
        crear_nodo(dato, p_oper, p_cond, pf);
        p_cond_mul = p_oper;
        dato = p_cond_mul;
        apilar(&pila_cond,&dato);
}

| condicion 
{
        p_aux = p_cond;
}
OR condicion 
{
        printf("%d - condicion_mul ---> condicion OR condicion \n", yylineno);

        info->valor = "OR";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_aux, p_oper, p_cond, pf);
        p_cond_mul = p_oper;
        apilar(&pila_cond, &p_cond_mul);
}

| NOT condicion 
{
        printf("%d - condicion_mul ---> NOT condicion \n", yylineno);

        info->valor = "NOT";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(NULL, p_oper, p_cond, pf);
        p_cond_mul = p_oper;
        apilar(&pila_cond, &p_cond_mul);
}

| condicion 
{
        printf("%d - condicion_mul ---> condicion \n", yylineno);
        p_cond_mul = p_cond;
        apilar(&pila_cond, &p_cond_mul);
}
;

condicion: expresion 
{
        p_aux = p_exp;
}
MAYOR expresion 
{
        printf("%d - condicion ---> expresion MAYOR expresion \n", yylineno);

        info->valor = "MAYOR";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_aux, p_oper, p_exp, pf);
        p_cond = p_oper;
}
          
|expresion 
{
        p_aux = p_exp;
}
MENOR expresion 
{
        printf("%d - condicion ---> expresion MENOR expresion \n", yylineno);

        info->valor = "MENOR";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_aux, p_oper, p_exp, pf);
        p_cond = p_oper;
}

|expresion 
{
        p_aux = p_exp;
}
MAYOR_IGUAL expresion 
{
        printf("%d - condicion ---> expresion MAYOR_IGUAL expresion \n", yylineno);

        info->valor = "MAYOR O IGUAL";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_aux, p_oper, p_exp, pf);
        p_cond = p_oper;
}
          
|expresion 
{
        p_aux = p_exp;
}
MENOR_IGUAL expresion 
{
        printf("%d - condicion ---> expresion MENOR_IGUAL expresion \n", yylineno);

        info->valor = "MENOR O IGUAL";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_aux, p_oper, p_exp, pf);
        p_cond = p_oper;
}

|expresion
{
        p_aux = p_exp;
}  
IGUAL expresion 
{
        printf("%d - condicion ---> expresion IGUAL expresion \n", yylineno);

        info->valor = "IGUAL";
        info->indice++;
        p_oper = crear_hoja(info, pf);
        
        crear_nodo(p_aux, p_oper, p_exp, pf);
        p_cond = p_oper;
}

|expresion 
{
    p_aux = p_exp;
} 
DISTINTO expresion 
{
        printf("%d - expresion DISTINTO expresion\n", yylineno);

        info->valor = "DISTINTO";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_aux, p_oper, p_exp, pf);
        p_cond = p_oper;
} 
;

asignacion: ID ASIG expresion P_COMA 
{
        printf("%d - asignacion ---> ID ASIG expresion P_COMA \n", yylineno);
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

        printf("%d - asignacion ---> ID ASIG CTE_CADENA P_COMA \n", yylineno);
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

expresion: expresion OP_SUMA termino  
{
        printf("%d - expresion ---> expresion OP_SUMA termino \n", yylineno);
        info->valor = "SUMA";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_exp, p_oper, p_term, pf);
        p_exp = p_oper;
}

|expresion OP_RESTA termino 
{
        printf("%d - expresion ---> expresion OP_RESTA termino \n", yylineno);
        info->valor = "RESTA";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_exp, p_oper, p_term, pf);
        p_exp = p_oper;
}

|termino 
{
        printf("%d - expresion ---> termino \n", yylineno);
        p_exp = p_term;
}
;

termino:        termino OP_MULT factor 
{
        printf("%d - termino ---> termino OP_MULT factor \n", yylineno);
        info->valor = "MULT";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_term, p_oper, p_f, pf);
        p_term = p_oper;
}
                
|termino OP_DIV factor 
{
        printf("%d - termino ---> termino OP_DIV factor \n", yylineno);
        info->valor = "DIV";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_term, p_oper, p_f, pf);
        p_term = p_oper;
}                

|factor 
{
        printf("%d - termino ---> factor \n", yylineno);
        p_term = p_f;
}
;
factor: factor OP_MOD factor_mod 
{
        printf("%d - factor --> factor OP_MOD factor_mod \n", yylineno);
        info->valor = "MOD";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_f, p_oper, p_f_mod, pf);
        p_f = p_oper;
}
        
| factor_mod 
{
        printf("%d -  factor --> factor_mod \n", yylineno);
        p_f = p_f_mod;
}
; 
factor_mod: ID  
{
        printf("%d -  factor_mod --> ID \n", yylineno);
        $<strVal>$ = $1;
        info->valor = $1;
        info->indice++;
        p_f_mod = crear_hoja(info, pf); 
}

|CTE_INT 
{
        printf("%d -  factor_mod --> CTE_INT \n", yylineno);
        $<intVal>$ = $1;
        itoa($1, info->valor, 10);
        info->indice++;
        p_f_mod = crear_hoja(info, pf); 
}

|CTE_REAL 
{
        printf("%d -  factor_mod --> CTE_REAL \n", yylineno);
        $<realVal>$ = $1;
        info->valor = (char*)malloc(sizeof(char) * 20);
        info->indice++;

	sprintf(info->valor,"%.10f", $1);

        p_f_mod = crear_hoja(info, pf); 
}

|P_A expresion P_C 
{
        printf("%d - factor_mod --> P_A expresion P_C \n", yylineno);
        p_f_mod = p_exp;
}
;

ciclo: WHILE P_A  condicion_mul P_C START bloque END 
{
        info->valor = "WHILE";
        info->indice++;       
        p_aux = crear_hoja(info,pf);

        desapilar(&pila_blo, &dato);
        desapilar(&pila_cond, &p_cond_mul);

        crear_nodo(p_cond_mul,p_aux,dato,pf);
        p_c = p_aux;
        printf("%d - ciclo ---> WHILE P_A condicion_mul P_C START bloque END \n", yylineno);
}
         
;
ciclo_especial: WHILE ID IN C_A lista_de_expresiones C_C DO bloque ENDWHILE 
{
        info->valor = $2;
        info->indice++;
        p_id = crear_hoja(info, pf);

        info->valor = "IN";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_id, p_oper, p_l_exp, pf);

        info->valor = "WHILE";
        info->indice++;
        p_aux = crear_hoja(info, pf);

        desapilar(&pila_blo, &p_blo);
        crear_nodo(p_oper, p_aux, p_blo, pf);
        p_oper = p_aux;

        printf("%d - ciclo_especial ---> WHILE ID IN C_A lista_de_expresiones C_C DO bloque ENDWHILE\n", yylineno);
}
;
lista_de_expresiones: expresion 
{
        printf("%d - lista_de_expresiones ---> expresion\n", yylineno);
        p_l_exp = p_exp;
        dato = p_exp;
        apilar(&pila_expr,&dato);
}

| lista_de_expresiones COMA expresion 
{
        printf("%d - lista_de_expresiones ---> lista_de_expresiones COMA expresion\n", yylineno);

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
        crear_pila(&pila_cond);
        crear_pila(&pila_expr);
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
    fprintf(stderr,"error: in line %d\n");
    system ("Pause");
    exit (1);
}

