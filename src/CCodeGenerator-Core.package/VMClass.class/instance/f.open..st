printf logging
f: logFilename open: mode
	"Simulate a FILE stream by answering a transcript.
	 Can be used with the f:printf: method."
	<doNotGenerate>
	^true
		ifTrue: [(TranscriptStream on: (String new: 100000))
					openLabel: logFilename;
					yourself]
		ifFalse: [self coInterpreter transcript]