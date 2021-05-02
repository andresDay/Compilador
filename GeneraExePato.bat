D:\LYC\GnuWin32\bin\flex Lexico.l
pause
D:\LYC\GnuWin32\bin\bison -dyv Sintactico.y
pause
D:\LYC\MinGW\bin\gcc.exe ./lib/utils.c ./lib/lista_ts.c lex.yy.c y.tab.c -o EntregaUno.exe
pause
pause
EntregaUno.exe prueba.txt
del lex.yy.c
del y.tab.c
del y.output
del y.tab.h
del EntregaUno.exe

pause
