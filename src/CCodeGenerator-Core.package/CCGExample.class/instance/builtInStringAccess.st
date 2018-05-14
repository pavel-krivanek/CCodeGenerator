as yet unclassified
builtInStringAccess

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>

	<var: #string1 type: #'char *'>

	| var string1 |
	
	"at:"
	
	var := 'example' at: 2. "zero based index!"
	self assertTrue: (var = 97). "=a"
	
	string1 := 'examples'.	
	var := string1 at: 2.
	self assertTrue: (var = 97).

	string1 := 'examples'.	
	var := string1 basicAt: 2.
	self assertTrue: (var = 97).
	
	^ 1

	