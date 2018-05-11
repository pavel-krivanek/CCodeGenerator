printing
printOptionalLabelOn: aStream

	label ifNotNil:
		[self unindentTabs: aStream.
		 aStream
			nextPutAll: label;
			nextPut: $:;
			tab]