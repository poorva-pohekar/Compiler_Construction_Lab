%{
#include "y.tab.h"  // Include the token definitions
%}

%%

[0-9]+              { yylval = atoi(yytext); return NUMBER; }
[ \t\n]+            ;  // Ignore whitespace
"+"                 return PLUS;
"*"                 return MUL;
"("                 return LPAREN;
")"                 return RPAREN;
"/"		    return DIV;
"-" 	 	    return SUB;
"^"		    return EXPO;
.                   return yytext[0];

%%

