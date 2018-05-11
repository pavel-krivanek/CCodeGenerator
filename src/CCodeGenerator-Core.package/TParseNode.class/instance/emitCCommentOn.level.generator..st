C code generation
emitCCommentOn: aStream level: level generator: aCodeGen
	"Emit the transferred Smalltalk comments as C comments."

	((aCodeGen previousCommenter: self) == self or: [comment isNil]) ifTrue:
		[aCodeGen previousCommentMarksInlining: false.
		 ^self].
	(comment isString ifTrue: [{comment}] ifFalse: [comment]) withIndexDo:
		[:commentString :index |
		(index = 1 and: [commentString beginsWith: 'begin ']) ifTrue:
			[(aCodeGen previousCommentMarksInlining: true) ifTrue: [^true]].
		aStream crtab: level; nextPutAll: '/* '.
		(commentString findTokens: Character cr)
			do: [:line| aStream nextPutAll: line withBlanksTrimmed]
			separatedBy: [aStream crtab: level; next: 3 put: Character space].
		aStream nextPutAll: ' */'].
	 aStream cr