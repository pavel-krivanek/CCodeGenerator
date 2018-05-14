as yet unclassified
builtInCorece

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>

	<var: #aChar type: #'signed char'>
	<var: #anInteger type: #'unsigned int'>

	| aChar anInteger |
	
	aChar := 1.
	anInteger := self cCoerce: aChar to: 'unsigned int'. 
	self assertTrue: (anInteger = 1).
	
	aChar := 1.
	anInteger := self cCoerceSimple: aChar to: 'unsigned int'. "there is no difference"
	self assertTrue: (anInteger = 1).	
	
	^ 1

	