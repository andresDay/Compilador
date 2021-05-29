factor_mod --> id {p_f_mod = crear_hoja(id)}
factor_mod --> CTE_INT {p_f_mod = crear_hoja(CTE_INT)}
factor_mod --> CTE_REAL {p_f_mod = crear_hoja(CTE_REAL)}
factor_mod --> P_A expresion P_C {p_f_mod = p_exp}
factor --> factor_mod {p_f = p_f_mod}
factor --> factor OP_MOD factor_mod {p_f = crear_nodo(OP_MOD, p_f, p_f_mod)}
termino --> factor {p_term = p_f}
termino --> termino OP_DIV factor {p_term = crear_nodo(OP_DIV, p_term, p_f)}
termino --> termino OP_MULT factor {p_term = crear_nodo(OP_MULT, p_term, p_f)}
expresion --> termino {p_exp = p_term}
expresion --> expresion OP_RESTA termino {p_exp = crear_nodo(OP_RESTA, p_exp, p_term)}
expresion --> expresion OP_SUMA termino {p_exp = crear_nodo(OP_SUMA, p_exp, p_term)}
asignacion --> ID ASIG CTE_CADENA P_COMA {p_asig = crear_nodo(ASIG, crear_hoja(ID), crear_hoja(CTE_CADENA))}
asignacion --> ID ASIG expresion P_COMA {p_asig = crear_nodo(ASIG, crear_hoja(ID), p_exp)}
condicion --> expresion {p_aux = p_exp} DISTINTO expresion {p_cond = crear_nodo(DISTINTO, p_aux, p_exp)}
condicion --> expresion {p_aux = p_exp} IGUAL expresion {p_cond = crear_nodo(IGUAL, p_aux, p_exp)}
condicion --> expresion {p_aux = p_exp} MENOR_IGUAL expresion {p_cond = crear_nodo(MENOR_IGUAL, p_aux, p_exp)}
condicion --> expresion {p_aux = p_exp} MAYOR_IGUAL expresion {p_cond = crear_nodo(MAYOR_IGUAL, p_aux, p_exp)}
condicion --> expresion {p_aux = p_exp} MENOR expresion {p_cond = crear_nodo(MENOR, p_aux, p_exp)}
condicion --> expresion {p_aux = p_exp} MAYOR expresion {p_cond = crear_nodo(MAYOR, p_aux, p_exp)}
condicion_mul --> condicion {p_cond_mul = p_cond}
condicion_mul --> NOT condicion {p_cond_mul = crear_nodo(NOT, p_cond, null)}
condicion_mul --> condicion {p_aux = p_cond} OR condicion {p_cond_mul = crear_nodo(OR, p_aux, p_cond)}
condicion_mul --> condicion {p_aux = p_cond} AND condicion {p_cond_mul = crear_nodo(AND, p_aux, p_cond)}
// seleccion --> IF P_A condicion_mul P_C START bloque END ELSE START bloque END
// seleccion --> IF P_A condicion_mul P_C START bloque END
funcion --> ESCANEAR ID P_COMA {p_func = crear_nodo(ESCANEAR, crear_hoja(ID), null)}
funcion --> ESCRIBIR ID P_COMA {p_func = crear_nodo(ESCRIBIR, crear_hoja(CTE_CADENA), null)}
funcion --> ESCRIBIR factor_mod P_COMA {p_func = crear_nodo(ESCRIBIR, p_f_mod, null)}
sentencia --> funcion {p_sent = p_func}
sentencia --> seleccion {p_sent = p_sel}
sentencia --> asignacion {p_sent = p_asig}
sentencia --> ciclo_especial {p_sent = p_ce}
sentencia --> ciclo {p_sent = p_c}
bloque --> bloque {p_aux = p_blo} sentencia {p_blo = crear_nodo(p_aux, p_sent, null)}
bloque --> sentencia {p_blo = p_sent}
programa --> bloque {p_prog = p_blo}
// tipodato --> STRING {p_tdato = crear_hoja(STRING)}
// tipodato --> CHAR {p_tdato = crear_hoja(CHAR)}
// tipodato --> INTEGER {p_tdato = crear_hoja(INTEGER)}
// tipodato --> FLOAT {p_tdato = crear_hoja(FLOAT)}
lista_de_variables --> lista_de_variables COMA ID {p_l_var = crear_nodo(COMA, p_l_var, crear_hoja(ID))}
lista_de_variables --> ID {p_l_var = crear_hoja(ID)}
declaraciones --> lista_de_variables DECLARACION tipodato P_COMA {p_dec = crear_nodo(DECLARACION, p_l_var, p_tdato)}
bloque_declaraciones --> bloque_declaraciones declaraciones {p_blo_dec = crear_nodo(p_blo_dec, p_dec, null)}
bloque_declaraciones --> declaraciones {p_blo_dec = p_dec}
inicio --> programa {p_ini = p_prog}
inicio --> DECVAR bloque_declaraciones ENDDEC programa {p_prog = crear_nodo(p_prog, p_blo_dec, null)}
inicio_prima --> inicio {p_ini_pri = p_ini}
// ciclo --> WHILE P_A condicion_mul P_C START bloque END
// ciclo_especial --> WHILE ID IN C_A lista_de_expresiones C_C DO bloque ENDWHILE
lista_de_expresiones --> lista_de_expresiones COMA expresion {p_l_exp = crear_nodo(COMA, p_l_exp, p_exp)}
lista_de_expresiones --> expresion {p_l_exp = p_exp}


*Preguntar por dónde meter ; en el código intermedio
*Preguntar por número enteros en el tp
*Preguntar por cómo interpretar el "NOT condición" en el árbol
*Preguntar por cómo interpretar la regla "bloque --> bloque sentencia" en el árbol
*Preguntar por cómo interpretar la regla "inicio --> DECVAR bloque_declaraciones ENDDEC programa" en el árbol
*Preguntar por error "condicion no tiene tipo declarado"
*Preguntar por corrección del método "ESCRIBIR", a qué cte se refiere que imprimamos.