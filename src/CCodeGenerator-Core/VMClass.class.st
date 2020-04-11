"
I am an abstract superclass for all classes in the VM that want to maintain a source timeStamp.
"
Class {
	#name : #VMClass,
	#superclass : #Object,
	#classVars : [
		'DefaultBase',
		'ExpensiveAsserts'
	],
	#pools : [
		'VMBasicConstants'
	],
	#classInstVars : [
		'timeStamp',
		'initializationOptions'
	],
	#category : 'CCodeGenerator-Core-Translation to C'
}

{ #category : #'as yet unclassified' }
VMClass class >> additionalSelectorTables [
	
	^ self tableFunctions
]

{ #category : #translation }
VMClass class >> ancilliaryClasses: optionsDictionary [
	"Answer any extra classes to be included in the translation."
	^{}
]

{ #category : #'accessing class hierarchy' }
VMClass class >> coreInterpreterClass [
	"While the interpreterClass/vmClass for translation may be
	 a subclass that holds a few primitives we want the actual
	 interpreter name at the head of the generated file."
	^((name endsWith: 'Primitives')
	   and: [name beginsWith: superclass name])
		ifTrue: [superclass]
		ifFalse: [self]
]

{ #category : #translation }
VMClass class >> declareCVarsIn: aCCodeGenerator [ 
	"Declare any additional variables and/or add type declarations for existing variables."
	aCCodeGenerator
		var: #expensiveAsserts
		declareC: 'char expensiveAsserts = 0'
]

{ #category : #'as yet unclassified' }
VMClass class >> exportHeaders [

FileStream forceNewFileNamed: 'sq.h' do: [ :f |
	f nextPutAll: 
'#ifndef __sq_h
#define __sq_h

#include <stdlib.h>
#include <math.h>
 
#define SQ_VI_BYTES_PER_WORD 4
#define SIZEOF_VOID_P 4

#if (SQ_VI_BYTES_PER_WORD == 4)
# define SQ_IMAGE32 1
#else
# define SQ_IMAGE64 1
#endif

#if (SIZEOF_VOID_P == 4)
# define SQ_HOST32 1
#elif (SIZEOF_VOID_P == 8)
# define SQ_HOST64 1
#else
# error host is neither 32- nor 64-bit?
#endif

#if defined(SQ_IMAGE32)
typedef int   sqInt;
typedef unsigned int  usqInt;
#elif defined(SQ_HOST64)
typedef long    sqInt;
typedef unsigned long usqInt;
#else
# if (SIZEOF_LONG_LONG != 8)
#   error long long integers are not 64-bits wide?
# endif 
typedef long long   sqInt;
typedef unsigned long long  usqInt;
#endif

#if defined(SQ_IMAGE32)
  typedef int		sqInt;
  typedef unsigned int	usqInt;
# define SQABS abs
#elif defined(SQ_HOST64)
  typedef long		sqInt;
  typedef unsigned long	usqInt;
# define SQABS labs
#elif (SIZEOF_LONG_LONG != 8)
#   error long long integers are not 64-bits wide?
#else
  typedef long long		sqInt;
  typedef unsigned long long	usqInt;
# define SQABS llabs
#endif

#if defined(__BIG_ENDIAN__)
# define VMBIGENDIAN 1
#else
# define VMBIGENDIAN 0
#endif

# define __stringify(foo) #foo
# define __stringifyNum(n) __stringify(n)

extern void warning(char *);
extern void warningat(char *,int);

# define assert(expr)  ((expr)||(warning(#expr " " __stringifyNum(__LINE__)),0))
# define asserta(expr) ((expr)||(warning(#expr " " __stringifyNum(__LINE__)),0))
/*# define assertf(msg)  (warning(#msg " " __stringifyNum(__LINE__)),0)*/
# define assertl(expr,line)  ((expr)||(warningat(#expr,line),0))
# define assertal(expr,line) ((expr)||(warningat(#expr,line),0))
# define assertfl(msg,line)  (warningat(#msg,line),0)

# define eassert(expr)  (!expensiveAsserts||(expr) \
						 ||(warning(#expr " " __stringifyNum(__LINE__)),0))


#define EXPORT(returnType) returnType

#define null 0

#define SQ_SWAP_4_BYTES(x) \
	(((unsigned int)(x) << 24) | \
	(((unsigned int)(x) <<  8) & 0xff0000U) | \
	(((unsigned int)(x) >>  8) & 0xff00U) | \
	( (unsigned int)(x) >> 24))
#define SQ_SWAP_8_BYTES(x) \
	(((unsigned long long)(x) << 56) | \
	(((unsigned long long)(x) << 40) & 0xff000000000000ULL) | \
	(((unsigned long long)(x) << 24) & 0xff0000000000ULL) | \
	(((unsigned long long)(x) << 8)  & 0xff00000000ULL) | \
	(((unsigned long long)(x) >> 8)  & 0xff000000ULL) | \
	(((unsigned long long)(x) >> 24) & 0xff0000ULL) | \
	(((unsigned long long)(x) >> 40) & 0xff00ULL) | \
	( (unsigned long long)(x) >> 56))
	
/* Since Large Integers are Bytes Oops allways stored as little endian,
   the following macros are handy to retrieve 4 or 8 byte limbs */
#if VMBIGENDIAN
#  define SQ_SWAP_4_BYTES_IF_BIGENDIAN(x) SQ_SWAP_4_BYTES(x)
#  define SQ_SWAP_8_BYTES_IF_BIGENDIAN(x) SQ_SWAP_8_BYTES(x)
#else
#  define SQ_SWAP_4_BYTES_IF_BIGENDIAN(x) (x)
#  define SQ_SWAP_8_BYTES_IF_BIGENDIAN(x) (x)
#endif

/* sqLong is a signed integer with at least 64bits on both 32 and 64 bits images
   usqLong is the unsigned flavour
   SQLABS is a macro for taking absolute value of a sqLong */
#if !defined(sqLong)
#  if SIZEOF_LONG == 8
#     define sqLong long
#     define usqLong unsigned long
#     define SQLABS labs
#  elif _MSC_VER
#     define sqLong __int64
#     define usqLong unsigned __int64
#     define SQLABS llabs
#  else
#     define sqLong long long
#     define usqLong unsigned long long
#     define SQLABS llabs
#  endif
#endif /* !defined(sqLong) */

#endif /* __sq_h */
' ]
]

{ #category : #translation }
VMClass class >> implicitReturnTypeFor: aSelector [
	"Answer the return type for methods that don't have an explicit return."
	^#sqInt
]

{ #category : #initialization }
VMClass class >> initializationOptions [
	^initializationOptions
]

{ #category : #initialization }
VMClass class >> initializationOptions: optionsDictionary [
	initializationOptions := optionsDictionary
]

{ #category : #initialization }
VMClass class >> initializeMiscConstants [
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
	IMMUTABILITY := initializationOptions at: #IMMUTABILITY ifAbsent: [false].

	"These must be set only if specified, not defaulted, because they are set on the command line or in include files."
	initializationOptions
		at: #VMBIGENDIAN	ifPresent: [:value| VMBIGENDIAN := value];
		at: #ObjectMemory	ifPresent: [:value| SPURVM := value beginsWith: 'Spur'];
		at: #STACKVM		ifPresent: [:value| STACKVM := value];
		at: #COGVM		ifPresent: [:value| COGVM := initializationOptions at: #COGVM];
		at: #COGMTVM		ifPresent: [:value| COGMTVM := initializationOptions at: #COGMTVM].

	"And not these; they're compile-time"
	IMMUTABILITY := initializationOptions at: #IMMUTABILITY ifAbsent: [SPURVM] "Default as enabled for Spur VMs"

]

{ #category : #translation }
VMClass class >> isAccessor: aSelector [
	"Answer if aSelector is simply an accessor method for one of our fields.
	 Answer false by default.  VMStructType classes redefine this appropriately."
	^false
]

{ #category : #translation }
VMClass class >> isNonArgumentImplicitReceiverVariableName: aString [
	^false
]

{ #category : #'as yet unclassified' }
VMClass class >> isStructClass [
	"The various VMStructType classes override this."
	^false
]

{ #category : #translation }
VMClass class >> monticelloDescription [
	"Answer the Monticello version of the packlage containing the receiver.
	 This is a hook to allow subclasses to expand upon the default monticello description."
	^CCodeGenerator monticelloDescriptionFor: self
]

{ #category : #translation }
VMClass class >> mustBeGlobal: var [
	"Answer if a variable must be global and exported.  Used for inst vars that are accessed from VM support code."

	^var = #expensiveAsserts
]

{ #category : #'as yet unclassified' }
VMClass class >> namesOfVariablesToLocalize [
	^#()
]

{ #category : #'as yet unclassified' }
VMClass class >> numSmallIntegerTagBits [
	^1
]

{ #category : #'as yet unclassified' }
VMClass class >> objectMemoryClass [

	^ self
]

{ #category : #translation }
VMClass class >> preambleCCode [
	
	"return C code that should by placed before the generated code"

	^ ''
]

{ #category : #translation }
VMClass class >> prepareToBeAddedToCodeGenerator: aCCodeGenerator [ 
	"Hook for translation.  e.g. allows a subclass to override its
	 superclass's methods by deleting them before it adds its own."
]

{ #category : #translation }
VMClass class >> requiredMethodNames: options [
	"Answer a list of method names that should be retained for export or other
	 support reasons.  These are typically entry-points that unless explicitly noted
	 will be deleted by the code generator since it will assume these are not used."
	^#()
]

{ #category : #translation }
VMClass class >> shouldGenerateDeadCode [
	"Answer if the code generator should generate dead code, e.g. in false ifTrue: [dead] ifFalse: [live].
	 This *may* be useful in debugging (see CCodeGenerator>>nilOrBooleanConstantReceiverOf: et al).
	 But by default we answer false."

	^false
]

{ #category : #translation }
VMClass class >> shouldGenerateTypedefFor: aStructClass [
	"Hack to work-around multiple definitions.  Sometimes a type has been defined in an include."
	^ true
]

{ #category : #simulation }
VMClass class >> simulatorClass [
	"For running from Smalltalk - answer a class that can be used to simulate the receiver."

	^self
]

{ #category : #translation }
VMClass class >> specialValueForConstant: constantName default: defaultValue [
	^nil
]

{ #category : #'as yet unclassified' }
VMClass class >> tableFunctions [
	
	^ Set new
]

{ #category : #translation }
VMClass class >> typeForSelf [
	"Answer the type to give self if appropriate, or nil if not."
	^nil
]

{ #category : #'as yet unclassified' }
VMClass class >> wordSize [
	"Answer either 4 or 8 depending on the processor's basic architacture."
	"This is a 32-bit ISA"
	^4
]

{ #category : #translation }
VMClass class >> writeVMHeaderTo: aStream bytesPerWord: bytesPerWord generator: aCCodeGenerator [
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
]

{ #category : #'memory access' }
VMClass >> cCoerce: value to: cTypeString [
	"Type coercion. For translation a cast will be emmitted. When running in Smalltalk
	  answer a suitable wrapper for correct indexing."
	<doNotGenerate>
	^value
		ifNil: [value]
		ifNotNil: [value coerceTo: cTypeString sim: self]
]

{ #category : #'printf logging' }
VMClass >> f: logFilename open: mode [
	"Simulate a FILE stream by answering a transcript.
	 Can be used with the f:printf: method."
	<doNotGenerate>
	^true
		ifTrue: [(TranscriptStream on: (String new: 100000))
					openLabel: logFilename;
					yourself]
		ifFalse: [self coInterpreter transcript]
]

{ #category : #'memory access' }
VMClass >> floatAtPointer: pointer [
	<doNotGenerate>
	self halt.
]

{ #category : #'memory access' }
VMClass >> floatAtPointer: pointer put: value [
	<doNotGenerate>
	self halt.
]

{ #category : #'C library simulation' }
VMClass >> free: pointer [
	<doNotGenerate>
	"Do nothing"
]

{ #category : #'memory access' }
VMClass >> int16AtPointer: pointer [
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and the result is an 16 bit integer."
	<doNotGenerate>

	^self shortAt: pointer
]

{ #category : #'memory access' }
VMClass >> int16AtPointer: pointer put: value [
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and the result is an 16 bit integer."
	<doNotGenerate>

	^self shortAt: pointer put: value
]

{ #category : #'memory access' }
VMClass >> int32AtPointer: pointer [
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and the result is an 32 bit integer."
	<doNotGenerate>

	^self longAt: pointer
]

{ #category : #'memory access' }
VMClass >> int32AtPointer: pointer put: value [
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and the result is an 32 bit integer."
	<doNotGenerate>

	^self longAt: pointer put: value
]

{ #category : #'memory access' }
VMClass >> int64AtPointer: pointer [
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and the result is the width of a machine word."
	<doNotGenerate>

	^self halt
]

{ #category : #'memory access' }
VMClass >> int64AtPointer: pointer put: longValue [
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and longValue is the width of a machine word."
	<doNotGenerate>

	^self halt.
]

{ #category : #'memory access' }
VMClass >> int8AtPointer: pointer [
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and the result is an 16 bit integer."
	<doNotGenerate>

	^self at: pointer
]

{ #category : #'memory access' }
VMClass >> int8AtPointer: pointer put: value [
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and the result is an 16 bit integer."
	<doNotGenerate>

	^self at: pointer put: value
]

{ #category : #'memory access' }
VMClass >> long64AtPointer: pointer [
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and the result is the width of a machine word."
	<doNotGenerate>

	^self halt
]

{ #category : #'memory access' }
VMClass >> long64AtPointer: pointer put: longValue [
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and longValue is the width of a machine word."
	<doNotGenerate>

	^self halt.
]

{ #category : #'C library simulation' }
VMClass >> malloc: size [
	<doNotGenerate>
	^ ByteArray new: size
]

{ #category : #'memory access' }
VMClass >> pointerAtPointer: pointer [
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and the result is the width of a machine word."
	<doNotGenerate>

	^self longAt: pointer
]

{ #category : #'memory access' }
VMClass >> pointerAtPointer: pointer put: value [
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and the result is the width of a machine word."
	<doNotGenerate>

	^self longAt: pointer put: value
]

{ #category : #'memory access' }
VMClass >> singleFloatAtPointer: pointer [
	<doNotGenerate>
	self halt.
]

{ #category : #'memory access' }
VMClass >> singleFloatAtPointer: pointer put: value [
	<doNotGenerate>
	self halt.
]

{ #category : #'memory access' }
VMClass >> uint16AtPointer: pointer [
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and the result is an 16 bit integer."
	<doNotGenerate>

	^self shortAt: pointer
]

{ #category : #'memory access' }
VMClass >> uint16AtPointer: pointer put: value [
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and the result is an 16 bit integer."
	<doNotGenerate>

	^self shortAt: pointer put: value
]

{ #category : #'memory access' }
VMClass >> uint32AtPointer: pointer [
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and the result is an 32 bit integer."
	<doNotGenerate>

	^self longAt: pointer
]

{ #category : #'memory access' }
VMClass >> uint32AtPointer: pointer put: value [
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and the result is an 32 bit integer."
	<doNotGenerate>

	^self longAt: pointer put: value
]

{ #category : #'memory access' }
VMClass >> uint64AtPointer: pointer [
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and the result is the width of a machine word."
	<doNotGenerate>

	^self halt
]

{ #category : #'memory access' }
VMClass >> uint64AtPointer: pointer put: longValue [
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and longValue is the width of a machine word."
	<doNotGenerate>

	^self halt.
]

{ #category : #'memory access' }
VMClass >> uint8AtPointer: pointer [
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and the result is an 16 bit integer."
	<doNotGenerate>

	^self at: pointer
]

{ #category : #'memory access' }
VMClass >> uint8AtPointer: pointer put: value [
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and the result is an 16 bit integer."
	<doNotGenerate>

	^self at: pointer put: value
]
