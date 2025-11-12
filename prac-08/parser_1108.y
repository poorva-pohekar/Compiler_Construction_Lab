%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern int yylex(void);
extern int yylineno;
void yyerror(const char *s);

void print_result(double v) {
    printf("= %.10g\n", v);
}
%}

%union {
    double dval;
}

%token <dval> NUMBER
%left '+' '-'
%left '*' '/'
%right '^'
%right UMINUS
%type <dval> expr

%%

input:
      /* empty */
    | input line
    ;

line:
      '\n'
    | expr '\n'          { print_result($1); }
    | error '\n' {
          fprintf(stderr, "Syntax error on line %d — skipping\n", yylineno);
          yyerrok;
      }
    ;

expr:
      NUMBER             { $$ = $1; }
    | expr '+' expr      { $$ = $1 + $3; }
    | expr '-' expr      { $$ = $1 - $3; }
    | expr '*' expr      { $$ = $1 * $3; }
    | expr '/' expr      { 
                            if ($3 == 0.0) {
                                fprintf(stderr, "Runtime error: division by zero\n");
                                $$ = 0.0;
                            } else $$ = $1 / $3;
                          }
    | expr '^' expr      { $$ = pow($1, $3); }
    | '-' expr %prec UMINUS { $$ = -$2; }
    | '(' expr ')'       { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s (line %d)\n", s, yylineno);
}

int main(void) {
    printf("Desk Calculator (operators: + - * / ^)\n");
    printf("Enter one expression per line, Ctrl+D to quit.\n");
    return yyparse();
}

