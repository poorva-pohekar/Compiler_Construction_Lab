%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%
[a-zA-Z][a-zA-Z0-9]*    { yylval.sval = strdup(yytext); return ID; }
[0-9]+                  { yylval.sval = strdup(yytext); return NUM; }
"="                     { return ASSIGN; }
"+"                     { return PLUS; }
"-"                     { return MINUS; }
"*"                     { return MUL; }
"/"                     { return DIV; }
"("                     { return LPAREN; }
")"                     { return RPAREN; }
[ \t\n]                 ;   /* ignore whitespace */
.                       { return yytext[0]; }
%%

int yywrap() { return 1; }


