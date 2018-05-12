as yet unclassified
builtInFunctionsComparisons

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>
				
	self assertTrue: [ 1 < 2 ].
	self assertTrue: [ 1 <= 2 ].
	self assertTrue: [ 2 <= 2 ].
	self assertTrue: [ 2 = 2 ].
	self assertTrue: [ 2 > 1 ].
	self assertTrue: [ 2 >= 1 ].
	self assertTrue: [ 2 >= 2 ].
	self assertTrue: [ 2 ~= 1 ].
	self assertTrue: [ 2 == 2 ].
	self assertTrue: [ 2 ~~ 2 ].

	self deny: (1 isNil).
	self assertTrue: (nil isNil).

	self assertTrue: (1 notNil).
	self deny: (nil isNil).

	^ 1

	