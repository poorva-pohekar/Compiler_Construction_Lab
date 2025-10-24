%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
int res;
%}

%token NUMBER
%token PLUS MULT LPAREN RPAREN DIV SUB EXPO


%left PLUS
%left SUB
%left MUL
%left DIV
%left EXPO

%%

expr:
      expr expr PLUS    { $$ = $1 + $3;res = $$; }
    | expr expr MUL    { $$ = $1 * $3;res = $$; }
    | LPAREN expr RPAREN { $$ = $2;res = $$; }
    | NUMBER            { $$ = $1; }
    | expr expr SUB 	{ $$ = $1 - $3;res = $$; }
    | expr expr DIV	{ $$ = $1 / $3;res = $$; }
    | expr expr EXPO	{ for(int i=0;i< $3;i++) $$=$$ * $1;res = $$; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter an expression:\n");
    if (yyparse() == 0)
        printf("Valid expression.\n");
        printf("Result = %d\n",res);
    return 0;
}

