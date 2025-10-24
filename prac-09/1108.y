%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%token FOR ID NUMBER ASSIGN LT GT INC DEC LPAREN RPAREN SEMICOLON

%%
program : for_stmt
        ;

for_stmt : FOR LPAREN expr SEMICOLON condition SEMICOLON update RPAREN
         {
            printf("Valid FOR loop syntax.\n");
         }
         ;

expr : ID ASSIGN NUMBER
     ;

condition : ID LT NUMBER
          | ID GT NUMBER
          ;

update : ID INC
       | ID DEC
       | ID ASSIGN ID
       ;
%%
void yyerror(const char *s)
{
    fprintf(stderr, "Error: %s\n", s);
}

int main()
{
    printf("Enter a FOR loop statement:\n");
    yyparse();
    return 0;
}
