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
	
	^ 0

	