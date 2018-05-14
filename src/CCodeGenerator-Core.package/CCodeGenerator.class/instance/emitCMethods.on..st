C code generator
emitCMethods: methodList on: aStream
	'Writing Translated Code...'
		displayProgressFrom: 0 to: methods size
		during:
			[:bar |
			methodList doWithIndex:
				[ :m :i |
				bar value: i.
				(m isRealMethod
				 and: [self shouldGenerateMethod: m]) ifTrue:
					[m emitCCodeOn: aStream generator: self]]]