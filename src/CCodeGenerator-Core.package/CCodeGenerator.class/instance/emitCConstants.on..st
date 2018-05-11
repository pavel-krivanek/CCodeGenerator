C code generator
emitCConstants: constList on: aStream
	"Store the global variable declarations on the given stream."
	constList isEmpty ifTrue: [^self].
	aStream cr; nextPutAll: '/*** Constants ***/'; cr.
	(self sortStrings: constList) do:
		[:varName| | node default value |
		node := constants at: varName.
		node name isEmpty ifFalse:
			["If the definition includes a C comment, or looks like a conditional, take it as is, otherwise convert
			  the value from Smalltalk to C.
			  Allow the class to provide an alternative definition, either of just the value or the whole shebang."
			default := (node value isString
						and: [(node value includesSubstring: '/*')
								or: [(node value includesSubstring: ' ? ') and: [node value includesSubstring: ' : ']]])
							ifTrue: [node value]
							ifFalse: [self cLiteralFor: node value name: varName].
			default = #undefined
				ifTrue: [aStream nextPutAll: '#undef '; nextPutAll: node name; cr]
				ifFalse:
					[value := vmClass
								ifNotNil:
									[(vmClass specialValueForConstant: node name default: default)
										ifNotNil: [:specialDef| specialDef]
										ifNil: [default]]
								ifNil: [default].
					((vmClass ifNil: VMBasicConstants) defineAtCompileTime: node name)
						ifTrue: [self putConditionalDefineOf: node name
									as: value
									comment: 'Allow this to be overridden on the compiler command line'
									on: aStream]
						ifFalse: [self putDefineOf: node name as: value on: aStream]]]].
	aStream cr