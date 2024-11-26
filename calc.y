%{
#include <math.h>
#include <stdio.h>

int yylex();
extern int yylineno;
void yyerror(const char* msg);

double total = 0;
double memory = 0;
%}

%union {
    double fVal;
}

%error-verbose
%start program

%token CLR_OP
%token EQL_OP
%token ADD_OP
%token SUB_OP
%token MUL_OP
%token DIV_OP
%token POW_OP
%token NUMBER
%type<fVal> NUMBER expr
%token MEM_STORE_OP
%token MEM_CLEAR_OP
%token MEM_RECALL_OP

%%
program:	expr_list 
    ;
expr_list:  expr 		
	|	expr expr_list	
	;
expr:   CLR_OP              { total = 0; memory =0; }
	|   EQL_OP              { printf("%f\n", total); }
	|   ADD_OP NUMBER       { total += $2; }
	|	SUB_OP NUMBER		{ total -= $2; }
	|	MUL_OP NUMBER		{ total *= $2; }
	|	DIV_OP NUMBER		{
								if($2 == 0){
									printf("Error: Cannot divide by zero.\n");
								} else{
									total /= $2;
								}
							}
	|	POW_OP NUMBER		{ total = pow(total, $2); }
	|	MEM_STORE_OP		{ memory = total; }
	|	MEM_CLEAR_OP		{ total = 0; memory = 0; }
	|	MEM_RECALL_OP		{ total = memory; }
	;
%%

void yyerror(const char* msg){
	fprintf(stderr, "Error on line %d.\n%s\n", yylineno, msg);
}

int main(int argc, char** argv){
	yyparse();
}
