%{
#include "y.tab.h"
#include <stdlib.h>
%}

DIGIT   [0-9]

%%

[ \t\r]+                ;   /* ignore whitespace */

\n                      { return '\n'; }

"+"                     { return '+'; }
"-"                     { return '-'; }
"*"                     { return '*'; }
"/"                     { return '/'; }
"^"                     { return '^'; }
"("                     { return '('; }
")"                     { return ')'; }

{DIGIT}+("."{DIGIT}+)?  {
                          yylval.dval = atof(yytext);
                          return NUMBER;
                        }

.                       { return yytext[0]; }

%%

int yywrap(void) { return 1; }

