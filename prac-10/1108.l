%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);

int tempCount = 0;

char* newTemp() {
    char *temp = malloc(10);
    sprintf(temp, "t%d", tempCount++);
    return temp;
}
%}

%union {
    char *sval;
}

%token <sval> ID NUM
%token ASSIGN PLUS MINUS MUL DIV LPAREN RPAREN
%type <sval> expr

%%

stmt : ID ASSIGN expr
      {
          printf("%s = %s\n", $1, $3);
      }
     ;

expr : expr PLUS expr
      {
          char *t = newTemp();
          printf("%s = %s + %s\n", t, $1, $3);
          $$ = t;
      }
     | expr MINUS expr
      {
          char *t = newTemp();
          printf("%s = %s - %s\n", t, $1, $3);
          $$ = t;
      }
     | expr MUL expr
      {
          char *t = newTemp();
          printf("%s = %s * %s\n", t, $1, $3);
          $$ = t;
      }
     | expr DIV expr
      {
          char *t = newTemp();
          printf("%s = %s / %s\n", t, $1, $3);
          $$ = t;
      }
     | LPAREN expr RPAREN
      {
          $$ = $2;
      }
     | ID
      {
          $$ = $1;
      }
     | NUM
      {
          $$ = $1;
      }
     ;

%%

void yyerror(const char *s)
{
    fprintf(stderr, "Error: %s\n", s);
}

int main()
{
    printf("Enter an arithmetic expression:\n");
    yyparse();
    return 0;
}
//.y code
