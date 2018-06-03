as yet unclassified
builtInFunctionsNumerical

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>
				
	self assertTrue: (-42 abs = 42).
	self assertTrue: (42 abs = 42).

	self assertTrue: (((1+10-5) negated / -3 // 2 << 8 >> 7)  = 2 ).

	self assertTrue: ((3 + 4) = 7).
	self assertTrue: ((3 - 4) = -1).
	self assertTrue: ((3 * 4) = 12).
	self assertTrue: (3 negated = -3).
	self assertTrue: ((4 // 2) = 2).
	self assertTrue: ((1.0 / 2.0) = 0.5).
	self assertTrue: ((1.0 / 2) = 0.5).
	self assertTrue: ((1 / 2.0) = 0.5).
	self assertTrue: ((10 \\ 3) = 1).

	self assertTrue: ((4 >>> 1) = 2).
	self assertTrue: ((1 >>> 2) = 0).

	self assertTrue: ((0 max: 100) = 100).
	self assertTrue: ((0 max: -100) = 0).

	self assertTrue: ((0 min: 100) = 0).
	self assertTrue: ((0 min: -100) = -100).

	self assertTrue: (2 between: 1 and: 3).

	self assertTrue: ((7 truncateTo: 2) = 6).

	self assertTrue: ((4.2 rounded) = 4).
	self assertTrue: ((4.5 rounded) = 5).

	self assertTrue: ((127 byteSwap32) = 2130706432).
	self assertTrue: ((127 byteSwap64) = 9151314442816847872).
	
	self assertTrue: ((31 allMask: 16) > 0).
	self denyTrue: (65 allMask: 127).
	
	"self assertTrue: (66 anyMask: 127)."
	self denyTrue: (4 anyMask: 2).

	self denyTrue: (65 noMask: 127).
	self assertTrue: (4 noMask: 2).

	self assertTrue: (42 asInteger = 42).
	self assertTrue: (42.7 asInteger = 42).

	self assertTrue: (42 asUnsignedInteger = 42).
	self assertTrue: (42.7 asUnsignedInteger = 42).

	self assertTrue: (42 asLong = 42).



	^ 1

	