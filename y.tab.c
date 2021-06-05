
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C
   
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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.4.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1

/* Using locations.  */
#define YYLSP_NEEDED 1



/* Copy the first part of user declarations.  */

/* Line 189 of yacc.c  */
#line 1 "Sintactico.y"

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



/* Line 189 of yacc.c  */
#line 96 "y.tab.c"

/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif


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

/* Line 214 of yacc.c  */
#line 24 "Sintactico.y"

int intVal;
double realVal;
char *strVal;
char *comp



/* Line 214 of yacc.c  */
#line 229 "y.tab.c"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

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


/* Copy the second part of user declarations.  */


/* Line 264 of yacc.c  */
#line 254 "y.tab.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int yyi)
#else
static int
YYID (yyi)
    int yyi;
#endif
{
  return yyi;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL \
	     && defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
  YYLTYPE yyls_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE) + sizeof (YYLTYPE)) \
      + 2 * YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)				\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack_alloc, Stack, yysize);			\
	Stack = &yyptr->Stack_alloc;					\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  32
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   146

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  45
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  31
/* YYNRULES -- Number of rules.  */
#define YYNRULES  63
/* YYNRULES -- Number of states.  */
#define YYNSTATES  122

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   299

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint8 yyprhs[] =
{
       0,     0,     3,     5,    10,    12,    14,    17,    22,    24,
      28,    30,    32,    34,    36,    38,    40,    43,    45,    47,
      49,    51,    53,    57,    61,    65,    73,    74,    87,    88,
      93,    94,    99,   102,   104,   105,   110,   111,   116,   117,
     122,   123,   128,   129,   134,   135,   140,   145,   150,   154,
     158,   160,   164,   168,   170,   174,   176,   178,   180,   182,
     186,   194,   204,   206
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      46,     0,    -1,    47,    -1,    26,    48,    27,    52,    -1,
      52,    -1,    49,    -1,    48,    49,    -1,    50,     7,    51,
       6,    -1,    20,    -1,    50,     8,    20,    -1,    28,    -1,
      29,    -1,    30,    -1,    31,    -1,    53,    -1,    54,    -1,
      53,    54,    -1,    73,    -1,    74,    -1,    68,    -1,    56,
      -1,    55,    -1,    24,    72,     6,    -1,    24,     5,     6,
      -1,    25,    20,     6,    -1,    32,    22,    58,    23,    35,
      53,    36,    -1,    -1,    32,    22,    58,    23,    35,    53,
      57,    36,    33,    35,    53,    36,    -1,    -1,    61,    59,
      11,    61,    -1,    -1,    61,    60,    12,    61,    -1,    13,
      61,    -1,    61,    -1,    -1,    69,    62,    16,    69,    -1,
      -1,    69,    63,    17,    69,    -1,    -1,    69,    64,    19,
      69,    -1,    -1,    69,    65,    18,    69,    -1,    -1,    69,
      66,    14,    69,    -1,    -1,    69,    67,    15,    69,    -1,
      20,    21,    69,     6,    -1,    20,    21,     5,     6,    -1,
      69,    42,    70,    -1,    69,    43,    70,    -1,    70,    -1,
      70,    40,    71,    -1,    70,    41,    71,    -1,    71,    -1,
      71,    44,    72,    -1,    72,    -1,    20,    -1,     3,    -1,
       4,    -1,    22,    69,    23,    -1,    34,    22,    58,    23,
      35,    53,    36,    -1,    34,    20,    37,     9,    75,    10,
      38,    53,    39,    -1,    69,    -1,    75,     8,    69,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,    50,    50,    57,    75,    82,    90,   101,   114,   123,
     138,   145,   152,   159,   168,   174,   183,   197,   203,   209,
     215,   221,   228,   240,   254,   268,   281,   280,   304,   303,
     320,   319,   335,   347,   355,   354,   377,   376,   399,   398,
     421,   420,   443,   442,   465,   464,   487,   502,   521,   532,
     543,   550,   561,   572,   578,   589,   595,   604,   613,   625,
     632,   635,   637,   643
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "CTE_INT", "CTE_REAL", "CTE_CADENA",
  "P_COMA", "DECLARACION", "COMA", "C_A", "C_C", "AND", "OR", "NOT",
  "IGUAL", "DISTINTO", "MAYOR", "MENOR", "MENOR_IGUAL", "MAYOR_IGUAL",
  "ID", "ASIG", "P_A", "P_C", "ESCRIBIR", "ESCANEAR", "DECVAR", "ENDDEC",
  "STRING", "CHAR", "INTEGER", "FLOAT", "IF", "ELSE", "WHILE", "START",
  "END", "IN", "DO", "ENDWHILE", "OP_MULT", "OP_DIV", "OP_SUMA",
  "OP_RESTA", "OP_MOD", "$accept", "inicio_prima", "inicio",
  "bloque_declaraciones", "declaraciones", "lista_de_variables",
  "tipodato", "programa", "bloque", "sentencia", "funcion", "seleccion",
  "$@1", "condicion_mul", "$@2", "$@3", "condicion", "$@4", "$@5", "$@6",
  "$@7", "$@8", "$@9", "asignacion", "expresion", "termino", "factor",
  "factor_mod", "ciclo", "ciclo_especial", "lista_de_expresiones", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    45,    46,    47,    47,    48,    48,    49,    50,    50,
      51,    51,    51,    51,    52,    53,    53,    54,    54,    54,
      54,    54,    55,    55,    55,    56,    57,    56,    59,    58,
      60,    58,    58,    58,    62,    61,    63,    61,    64,    61,
      65,    61,    66,    61,    67,    61,    68,    68,    69,    69,
      69,    70,    70,    70,    71,    71,    72,    72,    72,    72,
      73,    74,    75,    75
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     4,     1,     1,     2,     4,     1,     3,
       1,     1,     1,     1,     1,     1,     2,     1,     1,     1,
       1,     1,     3,     3,     3,     7,     0,    12,     0,     4,
       0,     4,     2,     1,     0,     4,     0,     4,     0,     4,
       0,     4,     0,     4,     0,     4,     4,     4,     3,     3,
       1,     3,     3,     1,     3,     1,     1,     1,     1,     3,
       7,     9,     1,     3
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     0,     0,     0,     0,     0,     2,     4,
      14,    15,    21,    20,    19,    17,    18,     0,    57,    58,
       0,    56,     0,     0,     0,     8,     0,     5,     0,     0,
       0,     0,     1,    16,     0,     0,    50,    53,    55,    23,
       0,    22,    24,     0,     6,     0,     0,     0,     0,    28,
      34,     0,     0,    47,    46,     0,     0,     0,     0,     0,
      59,     3,    10,    11,    12,    13,     0,     9,    32,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
      48,    49,    51,    52,    54,     7,     0,     0,     0,     0,
       0,     0,     0,     0,     0,    62,     0,     0,     0,    29,
      31,    35,    37,    39,    41,    43,    45,     0,     0,     0,
      25,     0,    63,     0,    60,     0,     0,     0,    61,     0,
       0,    27
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     7,     8,    26,    27,    28,    66,     9,    10,    11,
      12,    13,   111,    48,    70,    71,    49,    72,    73,    74,
      75,    76,    77,    14,    50,    36,    37,    38,    15,    16,
      96
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -82
static const yytype_int8 yypact[] =
{
      91,    -8,    17,    14,    25,    36,     3,    66,   -82,   -82,
      94,   -82,   -82,   -82,   -82,   -82,   -82,    45,   -82,   -82,
      63,   -82,    48,    77,    80,   -82,    33,   -82,    10,    11,
      42,    11,   -82,   -82,    81,    -2,    23,    46,   -82,   -82,
     -14,   -82,   -82,    94,   -82,    72,    69,    48,    98,     7,
      -7,    86,   104,   -82,   -82,    48,    48,    48,    48,    48,
     -82,   -82,   -82,   -82,   -82,   -82,   123,   -82,   -82,    95,
      93,   119,   116,   117,   114,   118,   121,   122,    48,   103,
      23,    23,    46,    46,   -82,   -82,    94,    48,    48,    48,
      48,    48,    48,    48,    48,    29,    47,    94,    60,   -82,
     -82,    29,    29,    29,    29,    29,    29,    48,   101,    73,
     -82,   105,    29,    94,   -82,   107,    22,   108,   -82,    94,
      88,   -82
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -82,   -82,   -82,   -82,   120,   -82,   -82,    99,   -81,   -10,
     -82,   -82,   -82,   113,   -82,   -82,   -44,   -82,   -82,   -82,
     -82,   -82,   -82,   -82,   -16,   -29,    24,     0,   -82,   -82,
     -82
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -45
static const yytype_int8 yytable[] =
{
      33,    35,    23,    68,    54,    98,    40,   -42,   -44,    60,
     -36,   -40,   -38,    17,    18,    19,   109,    45,    46,   -30,
      18,    19,    20,    30,    47,    31,    80,    81,    55,    56,
     -33,    21,   116,    22,    24,    55,    56,    21,   120,    22,
      55,    56,     1,    99,   100,    25,     2,     3,    18,    19,
      34,    18,    19,    25,     5,   107,     6,   108,    29,    84,
      43,   118,    95,    57,    58,    21,    32,    22,    21,    39,
      22,    55,    56,   101,   102,   103,   104,   105,   106,    51,
       1,    82,    83,    41,     2,     3,    42,    53,    33,    67,
      59,   112,     5,     1,     6,    78,   110,     2,     3,    33,
      62,    63,    64,    65,    87,     5,    33,     6,     1,   114,
      33,     1,     2,     3,     1,     2,     3,     4,     2,     3,
       5,    69,     6,     5,   121,     6,     5,    79,     6,    85,
      86,    88,    89,    91,    90,    93,    92,    94,    97,   113,
     117,   115,    61,   119,    52,     0,    44
};

static const yytype_int8 yycheck[] =
{
      10,    17,     2,    47,     6,    86,    22,    14,    15,    23,
      17,    18,    19,    21,     3,     4,    97,     7,     8,    12,
       3,     4,     5,    20,    13,    22,    55,    56,    42,    43,
      23,    20,   113,    22,    20,    42,    43,    20,   119,    22,
      42,    43,    20,    87,    88,    20,    24,    25,     3,     4,
       5,     3,     4,    20,    32,     8,    34,    10,    22,    59,
      27,    39,    78,    40,    41,    20,     0,    22,    20,     6,
      22,    42,    43,    89,    90,    91,    92,    93,    94,    37,
      20,    57,    58,     6,    24,    25,     6,     6,    98,    20,
      44,   107,    32,    20,    34,     9,    36,    24,    25,   109,
      28,    29,    30,    31,    11,    32,   116,    34,    20,    36,
     120,    20,    24,    25,    20,    24,    25,    26,    24,    25,
      32,    23,    34,    32,    36,    34,    32,    23,    34,     6,
      35,    12,    16,    19,    17,    14,    18,    15,    35,    38,
      33,    36,    43,    35,    31,    -1,    26
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    20,    24,    25,    26,    32,    34,    46,    47,    52,
      53,    54,    55,    56,    68,    73,    74,    21,     3,     4,
       5,    20,    22,    72,    20,    20,    48,    49,    50,    22,
      20,    22,     0,    54,     5,    69,    70,    71,    72,     6,
      69,     6,     6,    27,    49,     7,     8,    13,    58,    61,
      69,    37,    58,     6,     6,    42,    43,    40,    41,    44,
      23,    52,    28,    29,    30,    31,    51,    20,    61,    23,
      59,    60,    62,    63,    64,    65,    66,    67,     9,    23,
      70,    70,    71,    71,    72,     6,    35,    11,    12,    16,
      17,    19,    18,    14,    15,    69,    75,    35,    53,    61,
      61,    69,    69,    69,    69,    69,    69,     8,    10,    53,
      36,    57,    69,    38,    36,    36,    53,    33,    39,    35,
      53,    36
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value, Location); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep, yylocationp)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
    YYLTYPE const * const yylocationp;
#endif
{
  if (!yyvaluep)
    return;
  YYUSE (yylocationp);
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep, yylocationp)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
    YYLTYPE const * const yylocationp;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  YY_LOCATION_PRINT (yyoutput, *yylocationp);
  YYFPRINTF (yyoutput, ": ");
  yy_symbol_value_print (yyoutput, yytype, yyvaluep, yylocationp);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
#else
static void
yy_stack_print (yybottom, yytop)
    yytype_int16 *yybottom;
    yytype_int16 *yytop;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, YYLTYPE *yylsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yylsp, yyrule)
    YYSTYPE *yyvsp;
    YYLTYPE *yylsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       , &(yylsp[(yyi + 1) - (yynrhs)])		       );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, yylsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep, YYLTYPE *yylocationp)
