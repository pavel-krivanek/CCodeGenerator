as yet unclassified
builtInFunctions

	<export: true>
	<returnTypeC: #'sqInt'>
	<ignoreForCoverage>	
	
	testFailures := 0.
	
	self builtInFunctionsLogical.
	self builtInFunctionsNumerical.
	self builtInFunctionsBinary.
	self builtInConditionalControlStructures.
	self builtInLoops.
	
	^ testFailures
		