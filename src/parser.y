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
	VariableAssignment *var_ass; 
	VariableInitial *var_init;
	Integer *ints;
	Double *doubles;
	Loop *loop;
	std::string *string;
	int token;
}

/* Terminals */
%token <string> TIDENTIFIER TINTEGER TDOUBLE
%token <token> TEXCL TTYPE TEQUAL TSET TASS TLOOP
%token <token> TLC TRC TLB TRB 
/* attach syntax to semantics*/ 

%type <ints> ints
%type <doubles> doubles
%type <ident> ident
%type <block> root stmts
%type <stmt> stmt var_decl var_ass var_init loop
%type <expr> num
%start root

%%

root : stmts { rootBlock = $1; }
	 ;
		
stmts : stmt TEXCL { $$ = new Block(); $$->statements.push_back($<stmt>1); }
	  | stmts stmt TEXCL { $1->statements.push_back($<stmt>2); }
	  ;

stmt : var_decl
	 | var_ass 
	 | var_init
	 | loop
     ;

var_decl : TSET ident TTYPE ident  { $$ = new VariableDeclaration(*$4, *$2); }
		 ;

var_ass : ident TASS num { $$ = new VariableAssignment(*$<ident>1, *$3) } 
		;

var_init : TSET ident TTYPE ident TASS num { $$ = new VariableInitial(*$4, *$2, *$6)}
		 ;

loop : TLOOP TLB ints TRB TLC stmts TRC {$$ = new Loop(*$3,*$6)}
	 ;
ident : TIDENTIFIER { $$ = new Identifier(*$1); delete $1; }
	  ;
num : ints | doubles
	;

ints : TINTEGER { $$ = new Integer(atol($1->c_str())); delete $1 } //convert the current value "str" to "int" 
	;

doubles : TDOUBLE { $$ = new Double(atof($1->c_str())); delete $1 } //same as the last one but to double 
	;

%%