#else
static void
yydestruct (yymsg, yytype, yyvaluep, yylocationp)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
    YYLTYPE *yylocationp;
#endif
{
  YYUSE (yyvaluep);
  YYUSE (yylocationp);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}

/* Prevent warnings from -Wmissing-prototypes.  */
#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */


/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;

/* Location data for the lookahead symbol.  */
YYLTYPE yylloc;

/* Number of syntax errors so far.  */
int yynerrs;



/*-------------------------.
| yyparse or yypush_parse.  |
`-------------------------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{


    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       `yyss': related to states.
       `yyvs': related to semantic values.
       `yyls': related to locations.

       Refer to the stacks thru separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    /* The location stack.  */
    YYLTYPE yylsa[YYINITDEPTH];
    YYLTYPE *yyls;
    YYLTYPE *yylsp;

    /* The locations where the error started and ended.  */
    YYLTYPE yyerror_range[2];

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;
  YYLTYPE yyloc;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N), yylsp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yytoken = 0;
  yyss = yyssa;
  yyvs = yyvsa;
  yyls = yylsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */
  yyssp = yyss;
  yyvsp = yyvs;
  yylsp = yyls;

#if YYLTYPE_IS_TRIVIAL
  /* Initialize the default location before parsing starts.  */
  yylloc.first_line   = yylloc.last_line   = 1;
  yylloc.first_column = yylloc.last_column = 1;
