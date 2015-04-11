%{
	#include "ast.h"
    #include <cstdio>
    #include <cstdlib>
	Block *rootBlock; 

	extern int yylex();
	void yyerror(const char *s) { std::printf("Error: %s\n", s);std::exit(1); }
%}

/* Non terminals */
%union {
	Root *root;
	Block *block;
	Expression *expr;
	Statement *stmt;
	Identifier *ident;
	VariableDeclaration *var_decl;
	std::string *string;
	int token;
}

/* Terminals */
%token <string> TIDENTIFIER TINTEGER TDOUBLE
%token <token> TEXCL TTYPE TEQUAL TSET 

/* attach syntax to semantics*/ 

%type <ident> ident
%type <block> root stmts
%type <stmt> stmt var_decl

%start root

%%

root : stmts { rootBlock = $1; }
		;
		
stmts : stmt TEXCL { $$ = new Block(); $$->statements.push_back($<stmt>1); }
	  | stmts stmt TEXCL { $1->statements.push_back($<stmt>2); }
	  ;

stmt : var_decl 
     ;

var_decl : TSET ident TTYPE ident  { $$ = new VariableDeclaration(*$4, *$2); }
		 ;
ident : TIDENTIFIER { $$ = new Identifier(*$1); delete $1; }
	  ;
%%
