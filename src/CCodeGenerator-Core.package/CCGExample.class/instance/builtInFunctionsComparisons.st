as yet unclassified
builtInFunctionsComparisons

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>
				
	self assert: [ 1 < 2 ].
	self assert: [ 1 <= 2 ].
	self assert: [ 2 <= 2 ].
	self assert: [ 2 = 2 ].
	self assert: [ 2 > 1 ].
	self assert: [ 2 >= 1 ].
	self assert: [ 2 >= 2 ].
	self assert: [ 2 ~= 1 ].
	self assert: [ 2 == 2 ].
	self assert: [ 2 ~~ 2 ].

	self deny: (1 isNil).
	self assert: (nil isNil).

	self assert: (1 notNil).
	self deny: (nil isNil).

	^ 1

	