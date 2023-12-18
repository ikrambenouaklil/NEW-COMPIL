flex prj.l
bison -d prj.y
gcc lex.yy.c prj2.tab.c  -lfl -ly   -o prj.exe 
prj.exe < prj.txt