as yet unclassified
doesNotWork

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
	^ 0

	