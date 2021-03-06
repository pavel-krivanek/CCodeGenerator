as yet unclassified
builtInLoops

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

	