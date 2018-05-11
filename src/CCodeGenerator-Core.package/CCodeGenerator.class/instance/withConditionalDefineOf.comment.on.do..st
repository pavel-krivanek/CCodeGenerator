C code generator
withConditionalDefineOf: aConstantNameString comment: commentOrNil on: aStream do: aBlock
	| start |
	aStream nextPutAll: '#if !defined('; nextPutAll: aConstantNameString; nextPut: $).
	commentOrNil ifNotNil: [aStream nextPutAll: ' /* '; nextPutAll: commentOrNil; nextPutAll: ' */'].
	aStream cr.
	start := aStream position.
	aBlock value.
	aStream nextPutAll: '#endif'.
	aStream position - start > 80 ifTrue:
		[aStream nextPutAll: ' /* !defined('; nextPutAll: aConstantNameString; nextPutAll: ') */'].
	aStream cr