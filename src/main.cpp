#include <iostream>
#include "codegen.h"
#include "ast.h"

using namespace std;

extern int yyparse();
extern Block* rootBlock;


int main(int argc, char **argv)
{
	yyparse();
	cout << rootBlock << endl;
	InitializeNativeTarget();
	CodeGenContext context;
	context.generateCode(*rootBlock);
	context.runCode();
	
	return 0;
}

