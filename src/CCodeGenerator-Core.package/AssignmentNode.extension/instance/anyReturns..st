*CCodeGenerator-Core
anyReturns: aSequenceOfNodes
	aSequenceOfNodes do:
		[:node|
		node nodesDo:
			[:n|
			n isReturn ifTrue:
				[^true]]].
	^false