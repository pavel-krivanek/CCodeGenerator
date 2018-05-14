as yet unclassified
denyTrue: aValue

	<returnTypeC: #'sqInt'>
	<ignoreForCoverage>	

	aValue == true ifTrue: [ testFailures := testFailures + 1 ].
	
	^ aValue