#endif

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;
	YYLTYPE *yyls1 = yyls;

	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),
		    &yyls1, yysize * sizeof (*yylsp),
		    &yystacksize);

	yyls = yyls1;
	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss_alloc, yyss);
	YYSTACK_RELOCATE (yyvs_alloc, yyvs);
	YYSTACK_RELOCATE (yyls_alloc, yyls);
#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;
      yylsp = yyls + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;
  *++yylsp = yylloc;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];

  /* Default location.  */
  YYLLOC_DEFAULT (yyloc, (yylsp - yylen), yylen);
  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:

/* Line 1455 of yacc.c  */
#line 50 "Sintactico.y"
    {
        printf("inicio' ---> inicio \n");

        p_ini_pri = p_ini;
}
    break;

  case 3:

/* Line 1455 of yacc.c  */
#line 58 "Sintactico.y"
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
    break;

  case 4:

/* Line 1455 of yacc.c  */
#line 76 "Sintactico.y"
    {
        printf("inicio ---> programa \n");

        p_ini = p_prog;
}
    break;

  case 5:

/* Line 1455 of yacc.c  */
#line 83 "Sintactico.y"
    {
        printf("bloque_declaraciones ---> declaraciones\n");
        info->valor = "BLOQUE\nDECLARACIONES";
        info->indice++;
        p_blo_dec = crear_hoja(info, pf);
}
    break;

  case 6:

