tests
testGeneration

	| cg architecture |

	architecture := Smalltalk vm is64bit 
		ifTrue: [ '-m64' ]
		ifFalse: [ '-m32' ].

	CCGExampleLib reset.

	cg := CCodeGenerator new initialize.
	cg vmClass: CCGExample.

	cg addClass: CCGExample.
	CCGExample exportHeaders.

	cg addClass: CCGExampleStruct.
	cg addClass: CCGExampleStructCopy.
	cg addStructClasses: {CCGExampleStruct. CCGExampleStructCopy  }.

	cg storeCodeOnFile: 'generated.c' doInlining: false.  

	self assert: (LibC uniqueInstance system: ('gcc -c {1} -fPIC generated.c' format: { architecture })) isZero.
	self assert: (LibC uniqueInstance system: ('gcc -shared {1} -o generated.dll generated.o' format: { architecture })) isZero.

	Smalltalk vm unloadModule: 'generated.dll'.

	self assert: ((CCGExampleLib uniqueInstance fib4: 30) =  90799453).
	self assert: ((CCGExampleLib uniqueInstance factorial: 5) =  120).
	self assert: (CCGExampleLib uniqueInstance tests = 0).


