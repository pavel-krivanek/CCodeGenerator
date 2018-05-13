as yet unclassified
tests

	<export: true>
	<returnTypeC: #'sqInt'>
	<ignoreForCoverage>	
	
	testFailures := 0.
	
	self builtInFunctions.
	self testStructures.
	
	^ testFailures
		