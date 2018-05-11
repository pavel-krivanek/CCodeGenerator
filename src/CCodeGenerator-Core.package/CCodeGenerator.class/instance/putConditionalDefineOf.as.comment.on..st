C code generator
putConditionalDefineOf: aConstantNameString as: valueOrValueString comment: commentOrNil on: aStream
	self withConditionalDefineOf: aConstantNameString
		comment: commentOrNil
		on: aStream
		do: [| valueAsString |
			 valueAsString := valueOrValueString asString.
			 valueAsString first ~= $# ifTrue:
				[aStream nextPutAll: '# define '; nextPutAll: aConstantNameString; space].
			 aStream nextPutAll: valueAsString; cr]