%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "prj.tab.h" 
extern int nb_ligne =1 ;
%}

idf_lex [A-Za-z]([A-Za-z0-9_])*
nbre_lex -?[0-9]+
nbrr_lex -?[0-9]+\.[0-9]+
comment  \{[^}]*\}

%%

CONST    {return const_lex; }
:=       { return aff; }
;        { return pvg; }
","      { return vg; }
INT      { return int_lex; }
FLOAT    { return float_lex; }
BOOL     {return bool_lex; }
FALSE    { return false_lex; }
TRUE     { return true_lex; }
BEGIN    { return begin_lex; }
END      { return end_lex; }
"+"      { return add; }
"-"      { return minus; }
"*"      { return mult; }
"/"      { return divi; }
"=="     { return equal; }
"{"      { return acolovr; }
"}"      { return acolfermt; }
"("      { return parovt; }
")"      { return parfrt; }
if       { return cndtinst; }
else     { return elseinst; }
">"      { return bigger_lex; }
">="     { return biggereq_lex; }
"<"      { return less_lex; }
"<="     { return lessreq_lex; }
"<>"     { return noeql_lex; }
for      { return bocleinst; }

\n { nb_ligne++; }

[ \t] {
    // Ignorer les espaces et les tabulations
}

{comment} {
    // Ignorer les commentaires
    nb_ligne++;
}

{idf_lex} {
    if (yyleng > 10) {
        printf("Erreur lexicale à la ligne %d : L'identificateur est trop long\n", nb_ligne);
    }
    return idf;
}

{nbre_lex} {
    return nbre;
}

{nbrr_lex} {
    return nbrr;
}

. {
    printf("Erreur lexicale à la ligne %d : Caractère non reconnu '%s'\n", nb_ligne, yytext);
}


    
