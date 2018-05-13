tests
testGeneration

	| cg |

	CCGExampleLib reset.

	cg := CCodeGenerator new initialize.
	cg vmClass: CCGExample.
	cg addClass: CCGExample.
	cg addClass: CCGExampleStruct.
	CCGExample exportHeaders.

	cg addStructClasses: {CCGExampleStruct}.

	cg storeCodeOnFile: 'generated.c' doInlining: false.  

	self assert: (LibC uniqueInstance system: 'gcc -c -fPIC generated.c') isZero.
	self assert: (LibC uniqueInstance system: 'gcc -shared -o generated.dll generated.o') isZero.

	Smalltalk vm unloadModule: 'generated.dll'.

	self assert: ((CCGExampleLib uniqueInstance fib4: 30) =  90799453).
	self assert: ((CCGExampleLib uniqueInstance factorial: 5) =  120).
	self assert: (CCGExampleLib uniqueInstance builtInFunctions = 0).


