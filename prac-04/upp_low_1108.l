%{
#include <stdio.h>
%}

%%

[A-Z]       { putchar(yytext[0] + 32); }  // Uppercase to lowercase
[a-z]       { putchar(yytext[0] - 32); }  // Lowercase to uppercase
.|\n        { ECHO; }                           // Print all other characters as-is

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter text (Press Ctrl+D to end input):\n");
    yylex();
    return 0;
}

