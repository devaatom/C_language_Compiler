alpha [a-zA-Z]
dig [0-9]
%%

"-" return SUB;
"+" return ADD;
"*" return MUL;
"/" return DIV;

"switch" return SWITCH;
"case" return CASE;
"if" return IF;
"else" return ELSE;
"while" return WHILE;
"break" return BREAK;

"&&" return AND;
"||" return OR;

"char"|"int"|"double"|"float" return TYPE;

">" return GT;
"<" return LT;
">=" return GE;
"<=" return LE;
"==" return EQ;
"=" return ASGN;

{alpha}({alpha}|{dig})* return ID;
{dig}+  return NUM;

";" return SC;
"," return COM;
"(" return OP;
")" return CP;
"{" return OB;
"}" return CB;
. ;
[ \n] return NL;
%%
