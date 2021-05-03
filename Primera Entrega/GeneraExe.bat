del Primera.exe

c:\GnuWin32\bin\flex Lexico.l
pause
c:\GnuWin32\bin\bison -dyv Sintactico.y
pause
c:\MinGW\bin\gcc.exe ./lib/utils.c ./lib/lista_ts.c lex.yy.c y.tab.c -o Primera.exe
pause
pause
Primera.exe prueba.txt
del lex.yy.c
del y.tab.c
del y.output
del y.tab.h

pause
