as yet unclassified
builtInFunctionsLogical

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
	