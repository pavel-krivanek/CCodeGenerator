inlining support
propagateReturnIn: aCodeGen
	"Propagate the return type to all return nodes"
	| map coercionType |
	returnType = #void ifTrue:
		[^self].
	"The following is necessary for functions returning functions, which have problematic syntax"
	coercionType := aCodeGen
							extractTypeFor: (aCodeGen cFunctionNameFor: self selector)
							fromDeclaration: returnType.
	map := IdentityDictionary new.
	parseTree nodesDo:[:node|
		(node isReturn
		 and: [(aCodeGen typeFor: node expression in: self) ~= coercionType
		 and: [(aCodeGen isNode: node constantValueWithinRangeOfType: coercionType) not]]) ifTrue:
			[map at: node expression put: (aCodeGen nodeToCast: node expression to: coercionType)]].
	self replaceNodesIn: map