/* Line 1455 of yacc.c  */
#line 91 "Sintactico.y"
    {
        printf("bloque_declaraciones ---> bloque_declaraciones declaraciones\n");
        // info->valor = "BLOQUE\nDECLARACIONES";
        // info->indice++;
        // p_aux = crear_hoja(info, pf);

        // crear_nodo(p_blo_dec, p_aux, p_dec, pf);
        // p_blo_dec = p_aux;
}
    break;

  case 7:

/* Line 1455 of yacc.c  */
#line 102 "Sintactico.y"
    {
        printf("declaraciones ---> lista_de_variables DECLARACION tipodato P_COMA\n");

        // info->valor = ":";
        // info->indice++;
        // p_oper = crear_hoja(info, pf);

        // crear_nodo(p_l_var, p_oper, p_tdato, pf);
        // p_dec = p_oper;
}
    break;

  case 8:

/* Line 1455 of yacc.c  */
#line 115 "Sintactico.y"
    {
        printf("lista_de_variables ---> ID, %s\n",(yyvsp[(1) - (1)].strVal));

//         info->valor = $1;
//         info->indice++;
//         p_l_var = crear_hoja(info, pf);
}
    break;

  case 9:

/* Line 1455 of yacc.c  */
#line 124 "Sintactico.y"
    {
        printf("lista_de_variables ---> lista_de_variables COMA ID, %s\n", (yyvsp[(3) - (3)].strVal));

        // info->valor = "CUERPO";
        // info->indice++;
        // p_oper = crear_hoja(info, pf);

        // info->valor = $3;
        // info->indice++;
        // crear_nodo(p_l_var, p_oper, crear_hoja(info, pf), pf);
        // p_l_var = p_oper;
}
    break;

  case 10:

