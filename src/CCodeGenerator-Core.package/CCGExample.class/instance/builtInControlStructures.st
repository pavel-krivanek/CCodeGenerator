as yet unclassified
builtInControlStructures

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
	
	^ 1

	