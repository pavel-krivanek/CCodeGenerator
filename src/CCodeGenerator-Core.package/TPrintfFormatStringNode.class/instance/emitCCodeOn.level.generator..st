C code generation
emitCCodeOn: aStream level: level generator: aCodeGen
	"Transform the printf string according to the LP64/LLP64 convention in sqMemoryAccess.h."
	aStream nextPutAll: (aCodeGen cLiteralForPrintfString: value).
	comment ifNotNil:
		[aStream
			nextPutAll: ' /* ';
			nextPutAll: comment;
			nextPutAll: ' */']