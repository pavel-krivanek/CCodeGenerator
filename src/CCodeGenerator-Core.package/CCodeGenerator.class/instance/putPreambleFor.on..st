C code generator
putPreambleFor: aClass on: aStream

	| preamble |
	
	preamble := aClass preambleCCode.
	preamble ifNotEmpty: [
		| actualClass |
		 actualClass := aClass class whichClassIncludesSelector: #preambleCCode.
		 aStream
			ensureCr; cr;
			nextPutAll: '/* '; print: actualClass; nextPutAll: '>>preambleCCode */'; cr;
			nextPutAll: preamble; cr;
			nextPutAll: '/* end '; print: actualClass; nextPutAll: '>>preambleCCode */'; cr]