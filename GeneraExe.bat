c:\GnuWin32\bin\flex Lexico.l
pause
c:\GnuWin32\bin\bison -dyv Sintactico.y 
pause
c:\MinGW\bin\gcc.exe ./lib/assembler.c ./lib/pila.c ./lib/arboles.c ./lib/utils.c ./lib/lista_ts.c lex.yy.c y.tab.c -o Primera.exe
pause
pause
Primera.exe test.txt
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
@REM del y.tab.h
del Primera.exe



pause
