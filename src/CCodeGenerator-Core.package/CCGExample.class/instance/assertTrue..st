as yet unclassified
assertTrue: aValue

	<returnTypeC: #'sqInt'>
	<ignoreForCoverage>	

	aValue == true ifFalse: [ testFailures := testFailures + 1 ].
	
	^ aValue