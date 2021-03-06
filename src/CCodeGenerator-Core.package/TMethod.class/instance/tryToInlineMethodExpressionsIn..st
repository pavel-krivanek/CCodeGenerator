inlining
tryToInlineMethodExpressionsIn: aCodeGen
	"Expand any (complete) inline methods sent by this method as receivers or parameters.
	 Answer if anything was inlined."

	| sendsToInline |
	sendsToInline := Dictionary new: 100.
	aCodeGen
		pushScope: declarations
		while: [parseTree
					nodesDo:
						[:node|
						(self inlineableFunctionCall: node in: aCodeGen) ifTrue:
							[(self inlineFunctionCall: node in: aCodeGen) ifNotNil:
								[:replacement|
								 (replacement isConstant
								  and: [replacement isDefine not
								  and: [replacement value isNumber
								  and: [replacement comment isNil]]]) ifTrue:
									[replacement comment: node selector].
								 sendsToInline at: node put: replacement]]]
					unless: "Don't inline the arguments to asserts to keep the asserts readable"
						[:node|
						node isSend
						and: [node selector == #cCode:inSmalltalk:
							or: [aCodeGen isAssertSelector: node selector]]]].

	sendsToInline isEmpty ifTrue:
		[^false].
	self replaceNodesIn: sendsToInline.
	^true