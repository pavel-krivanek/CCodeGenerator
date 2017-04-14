as yet unclassified
builtInFunctionsNumerical

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>
				
	self assert: [ -42 abs = 42 ].
	self assert: [ 42 abs = 42 ].

	self assert: (((1+10-5) negated / -3 // 2 << 8 >> 7)  = 2 ).
	self assert: ((4 >>> 1) = 2).
	self assert: ((1 >>> 2) = 0).

	self assert: ((0 max: 100) = 100).
	self assert: ((0 max: -100) = 0).

	self assert: ((0 min: 100) = 0).
	self assert: ((0 min: -100) = -100).

	self assert: ((4.2 rounded) = 4).
	self assert: ((4.5 rounded) = 5).

	^ 1

	