C code generator
structTargetKindForVariableName: varName "<String>"
	^(self typeOfVariable: varName) ifNotNil:
		[:declaration|
		 self structTargetKindForDeclaration: declaration]