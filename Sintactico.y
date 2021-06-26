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
t_nodoa* p_auxM, *p_aux3;
t_info *info;
FILE *pf;
t_pila pila_cond, pila_term, pila_expr, pila_blo,pila_list_exp, pila_factor;


t_dato_pila dato,dato_m,dato_aux;
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
%token ESCRIBIR ESCANEAR 
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
        printf("%d - bloque_declaraciones ---> declaraciones\n", yylineno);
        info->valor = "BLOQUE\nDECLARACIONES";
        info->indice++;
        p_blo_dec = crear_hoja(info, pf);
}

| bloque_declaraciones declaraciones 
{
        printf("%d - bloque_declaraciones ---> bloque_declaraciones declaraciones\n", yylineno);
}
;
declaraciones: lista_de_variables DECLARACION tipodato P_COMA 
{
        printf("%d - declaraciones ---> lista_de_variables DECLARACION tipodato P_COMA\n", yylineno);
}                 
;

lista_de_variables: ID  
{
        printf("%d - lista_de_variables ---> ID\n", yylineno);
}

| lista_de_variables COMA ID  
{
        printf("%d - lista_de_variables ---> lista_de_variables COMA ID\n", yylineno);
}
;

tipodato: STRING
|CHAR
|INTEGER     
|FLOAT
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
        info->tipo = T_STRING; 
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

        desapilar(&pila_expr, &p_exp);

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
        info->tipo = T_STRING; 
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
        desapilar(&pila_term,&dato);            
        desapilar(&pila_expr,&dato_aux);
        crear_nodo(dato_aux, p_oper, dato, pf);
        apilar(&pila_expr,&p_oper);

        p_exp = p_oper;
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
        info->valor = (char*)malloc(sizeof(char) * 20);
        info->indice++;
        info->tipo = T_INTEGER;
        sprintf(info->valor,"%d", $1);
        
        cambiar_campo_tipo(&tablaSimbolos, agregarGuionBajo(info->valor), T_INTEGER);
        cambiar_campo_valor(&tablaSimbolos, agregarGuionBajo(info->valor), info->valor);

        p_f_mod = crear_hoja(info, pf); 
}

|CTE_REAL 
{
        printf("%d -  factor_mod --> CTE_REAL \n", yylineno);
        $<realVal>$ = $1;
        info->valor = (char*)malloc(sizeof(char) * 20);
	sprintf(info->valor,"%.10f", $1);
        info->indice++;
        info->tipo = T_FLOAT;

        char* val = (char*)malloc(sizeof(char) * 20);
        sprintf(val,"%g", $1);

        printf("\n\n%s\n\n", val);
        printf("\n\n%s\n\n", info->valor);

        cambiar_campo_tipo(&tablaSimbolos, agregarGuionBajo(val), T_FLOAT);
        cambiar_campo_valor(&tablaSimbolos, agregarGuionBajo(val), val);

        p_f_mod = crear_hoja(info, pf); 
}

|OP_RESTA CTE_INT %prec OP_RESTA_UNARIA
{
        printf("%d -  factor_mod --> CTE_INT \n", yylineno);
        $<intVal>$ = $2 * (-1);
        info->valor = (char*)malloc(sizeof(char) * 20);
        sprintf(info->valor,"-%d", $2);
        info->indice++;
        info->tipo = T_INTEGER;

        cambiar_campo_tipo(&tablaSimbolos, agregarGuionBajo(info->valor), T_INTEGER);
        cambiar_campo_valor(&tablaSimbolos, agregarGuionBajo(info->valor), info->valor);

        p_f_mod = crear_hoja(info, pf); 
}

|OP_RESTA CTE_REAL %prec OP_RESTA_UNARIA
{
        printf("%d -  factor_mod --> CTE_REAL \n", yylineno);
        $<realVal>$ = $2 * (-1);
        info->valor = (char*)malloc(sizeof(char) * 20);
        sprintf(info->valor,"-%.10f", $2);
        info->indice++;
        info->tipo = T_FLOAT;

        char* val = (char*)malloc(sizeof(char) * 20);
        sprintf(val,"%g", $2);

        cambiar_campo_tipo(&tablaSimbolos, agregarGuionBajo(val), T_FLOAT);
        cambiar_campo_valor(&tablaSimbolos, agregarGuionBajo(val), val);

        p_f_mod = crear_hoja(info, pf); 
}

|P_A expresion P_C 
{
        printf("%d - factor_mod --> P_A expresion P_C \n", yylineno); 
        desapilar(&pila_expr,&dato);
        p_f_mod = dato;
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
        info->valor = "WHILE_ESP";
        info->indice++;
        p_ce = crear_hoja(info,pf);

        info->valor = "IN";
        info->indice++;
        p_oper = crear_hoja(info,pf);

        info->valor = $2;
        info->indice++;
        p_id = crear_hoja(info,pf);

        desapilar(&pila_list_exp,&p_l_exp);

        crear_nodo(p_id, p_oper, p_l_exp, pf);

        desapilar(&pila_blo, &p_blo);
        crear_nodo(p_oper, p_ce, p_blo, pf);
        
        printf("%d - ciclo_especial ---> WHILE ID IN C_A lista_de_expresiones C_C DO bloque ENDWHILE\n", yylineno);
}
;
lista_de_expresiones: expresion 
{
        printf("%d - lista_de_expresiones ---> expresion\n", yylineno);
        
        desapilar(&pila_expr, &p_exp);
        apilar(&pila_list_exp,&p_exp);
 
}

| lista_de_expresiones COMA expresion 
{
        printf("%d - lista_de_expresiones ---> lista_de_expresiones COMA expresion\n", yylineno);

        desapilar(&pila_expr, &p_exp);

        desapilar(&pila_list_exp,&p_l_exp);

        info->valor = "Lista_exp";
        info->indice++;
        p_oper = crear_hoja(info,pf);

        crear_nodo(p_l_exp, p_oper, p_exp, pf);
        apilar(&pila_list_exp, &p_oper);     
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
        crear_pila(&pila_term);
        crear_pila(&pila_list_exp);
        crear_pila(&pila_factor);
        info=(t_info*)malloc(sizeof(t_info));
        indice=0;
        info->indice=-1;

        fprintf(pf,"digraph G {\ngraph [ordering=\"out\"];\n");
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

