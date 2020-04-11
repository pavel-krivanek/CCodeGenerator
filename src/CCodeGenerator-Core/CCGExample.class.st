"
Generate the C code into generated.c

| cg |
cg := CCodeGenerator new initialize.
cg vmClass: CCGExample.
cg addClass: CCGExample.
CCGExample exportHeaders.
cg storeCodeOnFile: 'generated.c' doInlining: false.  

Compile it:

gcc -c -m32 generated.c
gcc -shared -m32 -o generated.dll generated.o
 
or: 
 
LibC uniqueInstance system: 'gcc -c -m32 generated.c'.
LibC uniqueInstance system: 'gcc -shared -m32 -o generated.dll generated.o'.

or:
| c | 
c := PipeableOSProcess command: 'gcc -c -m32 generated.c'.
(c output; succeeded)
		ifFalse: [ self error: 'Compilation error: ', c errorPipelineContents printString].
c := PipeableOSProcess command: 'gcc -shared -m32 -o generated.dll generated.o'.
(c output; succeeded)
		ifFalse: [ self error: 'Compilation error', c errorPipelineContents printString].		
				
Try it:

CCGExampleLib uniqueInstance fib4: 30.
CCGExampleLib uniqueInstance factorial: 5.
"
Class {
	#name : #CCGExample,
	#superclass : #VMClass,
	#instVars : [
		'testFailures',
		'aStructure',
		'aStructureCopy'
	],
	#category : 'CCodeGenerator-Core-Examples'
}

