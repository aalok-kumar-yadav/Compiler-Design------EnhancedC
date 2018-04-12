

%{
#include <stdio.h>
#include <stdlib.h>
FILE *yyin;
int yylex();

void yyerror(char*);
%}



%token Add_assign Sub_assign Mul_assign Div_assign Increment Decrement
%token OR AND NOT
%token  LE GE LT GT EE NE
%token Alphabet class include Digit  
%token true_ false_
%token INT CHAR FLOAT LONG DOUBLE BOOLEAN
%token shared
%token WHILE FOR IF ELSE CONTINUE BREAK 
%token RETURN ;
%token NEW;

%%

program: start {   printf("parsed successfully\n");}
;
start : DecList 
| IncludeList  DecList 
;

IncludeList :  IncludeList Include_Statement 
| Include_Statement 
;

Include_Statement : include ID ';'  
;

DecList : DecList declaration 
| declaration;

declaration : Class_Declaration  
;

Class_Declaration : class ID '{' inClass_Declaration_list  '}'
;


inClass_Declaration_list :  inClass_Declaration_list inClass_Declaration   
 |inClass_Declaration
;

inClass_Declaration : Class_Variable_Declartion 
| Constructor_Declaration  
|Fun_Declaration

;

Class_Variable_Declartion : shared DataType  Class_Variable_Declartion_list';' 
|   DataType Class_Variable_Declartion_list';'
;



Class_Variable_Declartion_list : Class_Variable_Declartion_list ',' Class_Variable_Declartion_i
|Class_Variable_Declartion_i
; 


Class_Variable_Declartion_i:Variable
;


Local_Variable_Declartion_list:Local_Variable_Declartion_list Local_Variable_Declartion
|Local_Variable_Declartion
;  

Local_Variable_Declartion : DataType Class_Variable_Declartion_list';'

;
Fun_Declaration : DataType ID '(' Formal_Argument_List ')' '{'    Instruction_List  '}' 
;








 Instruction_List :  Instruction_List  Instruction 
 |   Instruction
;


Instruction  : Selection_statement  
| LoopStatement  
| TransferControl_statement  
|Expression_Statement  
| returnStatement
|Local_Variable_Declartion_list

;

returnStatement : RETURN returnList ';'
;
returnList :  returnList ','  returnVal  
|   returnVal
;

returnVal :  Expression_Statement 
;



LoopStatement : WHILE '(' logicalExpression ')' '{'Instruction_List '}'  
 |FOR '(' Assignment_Statement';'  logicalExpression ';' Assignment_Statement   ')' '{' Instruction_List  '}'

;
Selection_statement  :  IF '(' logicalExpression ')' '{'Instruction_List '}' 
|  IF '(' logicalExpression ')' '{'Instruction_List '}' ELSE '{' Instruction_List '}'  

;


TransferControl_statement :  BREAK';' | CONTINUE';'
;



Constructor_Declaration : ID '(' Formal_Argument_List  ')' '{' Assignment_Statement_list '}'
;


Formal_Argument_List : Formal_Argument_List ',' Formal_Argument  
|  Formal_Argument | |
;

Formal_Argument :  DataType ID 
; 


Variable :  ID 
|ID '=' Expression_Statement
|ID '=' NEW ID '(' ')'
;





Expression_Statement  :logicalExpression  
|  Assignment_Statement_list
; 


Assignment_Statement_list: Assignment_Statement';'
;

Assignment_Statement :  modifiable '=' Expression_Statement 
| modifiable  Add_assign  Expression_Statement 
| modifiable  Sub_assign   Expression_Statement    
| modifiable   Mul_assign   Expression_Statement 
| modifiable   Div_assign   Expression_Statement 
| modifiable  Increment   
| modifiable  Decrement|logicalExpression

;


logicalExpression : logicalExpression OR andExpression 
| andExpression
;


andExpression : andExpression AND unaryRelExpression
| unaryRelExpression
;

unaryRelExpression : NOT  unaryRelExpression 
| relExpression 
| true_ 
| false_
;


relExpression : Arithmetic_Expression Relational_Operator  Arithmetic_Expression 
|  Arithmetic_Expression
;

 Relational_Operator  :  LE
| LT
| GT 
| GE
| NE 
| EE
;






Arithmetic_Expression  : Arithmetic_Expression  '+'   term 
| Arithmetic_Expression  '-'  term   
|   term
;


term  :  term  Operator  unaryExpression 
| unaryExpression
;


Operator : '*' 
| '/' 
| '%'
;


unaryExpression :  '-' factor  
|  '+'factor 
|factor
;



factor : unmodifiable 
| modifiable
;


modifiable :  ID 
;

unmodifiable  : constant |call ';'
;
call: ID'('Actual_Parameter_List')'| ID'.'ID '(' ')'
;

Actual_Parameter_List : Actual_Parameter_List',' Expression_Statement  |   Actual_Parameter_List',' ID  |   Expression_Statement  |   ID | |
;
 constant : Numerical_Constant 
;

Numerical_Constant :  Digit
;







 


DataType : BasicType 
| Reference_Type 
;

BasicType : LONG 
| BOOLEAN 
| FLOAT
| DOUBLE 
| CHAR
|INT
;

Reference_Type : ID
;

ID : Alphabet  
|Alphabet Alphabet_Digit
;

Alphabet_Digit : Digit 
| Alphabet 
| Digit Alphabet_Digit 
| Alphabet Alphabet_Digit
;

%%



void yyerror(char* msg)
{
printf("Invalid Expression\n");
}
int main()
{
yyin =fopen("for.eh","r");
yyparse();
}


