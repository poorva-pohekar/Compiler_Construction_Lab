%{
#include <stdio.h>
int ln=0;
%}

%%
.*com$   { ln++; printf("Matched line: %d %s",ln, yytext); }
.*      
%%

int main() {
    printf("Enter text here: \n");
    yylex();
    return 0;
}
int yywrap() {
    return 1;
}

