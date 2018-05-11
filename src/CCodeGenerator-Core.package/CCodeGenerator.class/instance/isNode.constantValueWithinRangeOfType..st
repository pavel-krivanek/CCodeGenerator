type inference
isNode: aNode constantValueWithinRangeOfType: aType
	"Answer if aNode is a constant value within the range of an integral type.
	 If aNode isn't an integral constant or aType isn't an integral type then answer false."
	| value |
	^aNode expression isConstant
	  and: [(self isIntegralCType: aType)
	  and: [(value := aNode expression value) isInteger
	  and: [value positive
	  and: [(aType first = $u
			ifTrue: [value digitLength]
			ifFalse: [value highBit + 7 // 8]) <= (self sizeOfIntegralCType: aType)]]]]