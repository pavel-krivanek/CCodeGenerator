C code generation
unindentTabs: aStream
	"Remove all but one tab up to the beginning of line from the given stream if possible."

	(aStream isKindOf: ReadWriteStream) ifFalse: [ ^self ].
	[aStream position > 0] whileTrue:
		[aStream position: aStream position - 1.
		 "restore stream position if previous char was not a tab"
		 aStream peek == Character tab ifFalse:
			[^aStream next; tab]]