{ #category : #'as yet unclassified' }
CCGExample class >> declareCVarsIn: aCCodeGenerator [

	super declareCVarsIn: aCCodeGenerator.

	aCCodeGenerator 
			var: 'aStructure' type: #CCGExampleStruct;
			var: 'aStructureCopy' type: #CCGExampleStructCopy
]

{ #category : #'as yet unclassified' }
CCGExample >> assertTrue: aValue [

	<returnTypeC: #'sqInt'>
	<ignoreForCoverage>	

	aValue == true ifFalse: [ testFailures := testFailures + 1 ].
	
	^ aValue
]

{ #category : #'as yet unclassified' }
CCGExample >> builtInAddressAccess [

	<ignoreForCoverage>	
	<returnTypeC: #'void'>

	<var: #var type: #'int'>

	| var var2  |
	
	var := 42.
	var2 := 1.
	self assertTrue: (self addressOf: var) ~= var.
	
	"addressOf:put: and asAddress:put: seem to generate only pointer access"
	
	

	
]

{ #category : #'as yet unclassified' }
CCGExample >> builtInConditionalControlStructures [

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>
	
	| var result | 
	
	"ifTrue:"
	var := 5.
	result := ((var < 6) ifTrue: [ 42 ]). 	
	self assertTrue: ( result = 42 ).
	(var < 6) ifTrue: [ var := 10 ]. 	
	self assertTrue: ( var = 10 ).

	"ifFalse:"
	var := 5.
	result := ((var > 6) ifFalse: [ 42 ]). 	
	self assertTrue: ( result = 42 ).
	(var > 6) ifFalse: [ var := 10 ]. 	
	self assertTrue: ( var = 10 ).
	
	
	"ifTrue:ifFalse:"
	var := 5.
	result := ((var < 6) ifTrue: [ 42 ] ifFalse: [41]). 	
	self assertTrue: ( result = 42 ).
	(var > 6) ifTrue: [ var := 10 ] ifFalse: [ var := 41 ]. 	
	self assertTrue: ( var = 41 ).

	"ifFalse:ifTrue"
	var := 5.
	result := ((var < 6) ifFalse: [ 42 ] ifTrue: [41]). 	
	self assertTrue: ( result = 41 ).
	(var > 6) ifFalse: [ var := 10 ] ifTrue: [ var := 41 ]. 	
	self assertTrue: ( var = 10 ).

	"ifNotNil:"
	var := 1.
	result := var ifNotNil: [ 42 ]. 	
	self assertTrue: ( result = 42 ).
	var ifNotNil: [ var := 41 ]. 	
	self assertTrue: ( var = 41 ).
	
	"ifNil:"
	var := nil.
	result := var ifNil: [ 42 ]. 	
	self assertTrue: ( result = 42 ).
	var ifNil: [ var := 41 ]. 	
	self assertTrue: ( var = 41 ).

	"ifNotNil:ifNil:"
	var := 1.
	result := var ifNotNil: [ 42 ] ifNil: [41]. 	
	self assertTrue: ( result = 42 ).
	var ifNotNil: [ var := 41 ] ifNil: [ var := 42 ]. 	
	self assertTrue: ( var = 41 ).

	"ifNil:ifNotNil:"
	var := 1.
	result := var ifNil: [ 42 ] ifNotNil: [41]. 	
	self assertTrue: ( result = 41 ).
	var ifNil: [ var := 41 ] ifNotNil: [ var := 42 ]. 	
	self assertTrue: ( var = 42 ).

	
	^ 1

	
]

{ #category : #'as yet unclassified' }
CCGExample >> builtInControlStructures [

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>
	
	| var result | 
	
	"ifTrue:"
	var := 5.
	result := ((var < 6) ifTrue: [ 42 ]). 	
	self assertTrue: ( result = 42 ).
	(var < 6) ifTrue: [ var := 10 ]. 	
	self assertTrue: ( var = 10 ).

	"ifFalse:"
	var := 5.
	result := ((var > 6) ifFalse: [ 42 ]). 	
	self assertTrue: ( result = 42 ).
	(var > 6) ifFalse: [ var := 10 ]. 	
	self assertTrue: ( var = 10 ).
	
	
	"ifTrue:ifFalse:"
	var := 5.
	result := ((var < 6) ifTrue: [ 42 ] ifFalse: [41]). 	
	self assertTrue: ( result = 42 ).
	(var > 6) ifTrue: [ var := 10 ] ifFalse: [ var := 41 ]. 	
	self assertTrue: ( var = 41 ).

	"ifFalse:ifTrue"
	var := 5.
	result := ((var < 6) ifFalse: [ 42 ] ifTrue: [41]). 	
	self assertTrue: ( result = 41 ).
	(var > 6) ifFalse: [ var := 10 ] ifTrue: [ var := 41 ]. 	
	self assertTrue: ( var = 10 ).

	"ifNotNil:"
	var := 1.
	result := var ifNotNil: [ 42 ]. 	
	self assertTrue: ( result = 42 ).
	var ifNotNil: [ var := 41 ]. 	
	self assertTrue: ( var = 41 ).
	
	"ifNil:"
	var := nil.
	result := var ifNil: [ 42 ]. 	
	self assertTrue: ( result = 42 ).
	var ifNil: [ var := 41 ]. 	
	self assertTrue: ( var = 41 ).

	"ifNotNil:ifNil:"
	var := 1.
	result := var ifNotNil: [ 42 ] ifNil: [41]. 	
	self assertTrue: ( result = 42 ).
	var ifNotNil: [ var := 41 ] ifNil: [ var := 42 ]. 	
	self assertTrue: ( var = 41 ).

	"ifNil:ifNotNil:"
	var := 1.
	result := var ifNil: [ 42 ] ifNotNil: [41]. 	
	self assertTrue: ( result = 41 ).
	var ifNil: [ var := 41 ] ifNotNil: [ var := 42 ]. 	
	self assertTrue: ( var = 42 ).

	
	^ 1

	
]

{ #category : #'as yet unclassified' }
CCGExample >> builtInCorece [

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>

	<var: #aChar type: #'signed char'>
	<var: #anInteger type: #'unsigned int'>

	| aChar anInteger |
	
	aChar := 1.
	anInteger := self cCoerce: aChar to: 'unsigned int'. 
	self assertTrue: (anInteger = 1).
	
	aChar := 1.
	anInteger := self cCoerceSimple: aChar to: 'unsigned int'. "there is no difference"
	self assertTrue: (anInteger = 1).	
	
	^ 1

	
]

{ #category : #'as yet unclassified' }
CCGExample >> builtInFunctions [

	<export: true>
	<returnTypeC: #'void'>
	<ignoreForCoverage>	
	
	self builtInFunctionsLogical.
	self builtInFunctionsNumerical.
	self builtInFunctionsComparisons.
	self builtInFunctionsBinary.
	self builtInConditionalControlStructures.
	self builtInLoops.
	self builtInStringAccess.
	self builtInCorece.
	self builtInAddressAccess.
	self builtInFunctionsValueVariants.
	self builtInFunctionsMisc.
		
]

{ #category : #'as yet unclassified' }
CCGExample >> builtInFunctionsBinary [

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>
	
	| var |
				
	self assertTrue: ((2r0101 bitAnd: 2r0011) = 2r0001).
	self assertTrue: ((2r0101 bitOr: 2r0011) = 2r0111).
	self assertTrue: ((2r0101 bitXor: 2r0011) = 2r0110).
	self assertTrue: ((2r0101 bitShift: 2) = 2r10100).
	self assertTrue: ((2r0101 signedBitShift: 2) = 2r10100).
	self assertTrue: ((2r0101 bitInvert32) = 2r11111111111111111111111111111010).
	self assertTrue: ((2r0101 bitInvert64) = 2r1111111111111111111111111111111111111111111111111111111111111010).
	self assertTrue: ((2r0101 truncateTo: 2) = 2r0100).
	 
	var := 7.
	self assert: ((var bitClear: 5) = 2).

	^ 1

	
]

{ #category : #'as yet unclassified' }
CCGExample >> builtInFunctionsComparisons [

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>
				
	self assertTrue: (1 < 2).
	self assertTrue: (1 <= 2).
	self assertTrue: (2 <= 2).
	self assertTrue: (2 = 2).
	self assertTrue: (2 > 1).
	self assertTrue: (2 >= 1).
	self assertTrue: (2 >= 2).
	self assertTrue: (2 ~= 1).
	self assertTrue: (2 == 2).
	self denyTrue: (2 ~~ 2).

	self denyTrue: (1 isNil).
	self assertTrue: (nil isNil).

	self assertTrue: (1 notNil).
	self assertTrue: (nil isNil).

	^ 1

	
]

{ #category : #'as yet unclassified' }
CCGExample >> builtInFunctionsLogical [

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>
		
	| flag var |
	
	self assertTrue: ((true & true) = true).
	self assertTrue: ((true & false) = false).
	self assertTrue: ((false & true) = false).
	self assertTrue: ((false & false) = false).
	
	self assertTrue: ((true | true) = true).
	self assertTrue: ((true | false) = true).
	self assertTrue: ((false | true) = true).
	self assertTrue: ((false | false) = false).
	
	flag := false.
	var := true.
	var := var not.
	self denyTrue: (var and: [flag := true]).
	self denyTrue: (flag).

	flag := false.
	var := true.
	var := var not.
	self assertTrue: (var or: [flag := true]).
	self assertTrue: (flag).

	var := true.
	var := var not.
	self assertTrue: (var = false).

	^ 1
	
]

{ #category : #'as yet unclassified' }
CCGExample >> builtInFunctionsMisc [

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>
	
	| var |

	self touch: var.
	
	self assertTrue: true. "smoke test"

	^ 1
]

{ #category : #'as yet unclassified' }
CCGExample >> builtInFunctionsNumerical [

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>
					
	self assertTrue: (-42 abs = 42).
	self assertTrue: (42 abs = 42).

	self assertTrue: (((1+10-5) negated / -3 // 2 << 8 >> 7)  = 2 ).

	self assertTrue: ((3 + 4) = 7).
	self assertTrue: ((3 - 4) = -1).
	self assertTrue: ((3 * 4) = 12).
	self assertTrue: (3 negated = -3).
	self assertTrue: ((4 // 2) = 2).
	self assertTrue: ((1.0 / 2.0) = 0.5).
	self assertTrue: ((1.0 / 2) = 0.5).
	self assertTrue: ((1 / 2.0) = 0.5).
	self assertTrue: ((10 \\ 3) = 1).

	self assertTrue: ((4 >>> 1) = 2).
	self assertTrue: ((1 >>> 2) = 0).

	self assertTrue: ((0 max: 100) = 100).
	self assertTrue: ((0 max: -100) = 0).

	self assertTrue: ((0 min: 100) = 0).
	self assertTrue: ((0 min: -100) = -100).

	self assertTrue: (2 between: 1 and: 3).

	self assertTrue: ((7 truncateTo: 2) = 6).

	self assertTrue: ((4.2 rounded) = 4).
	self assertTrue: ((4.5 rounded) = 5).

	self assertTrue: ((127 byteSwap32) = 2130706432).
	self assertTrue: ((127 byteSwap64) = 9151314442816847872).
	
	self assertTrue: ((31 allMask: 16) > 0).
	self denyTrue: (65 allMask: 127).
	
	"self assertTrue: (66 anyMask: 127)."
	self denyTrue: (4 anyMask: 2).

	self denyTrue: (65 noMask: 127).
	self assertTrue: (4 noMask: 2).

	self assertTrue: (42 asInteger = 42).
	self assertTrue: (42.7 asInteger = 42).

	self assertTrue: (42 asUnsignedInteger = 42).
	self assertTrue: (42.7 asUnsignedInteger = 42).

	self assertTrue: (42 asLong = 42).
	
	self assertTrue: (42 signedIntFromLong64 = 42).
	self assertTrue: (42 signedIntFromLong = 42).
	self assertTrue: (42 signedIntFromShort = 42).
	self assertTrue: (42 signedIntToLong64 = 42).
	self assertTrue: (42 signedIntToLong = 42).
	self assertTrue: (42 signedIntToShort = 42).



	^ 1

	
]

{ #category : #'as yet unclassified' }
CCGExample >> builtInFunctionsValueVariants [

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>
		
	| var |

	var := 1.
	[ var := var + 2 ] value.	
	self assertTrue: (var = 3).
	
	var := 1.
	[ :x | var := var + x ] value: (var + 20).	
	self assertTrue: (var = 22).

	var := 1.
	[ :x :y | var := var + x + y ] value: (var + 20) value: (var + 30).	
	self assertTrue: (var = 53).

	"var := 1.
	self messageWithBlock: [ var := var + 1 ].
	self assertTrue: (var = 2)."

	^ 1
	
]

{ #category : #'as yet unclassified' }
CCGExample >> builtInLoops [

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>
	
	| var counter | 
	
	"whileTrue:"
	
	var := 5.
	[ var > 0 ] whileTrue: [ var := var - 1 ].
	self assertTrue: ( var = 0 ).

	var := 5.
	counter := 0.
	[ counter := counter + 1. var > 0 ] whileTrue: [ var := var - 1 ].
	self assertTrue: ( var = 0 ).
	self assertTrue: ( counter = 6 ).

	"whileFalse:"
	
	var := 5.
	[ var = 0 ] whileFalse: [ var := var - 1 ].
	self assertTrue: ( var = 0 ).

	var := 5.
	counter := 0.
	[ counter := counter + 1. var = 0 ] whileFalse: [ var := var - 1 ].
	self assertTrue: ( var = 0 ).
	self assertTrue: ( counter = 6 ).

	"whileTrue"
	
	var := 5.
	[ var := var - 1. var > 0 ] whileTrue.
	self assertTrue: ( var = 0 ).

	var := 5.
	[ var := var - 1. var = 0 ifTrue: [false] ifFalse: [ true ] ] whileTrue.
	self assertTrue: ( var = 0 ).
		

	"whileFalse"
	
	var := 5.
	[ var := var - 1. var = 0 ] whileFalse.
	self assertTrue: ( var = 0 ).
	
	"timesRepeat:"
	
	var := 5. "constant, the code will be copied 5-times It cannot be a variable!"
	5 timesRepeat: [ var := var - 1 ].
	self assertTrue: ( var = 0 ).

	self assertTrue: (self repeatTest = 1).

	"to:do:"
	
	var := 0.
	1 to: 10 do: [ :i | var := var + i ]. 
	self assertTrue: (var = 55).

	var := 5.
	counter := var + var.
	1 to: counter do: [ :i | var := var + i ]. 
	self assertTrue: (var = 60).

	"to:by:do:"

	var := 0.
	1 to: 10 by: 2 do: [ :i | var := var + i ]. 
	self assertTrue: (var = 25).

	^ 1

	
]

{ #category : #'as yet unclassified' }
CCGExample >> builtInStringAccess [

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>

	<var: #string1 type: #'char *'>

	| var string1 |
	
	"at:"
	
	var := 'example' at: 2. "zero based index!"
	self assertTrue: (var = 97). "=a"
	
	string1 := 'examples'.	
	var := string1 at: 2.
	self assertTrue: (var = 97).

	string1 := 'examples'.	
	var := string1 basicAt: 2.
	self assertTrue: (var = 97).
	
	^ 1

	
]

{ #category : #'as yet unclassified' }
CCGExample >> denyTrue: aValue [

	<returnTypeC: #'sqInt'>
	<ignoreForCoverage>	

	aValue == true ifTrue: [ testFailures := testFailures + 1 ].
	
	^ aValue
]

{ #category : #'as yet unclassified' }
CCGExample >> doesNotWork [

	<export: true>
	<returnTypeC: #'sqInt'>
	<ignoreForCoverage>	

	| flag alternativeBlock |

	alternativeBlock := [ flag := true ].
	
	self denyTrue: (false and: [ flag := true ]).
	self denyTrue: (flag).
	
	"var := 5. 
	var+1 timesRepeat: [ var := var - 1 ].
	self assertTrue: ( var = 0 )."
	
	"#(1 2 3 4) at: 2."
"	{ 1. 2. 3 } at: 2."
	"array := #[1 2 3]."
	
	"self assertTrue: ((1 / 2) = 0.5)."
	"(3.1479 truncateTo: 0.01) = 3.14"
	"byteSwapped32IfBigEndian:"
	
	"self assertTrue: (66 anyMask: 127). " "- wrong boolean interpretation"

	"var := 1.
	block := [ var := var + 1 ].
	self assertTrue: (var = 2).    - block is always evaluated"
	
	"block value: can be executed only for inline functions, probably"
	
	"	var := 5.
	1 to: (var + var + 10) do: [ :i | var := var + i ].   -- code in #to: section is evaluated everytime
	self assertTrue: (var = 60).
"
	
	^ 0

	
]

{ #category : #'as yet unclassified' }
CCGExample >> factorial: anArgument [

	<export: true>
	<returnTypeC: #'usqInt'>
	<var: #anArgument type: #'usqInt'>
	<ignoreForCoverage>	
	
	| count factorial |
		
	count := anArgument.
	factorial := 1.
	[ count > 0 ] whileTrue: 
		[ factorial := factorial * count.
		count := count - 1 ].
	
	^ factorial
]

{ #category : #'as yet unclassified' }
CCGExample >> fib4: k [

	<export: true>
	<returnTypeC: #'sqInt'>
	<var: #k type: #'sqInt'>
	<ignoreForCoverage>	

	k < 4 
		ifTrue: [ ^ 1 ]
		ifFalse: [ 
			^ (self fib4: k-1) + (self fib4: k-2) + (self fib4: k-3) + (self fib4: k-4) ].
]

{ #category : #helpers }
CCGExample >> messageWithBlock: aBlock [

	<returnTypeC: #'sqInt'>
	<inline: true>

	^ aBlock value.
]

{ #category : #helpers }
CCGExample >> repeatTest [

	| var |
	
	var := 5.
	[ 
		var := var - 1.
		var = 0 ifTrue: [^ 1].
	] repeat.

	^ 0
]

{ #category : #'as yet unclassified' }
CCGExample >> string: anArgument [

	<export: true>
	<returnTypeC: #'char *'>
	<var: #anArgument type: #'char *'>
	<ignoreForCoverage>	

	^ 'result 123'
]

{ #category : #'as yet unclassified' }
CCGExample >> testStructures [

	<returnTypeC: #'void'>
	
	aStructureCopy x: 2.
	aStructureCopy y: 4.
	aStructureCopy z: 6.

	aStructure x: 1.
	aStructure y: 2.
	aStructure z: 3.	
	
	self assertTrue: aStructure sum = 6.	
	
	self assertTrue: aStructureCopy sumCopy = 12.
]

{ #category : #'as yet unclassified' }
CCGExample >> tests [

	<export: true>
	<returnTypeC: #'sqInt'>
	<ignoreForCoverage>	
	
	testFailures := 0.
	
	self builtInFunctions.
	self testStructures.
	
	^ testFailures
		
]

{ #category : #'as yet unclassified' }
CCGExample >> toFloat: anInteger [
	
	<export: true>
	<returnTypeC: #'double'>
	<var: #k type: #'sqInt'>	
	<ignoreForCoverage>	

	^ anInteger asFloat. 
]
