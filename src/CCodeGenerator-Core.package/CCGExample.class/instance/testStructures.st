as yet unclassified
testStructures

	<returnTypeC: #'void'>
	
	aStructureCopy x: 2.
	aStructureCopy y: 4.
	aStructureCopy z: 6.

	aStructure x: 1.
	aStructure y: 2.
	aStructure z: 3.	
	
	self assertTrue: aStructure sum = 6.	
	
	self assertTrue: aStructureCopy sumCopy = 12.