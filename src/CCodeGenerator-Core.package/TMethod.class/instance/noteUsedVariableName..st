utilities
noteUsedVariableName: token
	usedVariablesCache ifNotNil:
		[usedVariablesCache add: token]