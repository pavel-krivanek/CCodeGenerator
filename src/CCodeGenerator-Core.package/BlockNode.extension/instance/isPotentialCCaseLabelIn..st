*CCodeGenerator-Core
isPotentialCCaseLabelIn: aTMethod
	| stmt |
	statements size ~= 1 ifTrue: [^false].
	stmt := statements first.
	^self isPotentialCCaseLabel: stmt in: aTMethod