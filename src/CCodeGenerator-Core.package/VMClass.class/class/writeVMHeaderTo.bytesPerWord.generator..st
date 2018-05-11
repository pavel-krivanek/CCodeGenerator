translation
writeVMHeaderTo: aStream bytesPerWord: bytesPerWord generator: aCCodeGenerator
	"Generate the contents of interp.h on aStream.  Specific Interpreter subclasses
	 override to add more stuff."
	aCCodeGenerator
		putDefineOf: 'VM_PROXY_MAJOR' as: self vmProxyMajorVersion on: aStream;
		putDefineOf: 'VM_PROXY_MINOR' as: self vmProxyMinorVersion on: aStream.
	aStream cr.
	aCCodeGenerator
		putDefineOf: 'SQ_VI_BYTES_PER_WORD' as: bytesPerWord on: aStream.
	aStream cr.

	"The most basic constants must be defined here, not in e.g. the plugin sources, to allow those
	 other sources to be shared between different builds (Spur vs SqueakV3, 32-bit vs 64-bit, etc)"
	VMBasicConstants mostBasicConstantNames asSet sorted do:
		[:constName|
		(VMBasicConstants classPool at: constName ifAbsent: []) ifNotNil:
			[:const| aCCodeGenerator putDefineOf: constName as: const on: aStream]].
	aStream cr.

	((VMBasicConstants classPool associations select: [:a| a key beginsWith: 'PrimErr'])
		sorted: [:a1 :a2| a1 value <= a2 value])
		do: [:a| aCCodeGenerator putDefineOf: a key as: a value on: aStream].
	aStream cr.

	aCCodeGenerator
		putDefineOf: 'MinSmallInteger' as: self objectMemoryClass minSmallInteger on: aStream;
		putDefineOf: 'MaxSmallInteger' as: self objectMemoryClass maxSmallInteger on: aStream;
		putDefineOf: 'NumSmallIntegerTagBits' as: self objectMemoryClass numSmallIntegerTagBits on: aStream.
	aStream cr