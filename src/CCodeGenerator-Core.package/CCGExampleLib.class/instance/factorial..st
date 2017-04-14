as yet unclassified
factorial: anArgument

	^ self ffiCall: #( int factorial (int anArgument) ) module: 'generated.dll'