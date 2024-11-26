%{
#include "calc.tab.h"
#include <stdlib.h>

// add more operators
// edit regex for floating point and integer number
%}

%option yylineno

%%
C			{ return CLR_OP; }
\+			{ return ADD_OP; }
=			{ return EQL_OP; }
\-          { return SUB_OP; }
\*          { return MUL_OP; }
\/          { return DIV_OP; }
\^          { return POW_OP; }
M           { return MEM_STORE_OP; }
AC          { return MEM_CLEAR_OP; }
R           { return MEM_RECALL_OP; }
[0-9]{1,5}		{ yylval.fVal = atof(yytext); return NUMBER; }
[ \t\n\r]		;
%%

int yywrap() {
    return 1;  // Return 1 to indicate end of input
}
