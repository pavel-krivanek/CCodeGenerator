*CCodeGenerator-Core
asUnsignedInteger
	self assert: self >= 0.
	"C conversion from float/double to integer is by dropping the fractional part"
	^self truncated