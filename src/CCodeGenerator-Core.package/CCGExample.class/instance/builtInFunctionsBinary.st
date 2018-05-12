as yet unclassified
builtInFunctionsBinary

	<ignoreForCoverage>	
	<returnTypeC: #'sqInt'>
				
	self assertTrue: [ (2r0101 bitAnd: 2r0011) = 2r0001 ].
	self assertTrue: [ (2r0101 bitOr: 2r0011) = 2r0111 ].
	self assertTrue: [ (2r0101 bitXor: 2r0011) = 2r0110 ].
	self assertTrue: [ (2r0101 bitShift: 2) = 2r10100 ].
	self assertTrue: [ (2r0101 signedBitShift: 2) = 2r10100 ].
	self assertTrue: [ (2r0101 bitInvert32) = 2r11111111111111111111111111111010 ].
	self assertTrue: [ (2r0101 bitInvert64) = 2r1111111111111111111111111111111111111111111111111111111111111010 ].
	self assertTrue: [ (2r0101 truncateTo: 2) = 2r0100 ].

	^ 1

	