%{
#include <stdio.h>
 int nb_ligne = 1;


%token <entier>const_lex aff pvg <str>idf nbrr nbre  <str>float_lex  <str>int_lex <str>bool_lex false_lex true_lex begin_lex end_lex err  add minus mult divi vg equal acolovr 
acolfermt parovt parfrt cndtinst elseinst bigger_lex biggereq_lex less_lex  lessreq_lex noeql_lex bocleinst


%%
S:H  begin_lex  INST end_lex      {printf("syntaxe correct");  YYACCEPT;}

H:C V|V
C:const_lex TC  idf  aff NC pvg C  | const_lex TC aff NC pvg
V: INITV | DCLRV
INITV: TV IDF aff NV pvg  V|TV IDF aff NV pvg 
DCLRV: TV IDF pvg V|TV IDF pvg

IDF: idf vg IDF | idf  

TC: int_lex | float_lex

TV: int_lex | float_lex | bool_lex

NC:nbre |nbrr
NV:nbrr|nbre|BV
BV:false_lex |true_lex 
INST: BOUCLE|COND|AFF 
BOUCLE:FOR INST|FOR
COND:IF INST |IF
AFF:OPT INST | OPT
OPT: idf  aff GP pvg | idf aff NV pvg
GP: idf OPRAT GP|idf
OPRAT: add | minus | mult | divi
IF: cndtinst CONDT acolovr INST acolfermt
CONDT: parovt  OPTL  parfrt 
OPTL: idf OPRL idf |  idf OPRL NV
OPRL:  bigger_lex | biggereq_lex | less_lex | lessreq_lex | noeql_lex
FOR: bocleinst HDFOR acolovr  INST acolfermt
HDFOR: parovt INIT vg OPTL vg OPTE parfrt
INIT: idf aff NC
OPTE: idf OPRAT NC




%%
int main ()
{ int yyparse(); 
int afficher();  }
int yywrap () {};
 void yyerror(char*msg) {
printf("erreur syntaxique à la ligne %d\n",nb_ligne);
}