/* Line 1455 of yacc.c  */
#line 139 "Sintactico.y"
    {
        // info->valor = "STRING";
        // info->indice++;
        // p_tdato = crear_hoja(info, pf);
}
    break;

  case 11:

/* Line 1455 of yacc.c  */
#line 146 "Sintactico.y"
    {
        // info->valor = "CHAR";
        // info->indice++;
        // p_tdato = crear_hoja(info, pf);
}
    break;

  case 12:

/* Line 1455 of yacc.c  */
#line 153 "Sintactico.y"
    {
        // info->valor = "INTEGER";
        // info->indice++;
        // p_tdato = crear_hoja(info, pf);
}
    break;

  case 13:

/* Line 1455 of yacc.c  */
#line 160 "Sintactico.y"
    {
        // info->valor = "FLOAT";
        // info->indice++;
        // p_tdato = crear_hoja(info, pf);
}
    break;

  case 14:

/* Line 1455 of yacc.c  */
#line 169 "Sintactico.y"
    {
        printf("programa ---> bloque \n");
        p_prog = p_blo;
}
    break;

  case 15:

/* Line 1455 of yacc.c  */
#line 175 "Sintactico.y"
    {
        printf("bloque ---> sentencia \n");
        p_blo = p_sent;

        dato = p_blo;
        apilar(&pila_blo, &dato);
}
    break;

  case 16:

/* Line 1455 of yacc.c  */
#line 184 "Sintactico.y"
    {
        printf("bloque ---> bloque sentencia\n");
        info->valor = "BLOQUE";
        info->indice++;
        p_aux = crear_hoja(info, pf);

        desapilar(&pila_blo, &dato);

        crear_nodo(dato, p_aux, p_sent, pf);
        p_blo = p_aux;
}
    break;

  case 17:

/* Line 1455 of yacc.c  */
#line 198 "Sintactico.y"
    {
        printf("sentencia ---> ciclo \n");
        p_sent = p_c;
}
    break;

  case 18:

/* Line 1455 of yacc.c  */
#line 204 "Sintactico.y"
    {
        printf("sentencia ---> ciclo_especial \n");
        p_sent = p_ce;
}
    break;

  case 19:

/* Line 1455 of yacc.c  */
#line 210 "Sintactico.y"
    {
        printf("sentencia ---> asignacion \n");
        p_sent = p_asig;
}
    break;

  case 20:

/* Line 1455 of yacc.c  */
#line 216 "Sintactico.y"
    {
        printf("sentencia ---> seleccion \n");
        p_sent = p_sel;
}
    break;

  case 21:

/* Line 1455 of yacc.c  */
#line 222 "Sintactico.y"
    {
        printf("sentencia ---> funcion \n");
        p_sent = p_func;
}
    break;

  case 22:

/* Line 1455 of yacc.c  */
#line 229 "Sintactico.y"
    {
        printf("funcion ---> ESCRIBIR P_A factor_mod P_C P_COMA\n");

        info->valor = "WRITE";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(NULL, p_oper, p_f_mod, pf);
        p_func = p_oper;
}
    break;

  case 23:

/* Line 1455 of yacc.c  */
#line 241 "Sintactico.y"
    {
        printf("funcion ---> ESCRIBIR CTE_CADENA P_COMA\n");

        info->valor = "WRITE";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = obtenerStringHoja((yyvsp[(2) - (3)].strVal));
        info->indice++;
        crear_nodo(NULL, p_oper, crear_hoja(info, pf), pf);
        p_func = p_oper;
}
    break;

  case 24:

