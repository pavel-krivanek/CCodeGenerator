utilities
noteVariableUsageInString: aString
	currentMethod ifNotNil:
		[:m|
		 (Scanner new typedScanTokens: aString) do:
			[:token|
			 (token isString and: [token first isLetter or: [token first == $_]]) ifTrue:
				[m noteUsedVariableName: token]]]