Extension { #name : #Integer }

{ #category : #'*CCodeGenerator-Core' }
Integer >> >>> shiftAmount [  "right shift, but causes CCodeGenerator to generate a signed shift"
	shiftAmount < 0 ifTrue: [self error: 'negative arg'].
	^self bitShift: 0 - shiftAmount
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> addBreakpoint: address [
	^{self. address}
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> asCharPtr [
	^(Notification new tag: #getInterpreter; signal)
		ifNotNil: [:interpreter|
				(interpreter firstIndexableField: self) asInteger
					coerceTo: #'char *'
					sim: interpreter]
		ifNil: [self]
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> asIntegerPtr [
	^self
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> asLong [
	^self
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> asPositiveIntegerObj [
	"This is a SmartSyntaxPlugin convenience, invented with little thought for simulation (grrr).
	  In the VM this is equivalent to
		interpreterProxy methodReturnValue: (interpreterProxy positive32BitIntegerFor: self)
	 but if a plugin is being developed I /think/ it is just
		^self
	 So search the stack to discover what context it is being used in."
	(thisContext findContextSuchThat: [:ctxt| ctxt receiver isInterpreterPlugin]) ifNotNil:
		[:ctxt| | interpreter |
		interpreter := ctxt receiver getInterpreter.
		interpreter methodReturnValue: (interpreter positive32BitIntegerFor: self)].
	^self
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> asSmallIntegerObj [
	^(Notification new tag: #getInterpreter; signal)
		ifNotNil: [:interpreter| interpreter integerObjectOf: self]
		ifNil: [self]
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> asUnsignedInteger [
	"Since the simulator deals with positive integers most of the time we assert that the receiver is greater than zero.
	 But one major exception is stack pointers in the StackInterpreterSimulator, which are negative.  So don't fail
	 if the sender is a StackInterpreter and the receiver could be a stack pointer."
	self >= 0 ifFalse:
		[self assert: (((thisContext sender methodClass includesBehavior: CoInterpreter)
					   and: [self between: Cogit maxNegativeErrorCode and: -1])
					or: [(thisContext sender methodClass includesBehavior: StackInterpreter)
					   and: [thisContext sender receiver stackPages couldBeFramePointer: self]])].
	^self
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> asUnsignedIntegerPtr [
	"Since the simulator deals with positive integers most of the time we assert that the receiver is greater than zero.
	 But one major exception is stack pointers in the StackInterpreterSimulator, which are negative.  So don't fail
	 if the sender is a StackInterpreter and the receiver could be a stack pointer."
	self >= 0 ifFalse:
		[self assert: ((thisContext sender methodClass includesBehavior: StackInterpreter)
					and: [thisContext sender receiver stackPages couldBeFramePointer: self])].
	^self
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> asUnsignedLong [
	self assert: self >= 0.
	^self
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> asUnsignedLongLong [
	self assert: self >= 0.
	^self
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> asVoidPointer [
	^self
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> bitInvert64 [
	"Answer the 64-bit complement of the receiver."

	^self bitXor: 16rFFFFFFFFFFFFFFFF
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> byteSwap32 [
	"swap the bytes of a 32 bit unsigned integer"
	
	^((self << 24) bitAnd: 16rFF000000) bitOr:
	  (((self << 8) bitAnd: 16rFF0000) bitOr:
	  (((self >> 8) bitAnd: 16rFF00) bitOr:
	  (((self >> 24) bitAnd: 16rFF))))
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> byteSwap64 [
	"swap the bytes of a 64 bit unsigned integer"
	
	^(((self << 56) bitAnd: 16rFF00000000000000) bitOr:
	  (((self << 40) bitAnd: 16rFF000000000000) bitOr:
	  (((self << 24) bitAnd: 16rFF0000000000) bitOr:
	  (((self << 8) bitAnd: 16rFF00000000) bitOr:
	  (((self >> 8) bitAnd: 16rFF000000) bitOr:
	  (((self >> 24) bitAnd: 16rFF0000) bitOr:
	  (((self >> 40) bitAnd: 16rFF00) bitOr:
	  ((self >> 56) bitAnd: 16rFF))))))))
]

{ #category : #'*CCodeGenerator-Core' }
Integer class >> ccg: cg prolog: aBlock expr: aString index: anInteger [

	^cg ccgLoad: aBlock expr: aString asKindOfIntegerFrom: anInteger
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> coerceTo: cTypeString sim: interpreter [

	| unitSize |
	cTypeString last = $* ifTrue:  "C pointer"
		[unitSize := cTypeString caseOf: {
		[#'char *'] -> [1].
		[#'short *'] -> [2].
		[#'int *'] -> [4].
		[#'long long *'] -> [8].
		[#'float *'] -> [^CFloatArray basicNew interpreter: interpreter address: self unitSize: 4; yourself].
		[#'double *'] -> [^CFloatArray basicNew interpreter: interpreter address: self unitSize: 8; yourself].
		[#'unsigned *'] -> [4].
		[#'unsigned int *'] -> [4].
		[#'unsigned char *'] -> [1].
		[#'signed char *'] -> [1].
		[#'unsigned short *'] -> [2].
		[#'unsigned long long *'] -> [8].
		[#'oop *'] -> [interpreter bytesPerOop].
		}
		otherwise: [interpreter wordSize].
		^CArray basicNew
			interpreter: interpreter address: self unitSize: unitSize;
			yourself].
	^self  "C number (int, char, float, etc)"
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> hex8 [
	"Print the receiver in base 16 with prefixed base, using at least 8 digits.
	 DO NOT CHANGE THIS!  The Cog VMMaker depends on this.
	 Consider using storeStringBase: 16 length: 11 padded: true instead."
	  "16r3333 hex8"
	| hex |
	hex := self hex.  "16rNNN"
	^hex size < 11
		ifTrue: [hex copyReplaceFrom: 4 to: 3
						 with: ('00000000' copyFrom: 1 to: 11-hex size)]
		ifFalse: [hex]
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> isActiveBreakpoint [
	^true
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> isBreakpointFor: address [
	^self = address
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> menuPrompt [
	^' (', self hex, ')'
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> removeBreakpoint: address [
	^nil
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> signedBitShift: anInteger [
	"For historical reasons Slang generates an unsigned shift from all of the shift operators >>, << & bitShift:.
	 These are too deeply entrenched to try and redefine the semantics.  So instead we provide a signed bitShift:
	 that signals to Slang that its argument should be cast to signed, not to unsigned, when being shifted."
	^self bitShift: anInteger
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> signedIntFromChar [
	"Self is an unsigned 8-bit integer in twos-comp form"

	| shortBits |
	shortBits := self bitAnd: 16rFF.
	^(self bitAnd: 16r80) "sign bit" = 0
		ifTrue: [shortBits]
		ifFalse: [shortBits - 16r100]
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> signedIntFromLong [
	"Self is a signed or unsigned 32-bit integer"

	| bits |
	(self >= -1073741824 and: [self <= 1073741823]) ifTrue: "These are known to be SmallIntegers..."
		[^self].
	bits := self bitAnd: 16rFFFFFFFF.
	(bits digitAt: 4) <= 16r7F ifTrue: [^bits].
	^bits - 16r100000000
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> signedIntFromLong64 [
	"Self is a signed or unsigned 64-bit integer"

	| bits |
	"This case is handled by the SmallInteger subclass..."
	"(self >= -1073741824 and: [self <= 1073741823]) ifTrue:
		[^self]."
	bits := self bitAnd: 16rFFFFFFFFFFFFFFFF.
	(bits digitAt: 8) <= 16r7F ifTrue: [^bits].
	^bits - 16r10000000000000000
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> signedIntFromShort [
	"Self is an unsigned 16-bit integer in twos-comp form"

	| shortBits |
	shortBits := self bitAnd: 16rFFFF.
	^(self bitAnd: 16r8000) "sign bit" = 0
		ifTrue: [shortBits]
		ifFalse: [shortBits - 16r10000]
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> signedIntToChar [
	"Produces an 8-bit value in twos-comp form. Truncates if out-of-range as per a C cast"

	^self bitAnd: 16rFF
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> signedIntToLong [
	"Produces a 32-bit value in twos-comp form. Truncates if out-of-range as per a C cast"

	^self bitAnd: 16rFFFFFFFF
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> signedIntToLong64 [
	"Produces a 64-bit value in twos-comp form. Truncates if out-of-range as per a C cast"

	^self bitAnd: 16rFFFFFFFFFFFFFFFF
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> signedIntToShort [
	"Produces a 16-bit value in twos-comp form. Truncates if out-of-range as per a C cast"

	^self bitAnd: 16rFFFF
]

{ #category : #'*CCodeGenerator-Core' }
Integer >> singleStepRequiredToTriggerIn: aCogit [
	^self between: aCogit cogCodeBase and: aCogit methodZone limitZony
]