%{
#include "./include/cabecera.h"

void guardarSimbolo(const char* type);
void errorCharInvalido();
t_lista_ts tablaSimbolos;

%}

%option noyywrap  
%option yylineno 


DIGITO			[0-9]
LETRA			[a-zA-Z]
ID			{LETRA}({LETRA}|{DIGITO}|_)*
DELIM           [ \t\n\r]
CARACTER    [a-z|A-Z|0-9|=|>|<|!|:|+|-|*|/|"|?|¿|!|¡|@|%|#|&|°|´|^|`|~|/|\\|-|_|.|,|;|¬||]
VALID_STRING    ({CARACTER}+|{DELIM})*
COMENTARIO_S    -\/{VALID_STRING}\/-
COMENTARIO ({COMENTARIO_S}|-\/{VALID_STRING}(({COMENTARIO_S}{VALID_STRING})+|({COMENTARIO_S}{COMENTARIO_S})+|{COMENTARIO_S})*\/-)+
CTE_CADENA  \"([^\"\\]|\\.)*\"
CTE_INT     {DIGITO}+
CTE_REAL    ({DIGITO}*\.{DIGITO}+)|({DIGITO}+\.{DIGITO}*)
WRITE       [Ww][rR][Ii][Tt][Ee]
READ        [Rr][Ee][Aa][Dd]
MOD         [Mm][Oo][Dd]
DIV         [Dd][Ii][Vv]
BEGIN       [Bb][Ee][Gg][Ii][Nn]
STRING      [Ss][Tt][Rr][Ii][Nn][Gg]
CHAR        [Cc][Hh][Aa][Rr]
INTEGER     [Ii][Nn][Tt][Ee][Gg][Ee][Rr]
FLOAT       [Ff][Ll][Oo][Aa][Tt]
DECVAR      [Dd][Ee][Cc][Vv][Aa][Rr]
ENDDEC      [Ee][Nn][Dd][Dd][Ee][Cc]
START       [Ss][Tt][Aa][Rr][Tt]
END         [Ee][Nn][Dd]
IF          [Ii][Ff]
ELSE        [Ee][Ll][Ss][Ee]
WHILE       [Ww][Hh][Ii][Ll][Ee]
IN          [Ii][Nn]
DO          [Dd][Oo]
ENDWHILE    [Ee][Nn][Dd][Ww][Hh][Ii][Ll][Ee]
NOT         [Nn][Oo][Tt]
AND         [Aa][Nn][Dd]
OR          [Oo][Rr]

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
{NOT}       { return NOT;}
{AND}       { return AND;}
{OR}        { return OR;}
"+"			{ return OP_SUMA;}
"-"         { return OP_RESTA;}
"*"         { return OP_MULT;}
{DIV}       {return OP_DIV;}
{MOD}       {return OP_MOD;}
"("			{ return P_A;}
")"			{ return P_C;}
"["         { return C_A;}
"]"         { return C_C;}
{WRITE}  { return ESCRIBIR;}
{READ}  { return ESCANEAR;}
{DECVAR}    {return DECVAR;}
{ENDDEC}    {return ENDDEC;}
{STRING}    {return STRING;}
{INTEGER}   {return INTEGER;}
{FLOAT}     {return FLOAT;}
{CHAR}      {return CHAR;}
{START}     {return START;}
{END}       {return END;}
{IF}        {return IF;}
{ELSE}      {return ELSE;}
{WHILE}     {return WHILE;}
{IN}        {return IN;}
{DO}        {return DO;}
{ENDWHILE}  {return ENDWHILE;}

{CTE_REAL}  {yylval.realVal = atof(yytext); ingresarCteReal(yylval.realVal); return CTE_REAL;}
{CTE_INT}	{yylval.intVal = atoi( yytext ); ingresarCteInt(yylval.intVal); return CTE_INT;}
{CTE_CADENA}    {yylval.strVal = strdup(yytext); ingresarCteString(yylval.strVal); return CTE_CADENA;}
{ID}		{yylval.strVal = strdup(yytext); ingresarId(yytext); return ID;}
{COMENTARIO}

"\n"      		
"\t"
" "

.           {errorCharInvalido();}
%%

void guardarSimbolo(const char *type){

    t_dato_lista_ts dato;
    if(type != NULL && strcmp(type,"string") == 0){
        if((dato.lexema = strdup(yytext)) == NULL){
            puts("Memoria insuficiente!");
            exit(1);
        }

        if((dato.tipo = strdup("string")) == NULL){
            puts("Memoria insuficiente!");
            exit(1);
        }

        if((dato.valor = strdup(obtenerValorString(yytext))) == NULL){
            puts("Memoria insuficiente!");
            exit(1);
        }

        dato.longitud = strlen(yytext) - 2;

        insertar_ordenado_ts(&tablaSimbolos, &dato, comparacion_ts);
    }
    else{

        if((dato.lexema = strdup(yytext)) == NULL){
            puts("Memoria insuficiente!");
            exit(1);
        }       
        if((dato.tipo = strdup(type)) == NULL){
            puts("Memoria insuficiente!");
            exit(1);
        }
        dato.valor = NULL;
        dato.longitud = 0;

        insertar_ordenado_ts(&tablaSimbolos, &dato, comparacion_ts);

    }



}

int validarCteInt(const int cte)
{
	
    if(cte < 0 || cte > USHRT_MAX){
		printf("(!) ERROR: Constante entera fuera de rango (16 bits maximo) -> Linea %d\n", yylineno);
		fprintf(stderr, "Fin de ejecucion.\n");
		system ("Pause");
        guardar_lista_en_archivo_ts(&tablaSimbolos, "ts.txt");
		exit (1);
	}

	return 1;
}

void ingresarCteInt(const int cte){
    if(validarCteInt(cte)){
        guardarSimbolo("");
    }
}

int validarCteReal(const float real)
{

	if(real < FLT_MIN || real > FLT_MAX){
		printf("(!) ERROR: Constante real fuera de rango (-1.17549e-38; 3.40282e38) -> Linea %d\n", yylineno);
		fprintf(stderr, "Fin de ejecucion.\n");
		system ("Pause");
        guardar_lista_en_archivo_ts(&tablaSimbolos, "ts.txt");
		exit (1);
	}
    
	return 1;
}

void ingresarCteReal(const float real){
    if(validarCteReal(real)){
        guardarSimbolo("");
    }
}

int validarCteString(const char *string)
{
	if(strlen(string) > 32){
		printf("(!) ERROR: Constante string fuera de rango (30 caracteres maximo) -> Linea %d\n", yylineno);
		fprintf(stderr, "Fin de ejecucion.\n");
		system ("Pause");
        guardar_lista_en_archivo_ts(&tablaSimbolos, "ts.txt");
		exit (1);
	}
	
	return 1;
}

void ingresarCteString(const char *string){
    if(validarCteString(string)){
        guardarSimbolo("string");
    }
}

int validarId(const char *id)
{
    int length = strlen(id);
 
	if(length > 15){
		printf("(!) ERROR: Identificador fuera de rango (15 caracteres maximo) -> Linea %d\n", yylineno);
		fprintf(stderr, "Fin de ejecucion.\n");
		system ("Pause");
        guardar_lista_en_archivo_ts(&tablaSimbolos, "ts.txt");
		exit (1);
	}
	
	return 1;
}

void ingresarId(const char *id){
    if(validarId(id)){
        guardarSimbolo("id");
    }
}

void errorCharInvalido()
{
	printf("Invalid Character\n");
    fprintf(stderr,"error: invalid character in line %d\n", yylineno);
    system ("Pause");
    exit (1);
}