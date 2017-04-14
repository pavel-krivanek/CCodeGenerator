initialization
initializeMiscConstants
	"Falsify the `what type of VM is this?' flags that are defined in the various interp.h files.
	 Subclass implementations need to include a super initializeMiscConstants"

	| omc |
	VMBIGENDIAN class. "Mention this for the benefit of CCodeGenerator>>emitCConstantsOn:"
	SPURVM := STACKVM := COGVM := COGMTVM := false.

	initializationOptions ifNil: [self initializationOptions: Dictionary new].
	omc := initializationOptions at: #ObjectMemory ifAbsent: nil.

	"Use ifAbsentPut: so that they will get copied back to the
	 VMMaker's options and dead code will likely be eliminated."
	"But not these; they're compile-time"
	MULTIPLEBYTECODESETS := initializationOptions at: #MULTIPLEBYTECODESETS ifAbsent: [false].
	IMMUTABILITY := initializationOptions at: #IMMUTABILITY ifAbsent: [false].

	"These must be set only if specified, not defaulted, because they are set on the command line or in include files."
	initializationOptions
		at: #VMBIGENDIAN	ifPresent: [:value| VMBIGENDIAN := value];
		at: #STACKVM		ifPresent: [:value| STACKVM := value];
		at: #COGVM		ifPresent: [:value| COGVM := initializationOptions at: #COGVM];
		at: #COGMTVM		ifPresent: [:value| COGMTVM := initializationOptions at: #COGMTVM]