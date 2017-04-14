as yet unclassified
doesNotWork

	<export: true>
	<returnTypeC: #'sqInt'>
	<ignoreForCoverage>	

	| flag alternativeBlock |

	alternativeBlock := [ flag := true ].
	
	self deny: (false and: [ flag := true ]).
	self deny: (flag).
	
	^ 0

	