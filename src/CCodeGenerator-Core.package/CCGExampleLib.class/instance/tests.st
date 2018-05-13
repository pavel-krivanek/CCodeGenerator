as yet unclassified
tests

	^ self ffiCall: #( int tests ( ) ) module: 'generated.dll'