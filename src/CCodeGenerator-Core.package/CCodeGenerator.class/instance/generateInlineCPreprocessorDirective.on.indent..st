C translation
generateInlineCPreprocessorDirective: msgNode on: aStream indent: level
	"Generate the C preprocessor directive for this message onto the given stream."

	aStream cr; nextPutAll: msgNode args first value.
	self noteVariableUsageInString: msgNode args first value