/* Line 1455 of yacc.c  */
#line 255 "Sintactico.y"
    {
        printf("funcion ---> ESCANEAR P_A ID P_C P_COMA\n");

        info->valor = "READ";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = (yyvsp[(2) - (3)].strVal);
        info->indice++;
        crear_nodo(NULL, p_oper, crear_hoja(info, pf), pf);
        p_func = p_oper;
}
    break;

  case 25:

/* Line 1455 of yacc.c  */
#line 269 "Sintactico.y"
    {
        printf("seleccion ---> IF P_A condicion_mul P_C START bloque END\n");

        info->valor = "IF";
        info->indice++;
        p_aux = crear_hoja(info, pf);

        crear_nodo(p_cond_mul, p_aux, p_blo, pf);
        p_sel = p_aux;
}
    break;

  case 26:

/* Line 1455 of yacc.c  */
#line 281 "Sintactico.y"
    {
        p_aux2 = p_blo;
}
    break;

  case 27:

/* Line 1455 of yacc.c  */
#line 285 "Sintactico.y"
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
    break;

  case 28:

/* Line 1455 of yacc.c  */
#line 304 "Sintactico.y"
    {
        p_aux = p_cond;
}
    break;

  case 29:

/* Line 1455 of yacc.c  */
#line 308 "Sintactico.y"
    {
        printf("condicion_mul ---> condicion AND condicion \n");

        info->valor = "AND";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_aux, p_oper, p_cond, pf);
        p_cond_mul = p_oper;
}
    break;

  case 30:

/* Line 1455 of yacc.c  */
#line 320 "Sintactico.y"
    {
        p_aux = p_cond;
}
    break;

  case 31:

/* Line 1455 of yacc.c  */
#line 324 "Sintactico.y"
    {
        printf("condicion_mul ---> condicion OR condicion \n");

        info->valor = "OR";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_aux, p_oper, p_cond, pf);
        p_cond_mul = p_oper;
}
    break;

  case 32:

/* Line 1455 of yacc.c  */
#line 336 "Sintactico.y"
    {
        printf("condicion_mul ---> NOT condicion \n");

        info->valor = "NOT";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(NULL, p_oper, p_cond, pf);
        p_cond_mul = p_oper;
}
    break;

  case 33:

/* Line 1455 of yacc.c  */
#line 348 "Sintactico.y"
    {
        printf("condicion_mul ---> condicion \n");
        p_cond_mul = p_cond;
}
    break;

  case 34:

/* Line 1455 of yacc.c  */
#line 355 "Sintactico.y"
    {
        info->valor = (yyvsp[(1) - (1)].strVal);
        info->indice++;
        p_aux = crear_hoja(info, pf);
}
    break;

  case 35:

/* Line 1455 of yacc.c  */
#line 361 "Sintactico.y"
    {
        printf("condicion ---> expresion MAYOR expresion \n");

        info->valor = "MAYOR";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = (yyvsp[(3) - (4)].comp);
        info->indice++;
        p_exp = crear_hoja(info, pf);

        crear_nodo(p_aux, p_oper, p_exp, pf);
        p_cond = p_oper;
}
    break;

  case 36:

/* Line 1455 of yacc.c  */
#line 377 "Sintactico.y"
    {
        // info->valor = $1;
        // info->indice++;
        p_aux = p_exp;
}
    break;

  case 37:

/* Line 1455 of yacc.c  */
#line 383 "Sintactico.y"
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
    break;

  case 38:

/* Line 1455 of yacc.c  */
#line 399 "Sintactico.y"
    {
        info->valor = (yyvsp[(1) - (1)].strVal);
        info->indice++;
        p_aux = crear_hoja(info, pf);
}
    break;

  case 39:

/* Line 1455 of yacc.c  */
#line 405 "Sintactico.y"
    {
        printf("condicion ---> expresion MAYOR_IGUAL expresion \n");

        info->valor = "MAYOR O IGUAL";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = (yyvsp[(3) - (4)].comp);
        info->indice++;
        p_exp = crear_hoja(info, pf);

        crear_nodo(p_aux, p_oper, p_exp, pf);
        p_cond = p_oper;
}
    break;

  case 40:

