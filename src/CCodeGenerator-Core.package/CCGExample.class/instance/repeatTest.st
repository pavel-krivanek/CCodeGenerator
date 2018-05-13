helpers
repeatTest

	| var |
	
	var := 5.
	[ 
		var := var - 1.
		var = 0 ifTrue: [^ 1].
	] repeat.

	^ 0