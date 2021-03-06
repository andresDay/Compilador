%{
#include "./include/cabecera.h"
int yylex();
int yyerror();
int yystopparser=0;
FILE  *yyin;
char *yyltext;
char *yytext;
extern int yylineno;
int cont_auxiliares;
int cont_if;
int cont_while;
char etiquetaElse[200];
char etiquetaThen[200];
char etiquetaEnd[200];
char etiquetaStartWhile[200];
char etiquetaEndWhile[200];

void initPilas();

//DECLARACION DE VARIABLES GLOBALES
t_nodoa *p_f_mod, *p_exp, *p_f, *p_term, *p_asig, *p_aux, *p_cond;
t_nodoa *p_cond_mul, *p_func, *p_sent, *p_sel, *p_ce, *p_c, *p_blo;
t_nodoa *p_prog, *p_tdato, *p_l_var, *p_dec, *p_blo_dec, *p_ini;
t_nodoa *p_ini_pri, *p_l_exp, *p_oper, *p_aux2, *p_cuerpo, *p_id;
t_nodoa* p_auxM, *p_aux1 , *p_aux2, *p_aux3 ,*p_aux4, *p_then, *p_else;
t_nodoa *p_f_int, *p_term_int, *p_exp_int, *p_cond_fact;
t_info *info;
FILE *pf;
t_pila pila_cond, pila_term, pila_expr, pila_blo,pila_list_exp, pila_factor;
t_pila pilaFactInt, pilaTermInt, pilaExpInt, pilaCondFact;
t_pila p_etiquetaElse,p_etiquetaEnd,p_etiquetaStartWhile,p_etiquetaThen,p_etiquetaEndwhile,p_etiquetaStartWhileEsp,p_etiquetaEndWhileEsp;


t_dato_pila dato,dato_m,dato_aux,dato_etiqueta;
char * auxID;

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
%token ESCRIBIR ESCANEAR NEWLINE
%token DECVAR ENDDEC
%token STRING
%token CHAR INTEGER FLOAT
%token IF ELSE WHILE START END IN DO ENDWHILE
%token OP_MULT OP_DIV OP_SUMA OP_RESTA OP_MOD

%left OP_SUMA OP_RESTA OP_MOD
%left OP_MULT OP_DIV
%left OP_RESTA_UNARIA 

%type<intVal> condicion condicion_mul
%type<strVal> expresion

%start inicio_prima
%%

inicio_prima:  inicio {
        printf("%d - inicio' ---> inicio \n", yylineno);

        p_ini_pri = p_ini;

        guardarAuxiliares(cont_auxiliares, &tablaSimbolos);
        generar_assembler("final.asm",p_ini_pri,&tablaSimbolos,indice-1);
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
        p_blo_dec = p_dec;
}

| bloque_declaraciones declaraciones 
{
        printf("%d - bloque_declaraciones ---> bloque_declaraciones declaraciones\n", yylineno);
        info->valor = "BLOQUE\nDECLARACIONES";
        info->indice++;
        p_aux = crear_hoja(info, pf);

        crear_nodo(p_blo_dec, p_aux, p_dec, pf);
        p_blo_dec = p_aux;
}
;
declaraciones: lista_de_variables DECLARACION tipodato P_COMA 
{
        printf("%d - declaraciones ---> lista_de_variables DECLARACION tipodato P_COMA\n", yylineno);
        info->valor = "DEC";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        // printf("\n----------------------\n");
        // printf("%s: ", p_tdato->info.valor);
        set_tipo_ids(p_l_var, p_tdato->info.valor, &tablaSimbolos);
        // printf("\n----------------------\n");

        crear_nodo(p_l_var, p_oper, p_tdato, pf);
        p_dec = p_oper;
}                 
;

lista_de_variables: ID  
{
        printf("%d - lista_de_variables ---> ID\n", yylineno);
        info->valor = $1;
        info->indice++;
        p_l_var = crear_hoja(info, pf);
}

| lista_de_variables COMA ID  
{
        printf("%d - lista_de_variables ---> lista_de_variables COMA ID\n", yylineno);
        info->valor = "COMA";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = $3;
        info->indice++;
        crear_nodo(p_l_var, p_oper, crear_hoja(info, pf), pf);
        p_l_var = p_oper;
}
;

tipodato: STRING
{
        info->valor = T_STRING;
        info->indice++;
        p_tdato = crear_hoja(info, pf);
}
   
|INTEGER   
{
        info->valor = T_INTEGER;
        info->indice++;
        p_tdato = crear_hoja(info, pf);
}
       
|FLOAT
{
        info->valor = T_FLOAT;
        info->indice++;
        p_tdato = crear_hoja(info, pf);
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

funcion:  ESCRIBIR CTE_REAL P_COMA 
{
        printf("%d - funcion ---> ESCRIBIR CTE_REAL P_COMA\n", yylineno);

        info->valor = (char*)malloc(sizeof(char) * 20);
	sprintf(info->valor,"%g", $2);
        info->indice++;
        info->tipo = T_FLOAT;

        char* val = (char*)malloc(sizeof(char) * 20);
        sprintf(val,"%g", $2);

        cambiar_campo_tipo(&tablaSimbolos, obtenerLexemaFloat(val), T_FLOAT);
        cambiar_campo_valor(&tablaSimbolos, obtenerLexemaFloat(val), val);

        p_aux = crear_hoja(info, pf);

        info->valor = "WRITE";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(NULL, p_oper, p_aux, pf);
        p_func = p_oper;
}

|ESCRIBIR CTE_INT P_COMA 
{
        printf("%d - funcion ---> ESCRIBIR P_A factorInt P_C P_COMA\n", yylineno);

        info->valor = (char*)malloc(sizeof(char) * 20);
        info->indice++;
        info->tipo = T_INTEGER;
        sprintf(info->valor,"%d", $2);
        
        cambiar_campo_tipo(&tablaSimbolos, agregarGuionBajo(info->valor), T_INTEGER);
        cambiar_campo_valor(&tablaSimbolos, agregarGuionBajo(info->valor), info->valor);

        p_aux = crear_hoja(info, pf);

        info->valor = "WRITE";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        ver_tope(&pilaFactInt, &p_f_int);

        crear_nodo(NULL, p_oper, p_aux, pf);
        p_func = p_oper;
}

|ESCRIBIR ID P_COMA 
{
        idExists(&tablaSimbolos, $2, yylineno);
        printf("%d - funcion ---> ESCRIBIR ID P_COMA\n", yylineno);

        info->valor = strdup($2);
        info->indice++;
        info->tipo = T_ID;

        p_aux = crear_hoja(info, pf);

        info->valor = "WRITE";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(NULL, p_oper, p_aux, pf);
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
        info->tipo = T_STRING; 
        crear_nodo(NULL, p_oper, crear_hoja(info, pf), pf);
        p_func = p_oper;
}

|ESCRIBIR NEWLINE P_COMA
{
        info->valor = "WRITE";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = T_NEWLINE;
        info->indice++;
        info->tipo = T_NEWLINE; 
        crear_nodo(NULL, p_oper, crear_hoja(info, pf), pf);
        p_func = p_oper;
}

|ESCANEAR INTEGER ID P_COMA 
{
        validateId(&tablaSimbolos, $3, T_INTEGER, yylineno);
        printf("%d - funcion ---> ESCANEAR P_A ID P_C P_COMA\n", yylineno);

        info->valor = "READ INTEGER";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = $3;
        info->indice++;
        info->tipo = T_INTEGER;
        crear_nodo(NULL, p_oper, crear_hoja(info, pf), pf);
        p_func = p_oper;
}

|ESCANEAR FLOAT ID P_COMA 
{
        validateId(&tablaSimbolos, $3, T_FLOAT, yylineno);
        printf("%d - funcion ---> ESCANEAR P_A ID P_C P_COMA\n", yylineno);

        info->valor = "READ FLOAT";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = $3;
        info->indice++;
        info->tipo = T_FLOAT;
        crear_nodo(NULL, p_oper, crear_hoja(info, pf), pf);
        p_func = p_oper;
}
;
seleccion: 
IF P_A condicion_mul P_C START bloque END 
{
        printf("%d - seleccion ---> IF P_A condicion_mul P_C START bloque END\n", yylineno);
       

        info->valor = "IF";
        info->indice++;        
        desapilar(&p_etiquetaElse,&dato_etiqueta);
        printf("ELSE: %s",dato_etiqueta->info.valor);
        info->etiquetaEnd = dato_etiqueta->info.valor;
        free(dato_etiqueta);
        
        
        p_aux = crear_hoja(info, pf);

        desapilar(&pila_cond, &dato);
        desapilar(&pila_blo, &p_blo);

        
        crear_nodo(dato, p_aux, p_blo, pf);
        p_sel = p_aux;
}
          
|IF P_A condicion_mul P_C START bloque END ELSE START bloque END 
{
        printf("%d - seleccion ---> IF P_A condicion_mul P_C START bloque END ELSE START bloque END\n", yylineno);              
        info->valor = "THEN";
        info->indice++;

        desapilar(&p_etiquetaEnd,&dato_etiqueta);        
        info->etiquetaEnd = strdup(dato_etiqueta->info.valor);
        free(dato_etiqueta);
        
        desapilar(&p_etiquetaElse,&dato_etiqueta);
        info->etiquetaElse =strdup(dato_etiqueta->info.valor);        
        free(dato_etiqueta);

        // sprintf(etiquetaThen, "_FIN_%d", cont_then);
        // info->etiquetaThen = strdup(etiquetaThen);
        p_then = crear_hoja(info, pf);

        info->valor = "ELSE";
        info->indice++;        
        p_else = crear_hoja(info, pf);    

        info->valor = "CUERPO";
        info->indice++;
        p_cuerpo = crear_hoja(info, pf);
        
        info->valor = "IF_ELSE";
        info->indice++;
        p_aux = crear_hoja(info, pf);

     
        desapilar(&pila_blo,&dato);        
        p_aux2 = dato;  

        desapilar(&pila_blo, &dato);
        desapilar(&pila_cond, &p_cond_mul);

        crear_nodo(NULL, p_then, dato, pf);
        crear_nodo(NULL, p_else, p_aux2, pf);
        crear_nodo(p_then, p_cuerpo, p_else , pf);
        crear_nodo(p_cond_mul, p_aux, p_cuerpo, pf);
        p_sel = p_aux;
}
;

condicion_mul:condicion 
{
        sprintf(etiquetaElse, "_else_%d", cont_if);
        dato_etiqueta = (t_nodoa *)malloc(sizeof(t_nodoa*));
        dato_etiqueta->info.valor=strdup(etiquetaElse) ;
        apilar(&p_etiquetaElse,&dato_etiqueta);

        p_cond->info.etiquetaElse=strdup(etiquetaElse);
        p_cond->info.cond="AND";
        p_aux = p_cond;        
        dato = p_aux;
        apilar(&pila_cond,&dato);     
}
AND condicion 
{
        printf("%d - condicion_mul ---> condicion AND condicion \n", yylineno);

        sprintf(etiquetaEnd, "_End_%d", cont_if);
        dato_etiqueta = (t_nodoa *)malloc(sizeof(t_nodoa*));
        dato_etiqueta->info.valor=strdup(etiquetaEnd);
        apilar(&p_etiquetaEnd,&dato_etiqueta);
        
        p_cond->info.cond="AND";     
        p_cond->info.etiquetaElse=strdup(etiquetaElse);

        info->valor = "AND";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        desapilar(&pila_cond,&dato);
        crear_nodo(dato, p_oper, p_cond, pf);
        p_cond_mul = p_oper;
        dato = p_cond_mul;
        apilar(&pila_cond,&dato);

        cont_if++;
}

| condicion 
{  
        sprintf(etiquetaThen, "_then_%d\0", cont_if);
        dato_etiqueta = (t_nodoa *)malloc(sizeof(t_nodoa*));
        dato_etiqueta->info.valor= strdup(etiquetaThen);
        apilar(&p_etiquetaThen,&dato_etiqueta);
        
        p_cond->info.etiquetaThen=strdup(etiquetaThen);
        p_cond->info.cond="OR";
        p_aux = p_cond;        
        dato = p_aux;
        apilar(&pila_cond,&dato);        
}
OR condicion 
{
        printf("%d - condicion_mul ---> condicion OR condicion \n", yylineno);
        
        p_cond->info.cond="OR";     
        p_cond->info.etiquetaThen=strdup(etiquetaThen);

        sprintf(etiquetaElse, "_else_%d", cont_if);
        dato_etiqueta = (t_nodoa *)malloc(sizeof(t_nodoa*));
        dato_etiqueta->info.valor=strdup(etiquetaElse);        
        apilar(&p_etiquetaElse,&dato_etiqueta);

        info->etiquetaElse=strdup(etiquetaElse);
        info->etiquetaThen=strdup(etiquetaThen);
        info->valor = "OR";

        sprintf(etiquetaEnd, "_End_%d", cont_if);
        dato_etiqueta = (t_nodoa *)malloc(sizeof(t_nodoa*));
        dato_etiqueta->info.valor=strdup(etiquetaEnd);
        apilar(&p_etiquetaEnd,&dato_etiqueta);

        info->etiquetaEnd = strdup(etiquetaEnd);
        info->indice++;
        p_oper = crear_hoja(info, pf);
        desapilar(&pila_cond,&dato);
        crear_nodo(dato, p_oper, p_cond, pf);
        p_cond_mul = p_oper;
        apilar(&pila_cond, &p_cond_mul);

        cont_if++;
}

| NOT condicion 
{
        printf("%d - condicion_mul ---> NOT condicion \n", yylineno);

        p_cond->info.cond="NOT";

        dato_etiqueta = (t_nodoa *)malloc(sizeof(t_nodoa*));
        sprintf(etiquetaElse, "_else_%d\0", cont_if);
        dato_etiqueta->info.valor=strdup(etiquetaElse);
        apilar(&p_etiquetaElse,&dato_etiqueta); 

        p_cond->info.etiquetaElse=strdup(etiquetaElse);

        dato_etiqueta = (t_nodoa *)malloc(sizeof(t_nodoa*));
        sprintf(etiquetaEnd, "_End_%d", cont_if);
        dato_etiqueta->info.valor=strdup(etiquetaEnd);
        apilar(&p_etiquetaEnd,&dato_etiqueta); 

        p_cond->info.etiquetaEnd=strdup(etiquetaEnd);
        // p_cond_mul = p_cond;
        // apilar(&pila_cond, &p_cond_mul);

        info->valor = "NOT";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(NULL, p_oper, p_cond, pf);
        p_cond_mul = p_oper;
        apilar(&pila_cond, &p_cond_mul);

        cont_if++;
}

| condicion 
{
        printf("%d - condicion_mul ---> condicion \n", yylineno);
        sprintf(etiquetaElse, "_else_%d\0", cont_if);

        dato_etiqueta = (t_nodoa *)malloc(sizeof(t_nodoa*));        
        dato_etiqueta->info.valor=strdup(etiquetaElse);
        apilar(&p_etiquetaElse,&dato_etiqueta);

        p_cond->info.etiquetaElse=strdup(etiquetaElse);
        p_cond->info.cond = NULL;

        sprintf(etiquetaEnd, "_End_%d\0", cont_if);
        dato_etiqueta = (t_nodoa *)malloc(sizeof(t_nodoa*));
        dato_etiqueta->info.valor=strdup(etiquetaEnd);
        apilar(&p_etiquetaEnd,&dato_etiqueta);

        p_cond->info.etiquetaEnd=strdup(etiquetaEnd);
        p_cond_mul = p_cond;
        apilar(&pila_cond, &p_cond_mul);

        cont_if++;
}
;

condicionFactor: expresion
{
        desapilar(&pila_expr, &p_aux);
        apilar(&pilaCondFact, &p_aux);
}

|expresionInt
{
        desapilar(&pilaExpInt, &p_aux);
        apilar(&pilaCondFact, &p_aux);  
}
;

condicion: condicionFactor MAYOR condicionFactor 
{
        printf("%d - condicion ---> expresion MAYOR expresion \n", yylineno);
        info->valor = "MAYOR";
        info->indice++;
        p_oper = crear_hoja(info, pf);
        
        desapilar(&pilaCondFact, &p_cond_fact);
        desapilar(&pilaCondFact, &p_aux);
        crear_nodo(p_aux, p_oper, p_cond_fact, pf);
        p_cond = p_oper;
}
          
|condicionFactor MENOR condicionFactor 
{
        printf("%d - condicion ---> expresion MENOR expresion \n", yylineno);

        info->valor = "MENOR";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        desapilar(&pilaCondFact, &p_cond_fact);
        desapilar(&pilaCondFact, &p_aux);
        crear_nodo(p_aux, p_oper, p_cond_fact, pf);
        p_cond = p_oper;
}

|condicionFactor MAYOR_IGUAL condicionFactor 
{
        printf("%d - condicion ---> expresion MAYOR_IGUAL expresion \n", yylineno);

        info->valor = "MAYOR O IGUAL";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        desapilar(&pilaCondFact, &p_cond_fact);
        desapilar(&pilaCondFact, &p_aux);
        crear_nodo(p_aux, p_oper, p_cond_fact, pf);
        p_cond = p_oper;
}
          
|condicionFactor MENOR_IGUAL condicionFactor 
{
        printf("%d - condicion ---> expresion MENOR_IGUAL expresion \n", yylineno);

        info->valor = "MENOR O IGUAL";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        desapilar(&pilaCondFact, &p_cond_fact);
        desapilar(&pilaCondFact, &p_aux);
        crear_nodo(p_aux, p_oper, p_cond_fact, pf);
        p_cond = p_oper;
}

|condicionFactor IGUAL condicionFactor 
{
        printf("%d - condicion ---> expresion IGUAL expresion \n", yylineno);

        info->valor = "IGUAL";
        info->indice++;
        p_oper = crear_hoja(info, pf);
        
        desapilar(&pilaCondFact, &p_cond_fact);
        desapilar(&pilaCondFact, &p_aux);
        crear_nodo(p_aux, p_oper, p_cond_fact, pf);
        p_cond = p_oper;
}

|condicionFactor DISTINTO condicionFactor 
{
        printf("%d - expresion DISTINTO expresion\n", yylineno);

        info->valor = "DISTINTO";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        desapilar(&pilaCondFact, &p_cond_fact);
        desapilar(&pilaCondFact, &p_aux);
        crear_nodo(p_aux, p_oper, p_cond_fact, pf);
        p_cond = p_oper;
}
;

asignacion: ID ASIG expresion P_COMA 
{
        idExists(&tablaSimbolos, $1, yylineno);

        printf("%d - asignacion ---> ID ASIG expresion P_COMA \n", yylineno);
        info->valor = "ASIG";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = $1;
        info->indice++;
        info->tipo = T_FLOAT;
        p_aux = crear_hoja(info, pf);

        desapilar(&pila_expr, &p_exp);

        crear_nodo(p_aux, p_oper, p_exp, pf);
        p_asig = p_oper;
}

|ID ASIG expresionInt P_COMA 
{
        idExists(&tablaSimbolos, $1, yylineno);

        printf("%d - asignacion ---> ID ASIG expresionInt P_COMA \n", yylineno);
        info->valor = "ASIG";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = $1;
        info->indice++;
        info->tipo = T_INTEGER;
        p_aux = crear_hoja(info, pf);

        desapilar(&pilaExpInt, &p_exp_int);

        crear_nodo(p_aux, p_oper, p_exp_int, pf);
        p_asig = p_oper;
}
;

expresion: expresion OP_SUMA termino  
{
        printf("%d - expresion ---> expresion OP_SUMA termino \n", yylineno);
        info->valor = "SUMA";
        info->indice++;
        p_oper = crear_hoja(info, pf);
        desapilar(&pila_term,&dato);            
        desapilar(&pila_expr,&dato_aux);
        crear_nodo(dato_aux, p_oper, dato, pf);
        apilar(&pila_expr,&p_oper);

        p_exp = p_oper;

        cont_auxiliares++;
}

|expresion OP_RESTA termino 
{
        printf("%d - expresion ---> expresion OP_RESTA termino \n", yylineno);
        info->valor = "RESTA";
        info->indice++;
        p_oper = crear_hoja(info, pf);
        desapilar(&pila_term,&dato);        
        desapilar(&pila_expr,&dato_aux);
        crear_nodo(dato_aux, p_oper, dato, pf);
        apilar(&pila_expr,&p_oper);
        p_exp = p_oper;

        cont_auxiliares++;
}

|expresion OP_SUMA terminoInt  
{
        printf("%d - expresion ---> expresion OP_SUMA terminoInt \n", yylineno);
        info->valor = "SUMA";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        desapilar(&pilaTermInt,&dato);            
        desapilar(&pila_expr,&dato_aux);
        crear_nodo(dato_aux, p_oper, dato, pf);

        apilar(&pila_expr,&p_oper);
        p_exp = p_oper;

        cont_auxiliares++;
}

|expresion OP_RESTA terminoInt 
{
        printf("%d - expresion ---> expresion OP_RESTA terminoInt \n", yylineno);
        info->valor = "RESTA";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        desapilar(&pilaTermInt, &dato);        
        desapilar(&pila_expr, &dato_aux);
        crear_nodo(dato_aux, p_oper, dato, pf);

        apilar(&pila_expr, &p_oper);
        p_exp = p_oper;

        cont_auxiliares++;
}

|expresionInt OP_SUMA termino  
{
        printf("%d - expresion ---> expresion OP_SUMA terminoInt \n", yylineno);
        info->valor = "SUMA";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        desapilar(&pila_term,&dato);            
        desapilar(&pilaExpInt, &dato_aux);
        crear_nodo(dato_aux, p_oper, dato, pf);

        apilar(&pila_expr, &p_oper);
        p_exp = p_oper;

        cont_auxiliares++;
}

|expresionInt OP_RESTA termino
{
        printf("%d - expresion ---> expresion OP_RESTA terminoInt \n", yylineno);
        info->valor = "RESTA";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        desapilar(&pila_term, &dato);        
        desapilar(&pilaExpInt, &dato_aux);
        crear_nodo(dato_aux, p_oper, dato, pf);

        apilar(&pila_expr, &p_oper);
        p_exp = p_oper;

        cont_auxiliares++;
}

|termino 
{
        printf("%d - expresion ---> termino \n", yylineno);
        dato = p_term;
        apilar(&pila_expr,&dato);
        p_exp = dato;
        desapilar(&pila_term,&dato);
}
;

termino: termino OP_MULT factor 
{
        printf("%d - termino ---> termino OP_MULT factor \n", yylineno);
        info->valor = "MULT";
        info->indice++;
        p_oper = crear_hoja(info, pf);
        desapilar(&pila_term,&dato);
        desapilar(&pila_factor,&dato_aux);
        crear_nodo(dato, p_oper, dato_aux, pf);

        dato = p_oper;
        apilar(&pila_term,&dato);

        p_term = p_oper;

        cont_auxiliares++;
}
                
|termino OP_DIV factor 
{
        printf("%d - termino ---> termino OP_DIV factor \n", yylineno);
        info->valor = "DIV";
        info->indice++;
        p_oper = crear_hoja(info, pf);
        desapilar(&pila_term,&dato);
        desapilar(&pila_factor,&dato_aux);
        crear_nodo(dato, p_oper, dato_aux, pf);
        dato = p_oper;
        apilar(&pila_term,&dato);
        p_term = p_oper;

        cont_auxiliares++;
}

|termino OP_MULT factorInt 
{
        printf("%d - termino ---> termino OP_MULT factorInt \n", yylineno);
        info->valor = "MULT";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        desapilar(&pila_term, &dato);
        desapilar(&pilaFactInt, &dato_aux);
        crear_nodo(dato, p_oper, dato_aux, pf);

        dato = p_oper;
        apilar(&pila_term,&dato);

        p_term = p_oper;

        cont_auxiliares++;
}

|termino OP_DIV factorInt 
{
        printf("%d - termino ---> termino OP_DIV factorInt \n", yylineno);
        info->valor = "DIV";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        desapilar(&pila_term, &dato);
        desapilar(&pilaFactInt, &dato_aux);
        crear_nodo(dato, p_oper, dato_aux, pf);

        dato = p_oper;
        apilar(&pila_term,&dato);
        p_term = p_oper;

        cont_auxiliares++;
}

|terminoInt OP_DIV factorInt 
{
        printf("%d - termino ---> termino OP_DIV factorInt \n", yylineno);
        info->valor = "DIV";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        desapilar(&pilaTermInt, &dato);
        desapilar(&pilaFactInt, &dato_aux);
        crear_nodo(dato, p_oper, dato_aux, pf);

        dato = p_oper;
        apilar(&pila_term,&dato);
        p_term = p_oper;

        cont_auxiliares++;
}

|factor 
{
        printf("%d - termino ---> factor \n", yylineno);
        dato = p_f;
        apilar(&pila_term,&dato);
        desapilar(&pila_factor,&dato);
        p_term = p_f;
}
;

factor: factor OP_MOD factor_mod 
{
        printf("%d - factor --> factor OP_MOD factor_mod \n", yylineno);
        info->valor = "MOD";
        info->indice++;
        p_oper = crear_hoja(info, pf);
        desapilar(&pila_factor,&dato);
        crear_nodo(dato, p_oper, p_f_mod, pf);
        dato = p_oper;
        apilar(&pila_factor,&dato);
        p_f = p_oper;
        cont_auxiliares++;
}

|factorInt OP_MOD factor_mod 
{
        printf("%d - factor --> factor OP_MOD factor_mod \n", yylineno);
        info->valor = "MOD";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        desapilar(&pilaFactInt,&dato);
        crear_nodo(dato, p_oper, p_f_mod, pf);

        dato = p_oper;
        apilar(&pila_factor,&dato);
        p_f = p_oper;
        cont_auxiliares++;
}

|factor_mod OP_MOD factorInt 
{
        printf("%d - factor --> factor_mod OP_MOD factorInt \n", yylineno);
        info->valor = "MOD";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        desapilar(&pilaFactInt,&dato);
        crear_nodo(p_f_mod, p_oper, dato, pf);

        dato = p_oper;
        apilar(&pila_factor,&dato);
        p_f = p_oper;
        cont_auxiliares++;
}

|factorInt OP_MOD factorInt 
{
        printf("%d - factor --> factor OP_MOD factor_mod \n", yylineno);
        info->valor = "MOD";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        desapilar(&pilaFactInt,&dato_aux);
        desapilar(&pilaFactInt,&dato);

        crear_nodo(dato, p_oper, dato_aux, pf);

        dato = p_oper;
        apilar(&pila_factor,&dato);
        p_f = p_oper;

        cont_auxiliares++;
}
        
| factor_mod 
{
        printf("%d -  factor --> factor_mod \n", yylineno);
        dato = p_f_mod;
        apilar(&pila_factor,&dato);
        p_f = p_f_mod;
}
; 

factor_mod: ID  
{
        idExists(&tablaSimbolos, $1, yylineno);

        printf("%d -  factor_mod --> ID \n", yylineno);
        $<strVal>$ = $1;
        info->valor = $1;
        info->indice++;
        info->tipo = T_ID;
        p_f_mod = crear_hoja(info, pf); 
}

|CTE_REAL 
{
        printf("%d -  factor_mod --> CTE_REAL \n", yylineno);
        $<realVal>$ = $1;
        info->valor = (char*)malloc(sizeof(char) * 20);
	sprintf(info->valor,"%g", $1);
        info->indice++;
        info->tipo = T_FLOAT;

        char* val = (char*)malloc(sizeof(char) * 20);
        sprintf(val,"%g", $1);

        printf("\n\n%s\n\n", obtenerLexemaFloat(val));
        printf("\n\n%s\n\n", info->valor);

        cambiar_campo_tipo(&tablaSimbolos, obtenerLexemaFloat(val), T_FLOAT);
        cambiar_campo_valor(&tablaSimbolos, obtenerLexemaFloat(val), val);

        p_f_mod = crear_hoja(info, pf); 
}

|OP_RESTA CTE_REAL %prec OP_RESTA_UNARIA
{
        printf("%d -  factor_mod --> CTE_REAL \n", yylineno);
        $<realVal>$ = $2 * (-1);
        info->valor = (char*)malloc(sizeof(char) * 20);
        sprintf(info->valor,"-%g", $2);
        info->indice++;
        info->tipo = T_FLOAT;

        // char* val = (char*)malloc(sizeof(char) * 20);
        // sprintf(val,"%g", $2);

        // cambiar_campo_tipo(&tablaSimbolos, obtenerLexemaFloat(val), T_FLOAT);
        // cambiar_campo_valor(&tablaSimbolos, obtenerLexemaFloat(val), val);

        t_dato_lista_ts ts_dato;
        if((ts_dato.lexema = strdup(obtenerLexemaFloatNeg(yytext))) == NULL){
            puts("Memoria insuficiente!");
            exit(1);
        }       
        if((ts_dato.tipo = strdup(T_FLOAT)) == NULL){
            puts("Memoria insuficiente!");
            exit(1);
        }
        ts_dato.valor = (char*)malloc(sizeof(char) * 20);
        sprintf(ts_dato.valor,"-%g", $2);
        ts_dato.longitud = 0;

        insertar_ordenado_ts(&tablaSimbolos, &ts_dato, comparacion_ts);

        p_f_mod = crear_hoja(info, pf); 
}

|P_A expresion P_C 
{
        printf("%d - factor_mod --> P_A expresion P_C \n", yylineno); 
        desapilar(&pila_expr,&dato);
        p_f_mod = dato;
}
;

expresionInt: expresionInt OP_SUMA terminoInt  
{
        printf("%d - expresion ---> expresionInt OP_SUMA terminoInt \n", yylineno);
        info->valor = "SUMA";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        desapilar(&pilaTermInt, &dato);            
        desapilar(&pilaExpInt, &dato_aux);
        crear_nodo(dato_aux, p_oper, dato, pf);

        apilar(&pilaExpInt,&p_oper);

        p_exp_int = p_oper;

        cont_auxiliares++;
}

|expresionInt OP_RESTA terminoInt 
{
        printf("%d - expresion ---> expresionInt OP_RESTA terminoInt \n", yylineno);
        info->valor = "RESTA";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        desapilar(&pilaTermInt, &dato);        
        desapilar(&pilaExpInt, &dato_aux);
        crear_nodo(dato_aux, p_oper, dato, pf);

        apilar(&pilaExpInt, &p_oper);
        p_exp_int = p_oper;

        cont_auxiliares++;
}

|terminoInt 
{
        printf("%d - expresionInt ---> terminoInt \n", yylineno);

        desapilar(&pilaTermInt, &dato);
        apilar(&pilaExpInt, &dato);
        p_exp_int = dato;
}
;

terminoInt: terminoInt OP_MULT factorInt 
{
        printf("%d - termino ---> terminoInt OP_MULT factorInt \n", yylineno);
        info->valor = "MULT";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        desapilar(&pilaTermInt, &dato);
        desapilar(&pilaFactInt, &dato_aux);
        crear_nodo(dato, p_oper, dato_aux, pf);

        dato = p_oper;
        apilar(&pilaTermInt, &dato);

        p_term = p_oper;

        cont_auxiliares++;
}             

|factorInt 
{
        printf("%d - termino ---> factor \n", yylineno);
        dato = p_f_int;

        desapilar(&pilaFactInt,&dato);
        apilar(&pilaTermInt, &dato);
        p_term_int = p_f_int;
}
;

factorInt: CTE_INT 
{
        printf("%d -  factor_mod --> CTE_INT \n", yylineno);
        $<intVal>$ = $1;

        info->valor = (char*)malloc(sizeof(char) * 20);
        info->indice++;
        info->tipo = T_INTEGER;
        sprintf(info->valor,"%d", $1);
        
        cambiar_campo_tipo(&tablaSimbolos, agregarGuionBajo(info->valor), T_INTEGER);
        cambiar_campo_valor(&tablaSimbolos, agregarGuionBajo(info->valor), info->valor);

        p_f_int = crear_hoja(info, pf); 
        apilar(&pilaFactInt, &p_f_int);
}

|OP_RESTA CTE_INT %prec OP_RESTA_UNARIA
{
        printf("%d -  factor_mod --> CTE_INT \n", yylineno);
        $<intVal>$ = $2 * (-1);
        info->valor = (char*)malloc(sizeof(char) * 20);
        sprintf(info->valor,"-%d", $2);
        info->indice++;
        info->tipo = T_INTEGER;

        // cambiar_campo_tipo(&tablaSimbolos, agregarGuionBajo(info->valor), T_INTEGER);
        // cambiar_campo_valor(&tablaSimbolos, agregarGuionBajo(info->valor), info->valor);

        t_dato_lista_ts ts_dato;
        if((ts_dato.lexema = strdup(obtenerLexemaFloatNeg(yytext))) == NULL){
            puts("Memoria insuficiente!");
            exit(1);
        }       
        if((ts_dato.tipo = strdup(T_INTEGER)) == NULL){
            puts("Memoria insuficiente!");
            exit(1);
        }
        ts_dato.valor = (char*)malloc(sizeof(char) * 20);
        sprintf(ts_dato.valor,"-%d", $2);
        ts_dato.longitud = 0;

        insertar_ordenado_ts(&tablaSimbolos, &ts_dato, comparacion_ts);

        p_f_int = crear_hoja(info, pf); 
        apilar(&pilaFactInt, &p_f_int);
}

|P_A expresionInt P_C 
{
        printf("%d - factor_mod --> P_A expresion P_C \n", yylineno); 
        desapilar(&pilaExpInt,&dato);
        apilar(&pilaFactInt, &dato);
        p_f_int = dato;
}
;

ciclo: WHILE P_A condicion_mul P_C START bloque END 
{
        
        desapilar(&p_etiquetaElse,&dato_etiqueta);
        info->etiquetaEnd=strdup(dato_etiqueta->info.valor);
        free(dato_etiqueta);

        sprintf(etiquetaStartWhile, "_StartWhile_%d", cont_while);
        info->etiquetaStart=strdup(etiquetaStartWhile);
        info->valor = "WHILE";
        info->indice++;       
        p_aux = crear_hoja(info,pf);

        desapilar(&pila_blo, &dato);
        desapilar(&pila_cond, &p_cond_mul);
        if( strcmp(p_cond_mul->info.valor, "AND") == 0 ||  strcmp(p_cond_mul->info.valor, "OR") == 0  || strcmp(p_cond_mul->info.valor, "NOT") == 0  ){           
                p_cond_mul->izq->info.esWhile = 1;     
                p_cond_mul->izq->info.etiquetaStart=strdup(etiquetaStartWhile);   
        }               
        else{       
                p_cond_mul->info.etiquetaStart=strdup(etiquetaStartWhile);
                p_cond_mul->info.esWhile = 1;  
        }       
        crear_nodo(p_cond_mul,p_aux,dato,pf);

        p_c = p_aux;
        printf("%d - ciclo ---> WHILE P_A condicion_mul P_C START bloque END \n", yylineno);

        cont_while++;
}
         
;
ciclo_especial: WHILE ID { auxID = $2;} IN C_A lista_de_expresiones C_C DO bloque ENDWHILE 
{  
        ver_tope(&p_etiquetaEndWhileEsp,&dato_etiqueta);
        info->etiquetaEnd =  strdup(dato_etiqueta->info.valor);
        info->valor = "WHILE_ESP";
        desapilar(&p_etiquetaStartWhileEsp,&dato_etiqueta);
        info->etiquetaStart = strdup(dato_etiqueta->info.valor);
        free(dato_etiqueta);
        info->indice++;
        p_ce = crear_hoja(info,pf);

        // info->valor = $2;
        // info->indice++;
        // info->tipo = T_ID;
        // p_id = crear_hoja(info,pf);

        desapilar(&pila_list_exp,&p_l_exp);

        
        desapilar(&p_etiquetaEndWhileEsp,&dato_etiqueta);
        info->valor = "LISTA";
        info->etiquetaEnd = strdup(dato_etiqueta->info.valor);
        free(dato_etiqueta);

        if( strcmp(p_l_exp->info.valor,";")==0)
                info->etiquetaThen = strdup(p_l_exp->der->info.etiquetaThen);
        else
                info->etiquetaThen = strdup(p_l_exp->info.etiquetaThen);   
        info->indice++;
        p_oper = crear_hoja(info,pf);

        crear_nodo(p_l_exp, p_oper, NULL, pf);

        desapilar(&pila_blo, &p_blo);
        crear_nodo(p_oper, p_ce, p_blo, pf);
        
        printf("%d - ciclo_especial ---> WHILE ID IN C_A lista_de_expresiones C_C DO bloque ENDWHILE\n", yylineno);
        
}
;
lista_de_expresiones: expresion 
{
        printf("%d - lista_de_expresiones ---> expresion\n", yylineno);
        
        desapilar(&pila_expr, &p_exp);
        // apilar(&pila_list_exp,&p_exp);

        info->valor=auxID;
        info->indice++;        
        p_aux2=crear_hoja(info,pf);

        sprintf(etiquetaStartWhile, "_StartWhileEspecial_%d", cont_while);
        dato_etiqueta = (t_nodoa *)malloc(sizeof(t_nodoa*));
        dato_etiqueta->info.valor=strdup(etiquetaStartWhile);
        apilar(&p_etiquetaStartWhileEsp,&dato_etiqueta);

        sprintf(etiquetaEndWhile, "_EndWhileEspecial_%d", cont_while);
        dato_etiqueta = (t_nodoa *)malloc(sizeof(t_nodoa*));
        dato_etiqueta->info.valor=strdup(etiquetaEndWhile);
        apilar(&p_etiquetaEndWhileEsp,&dato_etiqueta);

        info->etiquetaStart = strdup(etiquetaStartWhile);
        sprintf(etiquetaThen, "_ThenWhileEspecial_%d", cont_while);
        info->etiquetaThen =strdup(etiquetaThen);
        info->valor="==";
        info->indice++;
        p_l_exp=crear_hoja(info,pf);

        crear_nodo(p_aux2, p_l_exp ,p_exp,pf);

        apilar(&pila_list_exp, &p_l_exp );
        cont_while++;
        
}

|expresionInt 
{
        printf("%d - lista_de_expresiones ---> expresionInt\n", yylineno);
        
        desapilar(&pilaExpInt, &p_exp_int);

        info->valor=auxID;
        info->indice++;        
        p_aux2=crear_hoja(info,pf);

        sprintf(etiquetaStartWhile, "_StartWhileEspecial_%d", cont_while);
        dato_etiqueta = (t_nodoa *)malloc(sizeof(t_nodoa*));
        dato_etiqueta->info.valor=strdup(etiquetaStartWhile);
        apilar(&p_etiquetaStartWhileEsp,&dato_etiqueta);

        sprintf(etiquetaEndWhile, "_EndWhileEspecial_%d", cont_while);
        dato_etiqueta = (t_nodoa *)malloc(sizeof(t_nodoa*));
        dato_etiqueta->info.valor=strdup(etiquetaEndWhile);
        apilar(&p_etiquetaEndWhileEsp,&dato_etiqueta);

        info->etiquetaStart = strdup(etiquetaStartWhile);
        sprintf(etiquetaThen, "_ThenWhileEspecial_%d", cont_while);
        info->etiquetaThen =strdup(etiquetaThen);
        info->valor="==";
        info->indice++;
        p_l_exp=crear_hoja(info,pf);

        crear_nodo(p_aux2, p_l_exp ,p_exp_int,pf);

        apilar(&pila_list_exp, &p_l_exp );
        cont_while++;
        
}

| lista_de_expresiones COMA expresion 
{
        printf("%d - lista_de_expresiones ---> lista_de_expresiones COMA expresion\n", yylineno);

        desapilar(&pila_expr, &p_exp);
   
        info->valor=auxID;
        info->indice++;        
        p_aux2=crear_hoja(info,pf);

        
        info->valor="==";
        info->etiquetaStart=strdup("");
        info->etiquetaThen =strdup(etiquetaThen);     
        info->indice++;
        p_aux3=crear_hoja(info,pf);

        crear_nodo(p_aux2, p_aux3 ,p_exp,pf);

        info->valor=";";
        info->indice++;
        p_aux2=crear_hoja(info,pf);

        desapilar(&pila_list_exp,&p_l_exp);

        crear_nodo(p_l_exp ,p_aux2 ,p_aux3,pf );

        apilar(&pila_list_exp , &p_aux2);     
}

| lista_de_expresiones COMA expresionInt 
{
        printf("%d - lista_de_expresiones ---> lista_de_expresiones COMA expresionInt\n", yylineno);

        desapilar(&pilaExpInt, &p_exp_int);
   
        info->valor=auxID;
        info->indice++;        
        p_aux2=crear_hoja(info,pf);

        
        info->valor="==";
        info->etiquetaStart=strdup("");
        info->etiquetaThen =strdup(etiquetaThen);     
        info->indice++;
        p_aux3=crear_hoja(info,pf);

        crear_nodo(p_aux2, p_aux3 ,p_exp_int,pf);

        info->valor=";";
        info->indice++;
        p_aux2=crear_hoja(info,pf);

        desapilar(&pila_list_exp,&p_l_exp);

        crear_nodo(p_l_exp ,p_aux2 ,p_aux3,pf );

        apilar(&pila_list_exp , &p_aux2);   
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
        initPilas();

        info=(t_info*)malloc(sizeof(t_info));
        indice=0;
        cont_auxiliares = 0;
        cont_if = 0;
        cont_while = 0;
        
        info->indice=-1;

        fprintf(pf,"digraph G {\ngraph [ordering=\"out\"];\n");
	yyparse();
        fprintf(pf,"}");

        fclose(pf);
        printf("\n\nCantidad de auxiliares: %d\n\n", cont_auxiliares);
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

void initPilas(){
        crear_pila(&pila_blo);
        crear_pila(&pila_cond);
        crear_pila(&pila_expr);
        crear_pila(&pila_term);
        crear_pila(&pila_list_exp);
        crear_pila(&pila_factor);
        crear_pila(&pilaExpInt);
        crear_pila(&pilaTermInt);
        crear_pila(&pilaFactInt);
        crear_pila(&pilaCondFact);
        crear_pila(&p_etiquetaStartWhile);
        crear_pila(&p_etiquetaEndwhile);
        crear_pila(&p_etiquetaElse);
        crear_pila(&p_etiquetaEnd);
        crear_pila(&p_etiquetaThen);
        crear_pila(&p_etiquetaStartWhileEsp);
        crear_pila(&p_etiquetaEndWhileEsp);
}
