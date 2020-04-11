%{
    
    #include<stdio.h>
    #include<string.h>
 
    struct symtable{
        char name[100];
        char type[100];
        int len;
    }st[1000];

    struct consttable{
        char name[100];
        char type[100];
        int len;
    }cst[1000];
    

    int build(char *s){
        int mod=100;
        int l=strlen(s),val=0,i;
        for (i=0;i<l;i++){
            val=val*10+(s[i]-'A');
            val=val%mod;
            while(val<0){
                val+=mod;
            }
        }
        return val;
    }

    void symbolAdd(char *arg1,char *arg2){
        
        int l1=strlen(arg1);
        int l2=strlen(arg2);
        int n=build(arg1);
        if(st[n].len==0){
            strcpy(st[n].name,arg1);
            strcpy(st[n].type,arg2);
            
            st[n].len=strlen(arg1);
            return ;
        }

        if(strcmp(st[n].name,arg1)==0)
        return ;

        int i,pos=0;

        for (i=0;i<100;i++){
            if(st[i].len==0){
                pos=i;
                break;
            }
        }

        strcpy(st[pos].name,arg1);
        strcpy(st[pos].type,arg2);
        st[pos].len=strlen(arg1);


    }

    void constAdd(char *arg1,char *arg2){
        
        int l1=strlen(arg1);
        int l2=strlen(arg2);
        int m=build(arg1);
        if(cst[m].len==0){
            strcpy(cst[m].name,arg1);
            strcpy(cst[m].type,arg2);
            
            cst[m].len=strlen(arg1);
            return ;
        }

        if(strcmp(cst[m].name,arg1)==0)
        return ;

        int i,pos=0;

        for (i=0;i<100;i++){
            if(cst[i].len==0){
                pos=i;
                break;
            }
        }

        strcpy(cst[pos].name,arg1);
        strcpy(cst[pos].type,arg2);
        cst[pos].len=strlen(arg1);
    }

    void printSym(){
        int i;

        for ( i=0;i<100;i++){
            if(st[i].len==0){
                continue;
            }

            printf("%s \t %s\n",st[i].name,st[i].type);
        }
    }

    void printCon(){
        int i;

        for ( i=0;i<100;i++){
            if(cst[i].len==0){
                continue;
            }

            printf("%s \t %s\n",cst[i].name,cst[i].type);
        }
    }

%}

LE <=
GE >=
PLUS \+
MIN \-
MULT \*
DIV \/
AND &
OR \|
EQ =
LS <
GR >


%%
[ \n\t] ;
\".*\"|\'.*\' {printf("%s \t\t| String Value\n", yytext);
 constAdd(yytext,"String Vale");}
; {printf("%s \t\t| Semicolon\n", yytext);}
, {printf("%s \t\t| Comma\n", yytext);}
\{ {printf("%s \t\t| Open Brace\n", yytext);}
\} {printf("%s \t\t| Closing Brace\n", yytext);}
\( {printf("%s \t\t| Open Bracket\n", yytext);}
\) {printf("%s \t\t| Close Bracket\n", yytext);}
# {
printf("%s \t\t| Prepros\n", yytext); 
symbolAdd(yytext, "Prepros");
}
\\ {printf("%s \t\t| Escape Slash\n", yytext);}
\. {printf("%s \t\t| Period\n", yytext);}
\/\/.* {printf("%s \t\t| Comment\n", yytext);}

case|char|const|continue|default|do|double|else|float|for|unsigned|void|break|while|main|goto|if|int|long|return|signed|sizeof|static|struct|switch|union {
printf("%s \t\t| Keyword\n", yytext); 
symbolAdd(yytext, "Keyword");
}


[a-z|A-Z]([a-z|A-Z]|[0-9])* {printf("%s \t\t| Identifier\n", yytext); symbolAdd(yytext, "Identifier");}

[1-9][0-9]*|0 {printf("%s \t\t| Numeric\n", yytext); constAdd(yytext, "Numeric");}

{PLUS}|{MIN}|{MULT}|{DIV}|{EQ}|{LE}|{GE}|{LS}|{GR}|{AND}|{OR} {printf("%s \t\t| Operator\n", yytext);} 

(.?) {printf("%s \t\t| Not Recognized\n", yytext);}
%%

int main(){
    int i;
    for (i=0;i<100;i++){
        st[i].len=0;
    }
    yyin=fopen("test.c","r");
    yylex();
    printf("\n\nSymbol table\n\n");
    
    printSym();

    printf("\n\nConstan tabl\n\n");
    printCon();
}

int yywrap(){
    return 1;
}
