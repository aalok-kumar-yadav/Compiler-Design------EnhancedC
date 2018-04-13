%{
#include "y.tab.h"

%}
digit [0-9]

%%
[ ]      ;
[\t]     ;                                   
[\n]    {yylineno = yylineno + yylineno;}  // FOR NEW LINE  
[a-zA-Z] {yylval.id = yytext[0]; return Alphabet;}

{digit}	  {yylval.num = atoi(yytext); return Digit;}
class  { return class;}

include { return include;}



";"        {return (';');}

","        {return (',');}

("{"|"<%")   {return ('{');}

("}"|"%>")   {return ('}');}

"("          {return ('(');}
")"          {return (')');} 

"+="        {return (Add_assign);}
"-="      {return(Sub_assign);}
"*="       {return(Mul_assign);}
"/="       {return (Div_assign);}

"++"       {return(Increment);}
"--"      {return(Decrement);}

"||"       {return(OR);}

"&&"        {return(AND);}

"!"          {return(NOT);}



"<="        {return(LE);}

">="       {return (GE);}

"<"        {return(LT);}

">"          {return(GT);}

"=="        {return(EE);}
"!="         {return(NE);}

"true"      {return(true_);}

"false"      {return(false_);}


"+"          {return('+');}

"-"	     {return('-');}

"*"	     {return('*');}

"/"	     {return('/');}	

"="          {return('=');}


"."           {return ('.');}

"for"        {return FOR;}

"while"      {return(WHILE);}

"if"          {return(IF);}

"else"        {return(ELSE);}

"break"       {return(BREAK);}
"continue"     {return(CONTINUE);}
              


int       {return INT;}
float      {return FLOAT;}   
boolean    {return BOOLEAN;}
char        {return CHAR;}
double       {return DOUBLE;}
long        {return LONG;}

shared    {return shared;}

return   {return RETURN;}

new       {return NEW;}
output  {return OUTPUT;   }

%%

int yywrap()
{
  return 1;
}
