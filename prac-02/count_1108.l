%{
#include <stdio.h>

int lc = 0;
int sc = 0;
int cmnt = 0;
int kw = 0;
int id = 0;
int wc = 0;
int tc = 0;
%}

%%

"/*"([^*]|\*+[^*/])*\*+"/"     { cmnt++; }

"int"|"float"|"char"|"if"|"else"|"while"|"for"|"return"|"void"|"do"|"main"|"break"|"continue"  {
                                kw++;
                                wc++;
                             }
\t	{tc++; }

[a-zA-Z_][a-zA-Z0-9_]*         {
                                id++;
                                wc++;
                             }
[ \t]+                        { sc += yyleng; }
\n                            { lc++; }


%%

int main() {
    printf("Enter a sentence: (press ctrl+d to end)");
    yylex();
    printf("\n--- Result ---\n");
    printf("Lines: %d\n", lc);
    printf("Spaces: %d\n", sc);
    printf("Comments: %d\n", cmnt);
    printf("Keywords: %d\n", kw);
    printf("Identifiers: %d\n", id);
    printf("Words: %d\n", wc);
    printf("Tab count: %d\n", tc);
    return 0;
}

int yywrap() {
    return 1;
}

