#include <iostream>
#include <vector>
#include <llvm/IR/Value.h>

class CodeGenContext;
class Statement;
class Expression;

typedef std::vector<Statement*> StatementList;

class Root {
public:
	virtual ~Root() {}
	virtual llvm::Value* codeGen(CodeGenContext& context) { return NULL; }
};

class Expression : public Root {
};

class Statement : public Root {
};

class Integer : public Expression {
public:
	int value;
	Integer(long long value) : value(value) { }
	virtual llvm::Value* codeGen(CodeGenContext& context);
};

class Double : public Expression {
public:
	double value;
	Double(double value) : value(value) { }
	virtual llvm::Value* codeGen(CodeGenContext& context);
};

class Identifier : public Expression {
public:
	std::string name;
	Identifier(const std::string& name) : name(name) { }
	virtual llvm::Value* codeGen(CodeGenContext& context);
};


class Block : public Expression {
public:
	StatementList statements;
	Block() { }
	virtual llvm::Value* codeGen(CodeGenContext& context);
};
class VariableDeclaration : public Statement {
public:
	const Identifier& type;
	Identifier& id;
	Expression *assignmentExpr;
	VariableDeclaration(const Identifier& type, Identifier& id) :
		type(type), id(id) { }
	virtual llvm::Value* codeGen(CodeGenContext& context);
};

class VariableAssignment : public Statement {
public: 
		Identifier& lhs;
		Expression&  rhs;
		VariableAssignment(Identifier& lhs, Expression& rhs) :
			lhs(lhs), rhs(rhs) {  }
		virtual llvm::Value* codeGen(CodeGenContext& context);
};
