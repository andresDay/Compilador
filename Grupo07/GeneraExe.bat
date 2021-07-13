del Grupo07.exe
c:\GnuWin32\bin\flex Lexico.l
pause
c:\GnuWin32\bin\bison -dyv Sintactico.y 
pause
c:\MinGW\bin\gcc.exe ./lib/assembler.c ./lib/pila.c ./lib/arboles.c ./lib/utils.c ./lib/lista_ts.c lex.yy.c y.tab.c -o Grupo07.exe
pause
pause
Grupo07.exe prueba.txt
echo.
echo -----------------------------------------------------------------
pause
echo Generando grafico del arbol
dot -Tpng arbol.txt -o intermedia.png
echo -----------------------------------------------------------------
pause
del lex.yy.c
del y.tab.c
del y.output
del y.tab.h
del arbol.txt



pause
