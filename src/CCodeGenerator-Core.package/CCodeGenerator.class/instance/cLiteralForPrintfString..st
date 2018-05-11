C code generator
cLiteralForPrintfString: aString
	^(('"', (PrintfFormatString new setFormat: aString) transformForVMMaker, '"')
		copyReplaceAll: (String with: Character cr) with: '\n')
			copyReplaceAll: (String with: Character tab) with: '\t'