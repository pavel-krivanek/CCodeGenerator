accessing
vmClass: aClass

	"Set the main translation class if any."
	
	vmClass := aClass.
	vmClass ifNotNil: [
		generateDeadCode := vmClass shouldGenerateDeadCode]