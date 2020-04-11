%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>
%}

%token ID NUM
//%token CHAR INT FLOAT DOUBLE
%token TYPE
%token EQ LE GE AND OR ASGN
%token GT LT
%token IF ELSE WHILE CASE SWITCH BREAK
%token ADD SUB MUL DIV 
%token SC COM NL
%token OP CP OB CB

//%start program

%%
S : DEC function {printf("Input accepted\n");exit(0);}
	;
DEC : TYPE VAR SC
	;

VAR: ID
	| ID COM VAR
	;
function: TYPE ID OP ARG CP OB STMT CB
	;
ARG: VAR
	;
STMT: EXPR SC
	;
EXPR: ID ASGN EXPR
	| EXPR ADD EXPR
        | EXPR SUB EXPR
	| EXPR MUL EXPR
	| EXPR DIV EXPR
	| EXPR ADD ADD
        | ADD ADD EXPR
	| EXPR SUB SUB
        | SUB SUB EXPR
	| EXPR ADD ASGN EXPR
	| EXPR SUB ASGN EXPR
	| ID
	| NUM
	;
%%

#include "lex.yy.c"
int main()
{
	yyin=fopen("input.c","r");
	yyparse();
	fclose(yyin);
	return 0;
}

