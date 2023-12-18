%{
#include <stdio.h>

int nb_ligne = 1;

// Placez ici les définitions nécessaires pour vos tokens si vous en avez
// Par exemple : #define const_lex 1
// Assurez-vous de définir tous les tokens utilisés dans vos règles

int yylex(); // Déclaration de la fonction yylex
void yyerror(char *msg); // Déclaration de la fonction d'erreur
int yywrap() { return 1; } // Fonction de fin de fichier
%}

// Déclarations de tokens
%token  const_lex aff pvg idf nbrr nbre float_lex int_lex bool_lex false_lex true_lex begin_lex end_lex err add minus mult divi vg equal acolovr acolfermt parovt parfrt cndtinst elseinst bigger_lex biggereq_lex less_lex lessreq_lex noeql_lex bocleinst

%%

S: H begin_lex INST end_lex { printf("Syntaxe correcte\n"); YYACCEPT; }
;
H: C V | V
;
C: const_lex TC idf aff NC pvg C | const_lex TC aff NC pvg
;
V: INITV | DCLRV
;
INITV: TV idf aff NV pvg V | TV idf aff NV pvg
;
DCLRV: TV IDF pvg V | TV IDF pvg
;
IDF: idf vg IDF | idf
;
TC: int_lex | float_lex
;
TV: int_lex | float_lex | bool_lex
;
NC: nbre | nbrr
;
NV: nbrr | nbre | BV
;
BV: false_lex | true_lex
;
INST: BOUCLE | COND | AFF
;
BOUCLE: FOR INST | FOR
;
COND: IF INST | IF
;
AFF: OPT INST | OPT
;
OPT: idf aff GP pvg | idf aff NV pvg
;
GP: idf OPRAT GP | idf
;
OPRAT: add | minus | mult | divi
;
IF: cndtinst CONDT acolovr INST acolfermt
;
CONDT: parovt OPTL parfrt
;
OPTL: idf OPRL idf | idf OPRL NV
;
OPRL: bigger_lex | biggereq_lex | less_lex | lessreq_lex | noeql_lex
;
FOR: bocleinst HDFOR acolovr INST acolfermt
;
HDFOR: parovt INIT vg OPTL vg OPTE parfrt
;
INIT: idf aff NC
;
OPTE: idf OPRAT NC
;
%%

int main() {
    yyparse(); // Appel à l'analyseur syntaxique
    return 0;
}
void yyerror(char *msg) {
    printf("Erreur syntaxique à la ligne %d : %s\n", nb_ligne, msg);
}


