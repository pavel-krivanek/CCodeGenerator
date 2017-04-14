utilities
optionIsTrue: pragma in: aClass

	"Answer whether an option: or notOption: pragma is true in the context of aClass.
	 The argument to the option: pragma is interpreted as either a class name
	 or a class variable name or a variable name in VMBasicConstants."
	
	| key |
	
	key := pragma argumentAt: 1.

	"If the option is one to be defined at compile time we'll generate a
	 conditional around its declaration and definition."
	(VMBasicConstants defineAtCompileTime: key) ifTrue:
		[^true].

	"Lookup options in options, class variables of the defining class, VMBasicConstants etc."
	{aClass initializationOptions. aClass. VMBasicConstants.} do: [:scopeOrNil |
		 scopeOrNil ifNotNil: [:scope|
			 (scope bindingOf: key) ifNotNil: [:binding |
				binding value ~~ false ifTrue: [^true]]]].
	
	^false