/* Line 1455 of yacc.c  */
#line 421 "Sintactico.y"
    {
        info->valor = (yyvsp[(1) - (1)].strVal);
        info->indice++;
        p_aux = crear_hoja(info, pf);
}
    break;

  case 41:

/* Line 1455 of yacc.c  */
#line 427 "Sintactico.y"
    {
        printf("condicion ---> expresion MENOR_IGUAL expresion \n");

        info->valor = "MENOR O IGUAL";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = (yyvsp[(3) - (4)].comp);
        info->indice++;
        p_exp = crear_hoja(info, pf);

        crear_nodo(p_aux, p_oper, p_exp, pf);
        p_cond = p_oper;
}
    break;

  case 42:

/* Line 1455 of yacc.c  */
#line 443 "Sintactico.y"
    {
        info->valor = (yyvsp[(1) - (1)].strVal);
        info->indice++;
        p_aux = crear_hoja(info, pf);
}
    break;

  case 43:

/* Line 1455 of yacc.c  */
#line 449 "Sintactico.y"
    {
        printf("condicion ---> expresion IGUAL expresion \n");

        info->valor = "IGUAL";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = (yyvsp[(3) - (4)].comp);
        info->indice++;
        p_exp = crear_hoja(info, pf);

        crear_nodo(p_aux, p_oper, p_exp, pf);
        p_cond = p_oper;
}
    break;

  case 44:

/* Line 1455 of yacc.c  */
#line 465 "Sintactico.y"
    {
        info->valor = (yyvsp[(1) - (1)].strVal);
        info->indice++;
        p_aux = crear_hoja(info, pf);
}
    break;

  case 45:

/* Line 1455 of yacc.c  */
#line 471 "Sintactico.y"
    {
        printf("expresion DISTINTO expresion\n");

        info->valor = "DISTINTO";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = (yyvsp[(3) - (4)].comp);
        info->indice++;
        p_exp = crear_hoja(info, pf);

        crear_nodo(p_aux, p_oper, p_exp, pf);
        p_cond = p_oper;
}
    break;

  case 46:

/* Line 1455 of yacc.c  */
#line 488 "Sintactico.y"
    {
        printf("asignacion ---> ID ASIG expresion P_COMA \n");
        info->valor = "ASIG";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = (yyvsp[(1) - (4)].strVal);
        info->indice++;
        p_aux = crear_hoja(info, pf);

        crear_nodo(p_aux, p_oper, p_exp, pf);
        p_asig = p_oper;
}
    break;

  case 47:

/* Line 1455 of yacc.c  */
#line 503 "Sintactico.y"
    {

        printf("asignacion ---> ID ASIG CTE_CADENA P_COMA \n");
        info->valor = (yyvsp[(1) - (4)].strVal);
        info->indice++;
        p_aux = crear_hoja(info, pf);
        
        info->valor = "ASIG";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        info->valor = obtenerStringHoja((yyvsp[(3) - (4)].strVal));
        info->indice++; 
        crear_nodo(p_aux, p_oper, crear_hoja(info, pf), pf);
        p_asig = p_oper;
}
    break;

  case 48:

/* Line 1455 of yacc.c  */
#line 522 "Sintactico.y"
    {
        printf("expresion ---> expresion OP_SUMA termino \n");
        info->valor = "SUMA";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_exp, p_oper, p_term, pf);
        p_exp = p_oper;
}
    break;

  case 49:

/* Line 1455 of yacc.c  */
#line 533 "Sintactico.y"
    {
        printf("expresion ---> expresion OP_RESTA termino \n");
        info->valor = "RESTA";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_exp, p_oper, p_term, pf);
        p_exp = p_oper;
}
    break;

  case 50:

/* Line 1455 of yacc.c  */
#line 544 "Sintactico.y"
    {
        printf("expresion ---> termino \n");
        p_exp = p_term;
}
    break;

  case 51:

/* Line 1455 of yacc.c  */
#line 551 "Sintactico.y"
    {
        printf("termino ---> termino OP_MULT factor \n");
        info->valor = "MULT";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_term, p_oper, p_f, pf);
        p_term = p_oper;
}
    break;

  case 52:

