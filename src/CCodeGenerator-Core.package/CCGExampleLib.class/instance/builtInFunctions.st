as yet unclassified
builtInFunctions 

	^ self ffiCall: #( int builtInFunctions ( ) ) module: 'generated.dll'