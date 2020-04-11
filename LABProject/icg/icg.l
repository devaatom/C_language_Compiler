ALPHA [A-Za-z]
DIGIT [0-9]
%%
[\n \t] ;
{ALPHA}({ALPHA}|{DIGIT})* return ID;
{DIGIT}+ {yylval=atoi(yytext); return NUM;}
. return yytext[0];
%%
