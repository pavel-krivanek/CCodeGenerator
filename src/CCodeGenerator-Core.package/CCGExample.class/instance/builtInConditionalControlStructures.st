as yet unclassified
builtInConditionalControlStructures

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

	