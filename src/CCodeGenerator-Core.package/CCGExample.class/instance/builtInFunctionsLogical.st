as yet unclassified
builtInFunctionsLogical

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>
		
	| flag var |
	
	self assert: [ (true & true) = true ].
	self assert: [ (true & false) = false ].
	self assert: [ (false & true) = false ].
	self assert: [ (false & false) = false ].
	
	self assert: [ (true | true) = true ].
	self assert: [ (true | false) = true ].
	self assert: [ (false | true) = true ].
	self assert: [ (false | false) = false ].
	
	flag := false.
	var := true.
	var := var not.
	self deny: (var and: [ flag := true ]).
	self deny: (flag).

	flag := false.
	var := true.
	var := var not.
	self assert: (var or: [ flag := true ]).
	self assert: (flag).

	var := true.
	var := var not.
	self assert: (var = false).

	^ 1
	