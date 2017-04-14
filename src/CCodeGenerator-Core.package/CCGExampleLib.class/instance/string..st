as yet unclassified
string: aString

	^ self ffiCall: #( char *string (char *aString) ) module: 'generated.dll'