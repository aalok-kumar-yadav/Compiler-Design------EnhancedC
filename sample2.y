

%{
void yyerror (char *s);
#include <stdio.h>
#include <stdlib.h>

int symbols[52];
int symbolVal(char symbol);
void updateSymbolVal(char symbol, int val);

FILE *yyin;
int yylex();

%}

%union {int num; char id;} 


%token Add_assign Sub_assign Mul_assign Div_assign Increment Decrement
%token OR AND NOT
%token  LE GE LT GT EE NE
%token Alphabet class include 
%token true_ false_
%token INT CHAR FLOAT LONG DOUBLE BOOLEAN
%token shared
%token WHILE FOR IF ELSE CONTINUE BREAK 
%token RETURN ;
%token NEW;
%token OUTPUT;
%token <num> Digit
%type <num> Arithmetic_Expression term unaryExpression logicalExpression andExpression unaryRelExpression relExpression Expression_Statement   factor Alphabet Variable 

%type <num> modifiable unmodifiable constant Numerical_Constant ID
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
|output_s

;

output_s:OUTPUT '(' ID ')' ';' 
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
|ID '=' Digit {  $1=$3;updateSymbolVal($$,$1);//printf("var_declartion= %c,%d\n",$$,$1);
}
|ID '=' NEW ID '(' ')'
;





Expression_Statement  :logicalExpression  {$$=$1;}
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
| andExpression  {$$=$1;}
;


andExpression : andExpression AND unaryRelExpression
| unaryRelExpression {$$=$1;}
;

unaryRelExpression : NOT  unaryRelExpression 
| relExpression  {$$=$1;}
| true_ 
| false_
;


relExpression : Arithmetic_Expression Relational_Operator  Arithmetic_Expression 
|  Arithmetic_Expression {$$=$1;}
;

 Relational_Operator  :  LE
| LT
| GT 
| GE
| NE 
| EE
;






Arithmetic_Expression  : Arithmetic_Expression  '+'   term  {
$$ = $1 + $3; updateSymbolVal($$,$1 + $3); printf("value = %d \n",symbolVal($3));
}

| Arithmetic_Expression  '-'  term   {$$ = $1 - $3;}
|   term		 {   $$ = $1;
                            //  printf("term_check = %c \n",$1);
					// printf("term_check = %d \n",symbolVal($1));
   }
;


term  :  term  Operator  unaryExpression 
| unaryExpression  {$$=$1;//printf("term = %c ,%d \n",$1,$1);
}
;


Operator : '*' 
| '/' 
| '%'
;


unaryExpression :  '-' factor  
|  '+'factor 
|factor    {
                        $$=$1;}
;



factor : unmodifiable  {$$=$1;}
| modifiable     { $$=symbolVal($1);
		// printf(" factor %d \n",symbolVal($1));		
  }
;


modifiable :  ID  { // printf("modify= %c, mf_val= %d\n",$$,symbolVal($$));
$$=$1;
							}
;

unmodifiable  : constant {$$=$1;}
 |call ';' 
;
call: ID'('Actual_Parameter_List')'| ID'.'ID '(' ')'
;

Actual_Parameter_List : Actual_Parameter_List',' Expression_Statement  |   Actual_Parameter_List',' ID  |   Expression_Statement  |   ID | |
;
 constant : Numerical_Constant {$$=$1;}
;

Numerical_Constant : Digit  {$$ = $1;//printf("num_const=%d\n",$$);
	 	               }
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

ID : Alphabet  {$$ = symbolVal($1); $$=$1; } 
|Alphabet Alphabet_Digit
|Digit {  $$ =$1; // printf("digit check= %d",$$);
} 
;

Alphabet_Digit : Digit 
| Alphabet 
| Digit Alphabet_Digit 
| Alphabet Alphabet_Digit
;

%%
/* computersymbol */

int computeSymbolIndex(char token)
{
	int idx = -1;
	if(islower(token)) {
		idx = token - 'a' + 26;
	} else if(isupper(token)) {
		idx = token - 'A';
	}
	return idx;
} 


/* returns the value of a given symbol */
int symbolVal(char symbol)
{
	int bucket = computeSymbolIndex(symbol);
	return symbols[bucket];
}


/* updates the value of a given symbol */
void updateSymbolVal( char symbol,int val)
{
	int bucket = computeSymbolIndex(symbol);
	symbols[bucket] = val;
//printf(" val= %d\n",val);

}


void yyerror(char* msg)
{
printf("Invalid Expression\n");
}
int main()
{
yyin =fopen("add.eh","r");
/* init symbol table */
int i;
	for(i=0; i<52; i++) {
		symbols[i] = 0;
	}

yyparse();
}


