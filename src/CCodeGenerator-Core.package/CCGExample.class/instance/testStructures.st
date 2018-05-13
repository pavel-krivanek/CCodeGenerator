as yet unclassified
testStructures

	<returnTypeC: #'void'>
	
	aStructureCopy a: 2.
	aStructureCopy b: 4.
	aStructureCopy c: 6.

	aStructure x: 1.
	aStructure y: 2.
	aStructure z: 3.	
	
	self assertTrue: aStructure sum = 6.	
	
	self assertTrue: aStructureCopy sumCopy = 12.