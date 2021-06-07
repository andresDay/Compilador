
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     CTE_INT = 258,
     CTE_REAL = 259,
     CTE_CADENA = 260,
     P_COMA = 261,
     DECLARACION = 262,
     COMA = 263,
     C_A = 264,
     C_C = 265,
     AND = 266,
     OR = 267,
     NOT = 268,
     IGUAL = 269,
     DISTINTO = 270,
     MAYOR = 271,
     MENOR = 272,
     MENOR_IGUAL = 273,
     MAYOR_IGUAL = 274,
     ID = 275,
     ASIG = 276,
     P_A = 277,
     P_C = 278,
     ESCRIBIR = 279,
     ESCANEAR = 280,
     DECVAR = 281,
     ENDDEC = 282,
     STRING = 283,
     CHAR = 284,
     INTEGER = 285,
     FLOAT = 286,
     IF = 287,
     ELSE = 288,
     WHILE = 289,
     START = 290,
     END = 291,
     IN = 292,
     DO = 293,
     ENDWHILE = 294,
     OP_MULT = 295,
     OP_DIV = 296,
     OP_SUMA = 297,
     OP_RESTA = 298,
     OP_MOD = 299
   };
#endif
/* Tokens.  */
#define CTE_INT 258
#define CTE_REAL 259
#define CTE_CADENA 260
#define P_COMA 261
#define DECLARACION 262
#define COMA 263
#define C_A 264
#define C_C 265
#define AND 266
#define OR 267
#define NOT 268
#define IGUAL 269
#define DISTINTO 270
#define MAYOR 271
#define MENOR 272
#define MENOR_IGUAL 273
#define MAYOR_IGUAL 274
#define ID 275
#define ASIG 276
#define P_A 277
#define P_C 278
#define ESCRIBIR 279
#define ESCANEAR 280
#define DECVAR 281
#define ENDDEC 282
#define STRING 283
#define CHAR 284
#define INTEGER 285
#define FLOAT 286
#define IF 287
#define ELSE 288
#define WHILE 289
#define START 290
#define END 291
#define IN 292
#define DO 293
#define ENDWHILE 294
#define OP_MULT 295
#define OP_DIV 296
#define OP_SUMA 297
#define OP_RESTA 298
#define OP_MOD 299




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 26 "Sintactico.y"

int intVal;
double realVal;
char *strVal;
char *comp



/* Line 1676 of yacc.c  */
#line 149 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
} YYLTYPE;
# define yyltype YYLTYPE /* obsolescent; will be withdrawn */
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif

extern YYLTYPE yylloc;

