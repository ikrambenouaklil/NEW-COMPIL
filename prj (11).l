%{
#include "prj.tab.h" 
#include <stdbool.h>
extern  int nb_ligne ;



%}
idf_lex [A-Z]"_"?[a-zA-Z0-9]*
nbre_lex "-"?[0-9]+
nbrr_lex "-"?[0-9]+\.[0-9]+
comment  "\{[^}]\}"
%%
CONST   {yylval.entier=atoi(yytext);return const_lex; }
:=       {return aff;}
;       {return pvg;} 
","       return vg;
INT      { yylval.str=strdup("Entier");return int_lex;} ;
FLOAT    {yylval.str=strdup("Reel");return float_lex;};
BOOL     {yylval.str=strdup("Boolean");return bool_lex;};
FALSE      {return false_lex;}; 
TRUE       {return true_lex;}; 
BEGIN return begin_lex ;
END return end_lex ;
"+" return add;
"-" return minus;
 "*" return mult;
"/" return divi;
== return equal; 
 "{" return acolovr; 
 "}" return acolfermt;
 "(" return parovt;
  ")" return parfrt;
  If return cndtinst;
  else return elseinst;
  ">" return bigger_lex ;
   ">=" return biggereq_lex;
   "<" return less_lex ;
   "<=" return lessreq_lex;
   "<>" return noeql_lex;
For return bocleinst;
{idf_lex}  {  if (yyleng>10) printf("erreur lexical a la ligne %d\n ce identificateur est tres long",nb_ligne);
            };
{nbre_lex}   {return nbre;}; 
{nbrr_lex}   {return nbrr; };
[  \t]
comment
[\n]  {nb_ligne++;};
.   {printf("erreur lexical dans la ligne %d \n dans l'entite %s",nb_ligne , yytext); return err;}