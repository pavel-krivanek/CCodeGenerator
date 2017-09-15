C code generator
withOptionalConditionalDefineFor: aTMethod on: aStream do: aBlock
	"Evaluate aBlock, surrounded by an appropriate conditional define added to the stream if required."
	| compileTimeOptionPragmas |
	(compileTimeOptionPragmas := aTMethod compileTimeOptionPragmas) notEmpty ifTrue:
		[aTMethod outputConditionalDefineFor: compileTimeOptionPragmas on: aStream].
	aBlock value.
	aTMethod terminateConditionalDefineFor: compileTimeOptionPragmas on: aStream