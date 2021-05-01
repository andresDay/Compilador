c:\GnuWin32\bin\flex Lexico.l
echo "flex lexico.l"
pause
c:\GnuWin32\bin\bison -dyv Sintactico.y
echo "byson Sintactico.y"
pause
c:\MinGW\bin\gcc.exe ./lib/lista_ts.c lex.yy.c y.tab.c -o EntregaUno.exe
echo "gcc EntregaUno.exe"
pause
pause
echo "ejecutar"
EntregaUno.exe prueba.txt
del lex.yy.c
del y.tab.c
del y.output
del y.tab.h
del EntregaUno.exe

pause
