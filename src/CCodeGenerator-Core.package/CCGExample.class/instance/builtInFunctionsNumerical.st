as yet unclassified
builtInFunctionsNumerical

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>
				
	self assertTrue: (-42 abs = 42).
	self assertTrue: (42 abs = 42).

	self assertTrue: (((1+10-5) negated / -3 // 2 << 8 >> 7)  = 2 ).
	self assertTrue: ((4 >>> 1) = 2).
	self assertTrue: ((1 >>> 2) = 0).

	self assertTrue: ((0 max: 100) = 100).
	self assertTrue: ((0 max: -100) = 0).

	self assertTrue: ((0 min: 100) = 0).
	self assertTrue: ((0 min: -100) = -100).

	self assertTrue: ((4.2 rounded) = 4).
	self assertTrue: ((4.5 rounded) = 5).

	^ 1

	