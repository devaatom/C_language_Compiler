%token ID NUM
%right '='
%left '+' '-'
%left '*' '/'
%left UMINUS
%%

S : ID  {push();} '='{push();} E{assignTemp();}
   ;
E : E '+'{push();} T{icgen();}
   | E '-'{push();} T{icgen();}
   | T
   ;
T : T '*'{push();} F{icgen();}
   | T '/'{push();} F{icgen();}
   | F
   ;
F : '(' E ')'
   | '-'{push();} F{genNeg();} %prec UMINUS
   | ID{push();}
   | NUM{push();}
   ;
%%

#include "lex.yy.c"
#include<ctype.h>
char st[100][10];
int top=0;
char i_[2]="0";
char temp[2]="t";



push()
{
  strcpy(st[++top],yytext);
 }

icgen()
 {
 strcpy(temp,"t");
 strcat(temp,i_);
  printf("%s = %s %s %s\n",temp,st[top-2],st[top-1],st[top]);
  top-=2;
 strcpy(st[top],temp);
 i_[0]++;
 }

genNeg()
 {
 strcpy(temp,"t");
 strcat(temp,i_);
 printf("%s = -%s\n",temp,st[top]);
 top--;
 strcpy(st[top],temp);
 i_[0]++;
 }

assignTemp()
 {
 printf("%s = %s\n",st[top-2],st[top]);
 top-=2;
 }
void main()
 {
	yyin=fopen("input1.c","r");
	yyparse();
	fclose(yyin);
 }
