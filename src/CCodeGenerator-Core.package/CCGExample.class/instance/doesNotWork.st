as yet unclassified
doesNotWork

	<export: true>
	<returnTypeC: #'sqInt'>
	<ignoreForCoverage>	

	| flag alternativeBlock var |

	alternativeBlock := [ flag := true ].
	
	self denyTrue: (false and: [ flag := true ]).
	self denyTrue: (flag).
	
	^ 0

	