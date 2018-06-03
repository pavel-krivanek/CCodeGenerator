as yet unclassified
builtInFunctionsValueVariants

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
	