as yet unclassified
builtInFunctionsComparisons

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>
				
	self assertTrue: (1 < 2).
	self assertTrue: (1 <= 2).
	self assertTrue: (2 <= 2).
	self assertTrue: (2 = 2).
	self assertTrue: (2 > 1).
	self assertTrue: (2 >= 1).
	self assertTrue: (2 >= 2).
	self assertTrue: (2 ~= 1).
	self assertTrue: (2 == 2).
	self denyTrue: (2 ~~ 2).

	self denyTrue: (1 isNil).
	self assertTrue: (nil isNil).

	self assertTrue: (1 notNil).
	self assertTrue: (nil isNil).

	^ 1

	