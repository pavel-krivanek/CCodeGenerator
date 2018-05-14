as yet unclassified
builtInAddressAccess

	<ignoreForCoverage>	
	<returnTypeC: #'void'>

	<var: #var type: #'int'>

	| var var2  |
	
	var := 42.
	var2 := 1.
	self assertTrue: (self addressOf: var) ~= var.
	
	"addressOf:put: and asAddress:put: seem to generate only pointer access"
	
	

	