utilities
noteUsedVariableName: variableName
	currentMethod ifNotNil:
		[:m| m noteUsedVariableName: variableName]