/* Line 1455 of yacc.c  */
#line 562 "Sintactico.y"
    {
        printf("termino ---> termino OP_DIV factor \n");
        info->valor = "DIV";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_term, p_oper, p_f, pf);
        p_term = p_oper;
}
    break;

  case 53:

/* Line 1455 of yacc.c  */
#line 573 "Sintactico.y"
    {
        printf("termino ---> factor \n");
        p_term = p_f;
}
    break;

  case 54:

/* Line 1455 of yacc.c  */
#line 579 "Sintactico.y"
    {
        printf("factor --> factor OP_MOD factor_mod \n");
        info->valor = "MOD";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_f, p_oper, p_f_mod, pf);
        p_f = p_oper;
}
    break;

  case 55:

/* Line 1455 of yacc.c  */
#line 590 "Sintactico.y"
    {
        printf(" factor --> factor_mod \n");
        p_f = p_f_mod;
}
    break;

  case 56:

/* Line 1455 of yacc.c  */
#line 596 "Sintactico.y"
    {
        printf(" factor_mod --> ID \n");
        (yyval.strVal) = (yyvsp[(1) - (1)].strVal);
        info->valor = (yyvsp[(1) - (1)].strVal);
        info->indice++;
        p_f_mod = crear_hoja(info, pf); 
}
    break;

  case 57:

/* Line 1455 of yacc.c  */
#line 605 "Sintactico.y"
    {
        printf(" factor_mod --> CTE_INT \n");
        (yyval.intVal) = (yyvsp[(1) - (1)].intVal);
        itoa((yyvsp[(1) - (1)].intVal), info->valor, 10);
        info->indice++;
        p_f_mod = crear_hoja(info, pf); 
}
    break;

  case 58:

/* Line 1455 of yacc.c  */
#line 614 "Sintactico.y"
    {
        printf(" factor_mod --> CTE_REAL \n");
        (yyval.realVal) = (yyvsp[(1) - (1)].realVal);
        info->valor = (char*)malloc(sizeof(char) * 20);
        info->indice++;

	sprintf(info->valor,"%.10f", (yyvsp[(1) - (1)].realVal));

        p_f_mod = crear_hoja(info, pf); 
}
    break;

  case 59:

/* Line 1455 of yacc.c  */
#line 626 "Sintactico.y"
    {
        printf("factor_mod --> P_A expresion P_C \n");
        // p_f_mod = p_exp;
}
    break;

  case 60:

/* Line 1455 of yacc.c  */
#line 632 "Sintactico.y"
    {printf("ciclo ---> WHILE P_A condicion_mul P_C START bloque END \n");}
    break;

  case 61:

/* Line 1455 of yacc.c  */
#line 635 "Sintactico.y"
    {printf("ciclo_especial ---> WHILE ID IN C_A lista_de_expresiones C_C DO bloque ENDWHILE\n");}
    break;

  case 62:

/* Line 1455 of yacc.c  */
#line 638 "Sintactico.y"
    {
        printf("lista_de_expresiones ---> expresion\n");
        p_l_exp = p_exp;
}
    break;

  case 63:

/* Line 1455 of yacc.c  */
#line 644 "Sintactico.y"
    {
        printf("lista_de_expresiones ---> lista_de_expresiones COMA expresion\n");

        info->valor = "COMA";
        info->indice++;
        p_oper = crear_hoja(info, pf);

        crear_nodo(p_l_exp, p_oper, p_exp, pf);
}
    break;



/* Line 1455 of yacc.c  */
#line 2450 "y.tab.c"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;
  *++yylsp = yyloc;

  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }

  yyerror_range[0] = yylloc;

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval, &yylloc);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  yyerror_range[0] = yylsp[1-yylen];
  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;

      yyerror_range[0] = *yylsp;
      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp, yylsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  *++yyvsp = yylval;

  yyerror_range[1] = yylloc;
  /* Using YYLLOC is tempting, but would change the location of
     the lookahead.  YYLOC is available though.  */
  YYLLOC_DEFAULT (yyloc, (yyerror_range - 1), 2);
  *++yylsp = yyloc;

  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined(yyoverflow) || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval, &yylloc);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp, yylsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}



/* Line 1675 of yacc.c  */
#line 655 "Sintactico.y"



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


