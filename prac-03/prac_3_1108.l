%{
#include <stdio.h>
int count = 0;
%}

%%

[aA][a-zA-Z]*     { count++; }          // Count word starting with 'a' or 'A'
[^a-zA-Z]+        { /* Skip non-words */ }
[a-zA-Z]+         { /* Skip other words */ }

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter text (Press Ctrl+D to end input):\n");
    yylex();
    printf("\nNumber of words starting with 'a' or 'A': %d\n", count);
    return 0;
}
