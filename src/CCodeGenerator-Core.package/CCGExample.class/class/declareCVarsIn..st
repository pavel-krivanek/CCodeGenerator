as yet unclassified
declareCVarsIn: aCCodeGenerator

	super declareCVarsIn: aCCodeGenerator.

	aCCodeGenerator 
			var: 'aStructure' type: #CCGExampleStruct;
			var: 'aStructureCopy' type: #CCGExampleStructCopy