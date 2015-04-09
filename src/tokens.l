%{
/* C code */
#include <string>
#include "ast.h"
#include "parser.hpp"

#define SAVE_TOKEN  yylval.string = new std::string(yytext, yyleng)
#define TOKEN(t)    (yylval.token = t)
%}

%option noyywrap

%%

[ \t\n]					        ;
"set" 							return TOKEN(TSET);
[a-zA-Z_][a-zA-Z0-9_]*  		SAVE_TOKEN; return TIDENTIFIER;
[0-9]+\.[0-9]* 			    	SAVE_TOKEN; return TDOUBLE;
[0-9]+					        SAVE_TOKEN; return TINTEGER;

"="						        return TOKEN(TEQUAL);
"!" 							return TOKEN(TEXCL);
":" 							return TOKEN(TTYPE);
.                       		printf("Unknown token!\n"); yyterminate();

%%
