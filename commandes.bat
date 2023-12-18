flex prj.l
bison -d prj.y
gcc lex.yy.c prj.tab.c  -lfl -ly   -o prj.exe 
prj.exe < prj.txt