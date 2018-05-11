C code generation
emitCLocalsOn: aStream generator: aCodeGen
	"Emit a C function header for this method onto the given stream."

	| volatileVariables |
	volatileVariables := properties includesKey: #volatile.
	self refersToGlobalStruct ifTrue:
		[aStream
			next: 3 put: Character space; "there's already an opening ${ on this line; see sender"
			nextPutAll: (volatileVariables
						ifTrue: ['DECL_MAYBE_VOLATILE_SQ_GLOBAL_STRUCT']
						ifFalse: ['DECL_MAYBE_SQ_GLOBAL_STRUCT'])].
	aStream cr.
	locals isEmpty ifFalse:
		[(aCodeGen sortStrings: locals) do:
			[ :var | | decl |
			decl := self declarationAt: var.
			(volatileVariables or: [(decl beginsWith: 'static') or: [usedVariablesCache includes: var]]) ifTrue:
				[aStream next: 4 put: Character space.
				 volatileVariables ifTrue:
					[aStream nextPutAll: #volatile; space].
				 aStream
					nextPutAll: decl;
					nextPut: $;;
					cr]].
		 aStream cr]