# whatever #
Simple compiler for a toy language using llvm framework

## Features ##
* Top down parsing using Bison.
* Strictly typed.
* Compiles to LLVM IR code
* Only two builtin datatypes (int and double).
* Weird syntax.
* No functions _yet_
* Casting is not allowed.
* variables are mutable by default
* No comments _yet_

## TODO ##
* ~~Design a weird syntax.~~
* ~~Variables declaration.~~
* ~~Variables assignment.~~
* ~~Variables initialization.~~
* ~~Loops.~~
* Mathematical Expressions.
* Add a builtin print function ex. echo/print.
* Functions.
* Strings are a maybe so far.

## Syntax ##
```whatever
set x : int !  //variable declaration example

x @ 12 ! //variable assignment example 

set x : int @ 12 ! //variable initialization 

loop [12]{  //loop 120 times 

	loop[10]{
		x @ = 11!
	}!
}!
```
## Requirements ##
1. flex
2. bison
3. llvm libraries
4. make 

## Build instructions ##
```bash
git clone https://github.com/OpenSourceZombie/whatever.git
cd whatever/src
make 
#run tests
make test
```

## Why? ##
Because.
