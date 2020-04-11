"
I am an absract superclass for classes which map to simple structs in C,  Right now I merely serve to organize all the struct types.  I would like to arrange that generated assignment accessors answer their argument to correspond with field assignment in C, but createInstVarAccessors is implemented by the browser not by ClassDescription.
"
Class {
	#name : #VMStructType,
	#superclass : #VMClass,
	#classVars : [
		'StructTypeNameCache'
	],
	#category : 'CCodeGenerator-Core-Support'
}

{ #category : #translation }
VMStructType class >> implicitReturnTypeFor: aSelector [
	"Answer the return type for methods that don't have an explicit return."
	^#sqInt
]

{ #category : #translation }
VMStructType class >> instVarNamesAndTypesForTranslationDo: aBinaryBlock [
	"enumerate aBinaryBlock with the names and C type strings for the inst vars to include in a struct of this type."

	self subclassResponsibility
]

{ #category : #translation }
VMStructType class >> isAccessor: aSelector [
	"Answer if aSelector is simply an accessor method for one of our fields."
	^(self instVarIndexFor: (aSelector copyWithout: $:) ifAbsent: [0]) > 0
]

{ #category : #translation }
VMStructType class >> isNonArgumentImplicitReceiverVariableName: aString [
	^#('cogit' 'coInterpreter'
		'methodZone' 'literalsManager'
		'objectMemory' 'objectRepresentation' 'manager') includes: aString
]

{ #category : #'as yet unclassified' }
VMStructType class >> isStructClass [
	^true
]

{ #category : #translation }
VMStructType class >> isTypePointerToStruct: type [
	| index |
	StructTypeNameCache ifNil:
		[StructTypeNameCache := Set new.
		 self allSubclassesDo:
			[:sc| StructTypeNameCache add: sc name; add: sc structTypeName ]].
	^type notNil
	  and: [(index := type indexOf: $*) > 0
	  and: [StructTypeNameCache anySatisfy:
			[:structType|
			(type beginsWith: structType)
			and: [index > structType size]]]]
]

{ #category : #translation }
VMStructType class >> isTypeStruct: type [
	StructTypeNameCache ifNil:
		[StructTypeNameCache := Set new.
		 self allSubclassesDo:
			[:sc| StructTypeNameCache add: sc name; add: sc structTypeName]].
	^type notNil
	  and: [StructTypeNameCache anySatisfy:
			[:structType|
			type = structType]]
]

{ #category : #translation }
VMStructType class >> needsTypeTag [
	self instVarNamesAndTypesForTranslationDo:
		[:ivn :type|
		((type isArray ifTrue: [type] ifFalse: [{type}]) anySatisfy:
			[:str|
			str isString
			and: [str includesSubstring: self structTagName]]) ifTrue:
				[^true]].
	^false

	"VMStructType allSubclasses select: [:sc| sc needsTypeTag]"
]

{ #category : #translation }
VMStructType class >> printTypedefOn: aStream [
	aStream nextPutAll: 'typedef struct '.
	self needsTypeTag ifTrue:
		[aStream nextPutAll: self structTagName; space].
	aStream nextPut: ${; cr.
	self instVarNamesAndTypesForTranslationDo:
		[:ivn :typeArg| | type |
		ivn first == $#
			ifTrue: [aStream nextPutAll: ivn]
			ifFalse:
				[type := typeArg.
				 #(BytesPerWord BaseHeaderSize BytesPerOop) do:
					[:sizeConstant| | index sizeConstantSize |
					(type notNil
					and: [(index := type indexOf: sizeConstant ifAbsent: 0) > 0]) ifTrue:
						[sizeConstantSize  := VMBasicConstants classPool at: sizeConstant.
						type := (type at: index + 1) = sizeConstantSize ifTrue:
									[type := type copyReplaceFrom: index to: index + 1 with: #().
									 type size = 1 ifTrue: [type first] ifFalse: [type]]]].
				 type ifNotNil:
					[type isArray
						ifTrue:
							[aStream tab: 1.
							 aStream nextPutAll: type first.
							 (type first last isSeparator or: [type first last = $*]) ifFalse:
								[aStream tab: 2].
							 aStream nextPutAll: ivn.
							 type last first isSeparator ifFalse:
								[aStream space].
							 aStream nextPutAll: type last]
						ifFalse:
							[aStream tab: 1.
							 aStream nextPutAll: type.
							 (type last isSeparator or: [type last = $*]) ifFalse:
								[aStream tab: 1].
							 aStream nextPutAll: ivn]].
				 aStream nextPut: $;].
		 aStream cr].
	aStream
		nextPutAll: ' } ';
		nextPutAll: self structTypeName;
		nextPut: $;;
		cr.
	self name ~= self structTypeName ifTrue:
		[(self withAllSuperclasses copyUpThrough: (self class whichClassIncludesSelector: #structTypeName) theNonMetaClass) do:
			[:structClass|
			 aStream cr; nextPutAll: '#define '; nextPutAll: structClass name; space; nextPutAll: self structTypeName].
		 aStream cr].
	aStream flush
]

{ #category : #translation }
VMStructType class >> returnTypeForAccessor: aSelector [
	| varName deStructTag |
	varName := aSelector copyWithout: $:.
	deStructTag := [:decl| decl copyReplaceAll: 'struct ', self structTagName with: self structTypeName].
	self instVarNamesAndTypesForTranslationDo:
		[:var :typeSpec|
		var = varName ifTrue:
			[^typeSpec isArray
				ifTrue: [(deStructTag value: typeSpec first), ' ', typeSpec last]
				ifFalse: [deStructTag value: typeSpec]]].
	^nil


	"InterpreterStackPage returnTypeForAccessor: #nextPage:"
]

{ #category : #translation }
VMStructType class >> structTagName [
	^'_', self structTypeName
]

{ #category : #translation }
VMStructType class >> structTargetKindForDeclaration: decl [
	StructTypeNameCache ifNil:
		[StructTypeNameCache := Set new.
		 self allSubclassesDo:
			[:sc| StructTypeNameCache add: sc name; add: sc structTypeName ]].
	^(decl notNil
	   and: [(StructTypeNameCache includes: decl)
			or: [StructTypeNameCache anySatisfy:
					[:structType|
					(decl beginsWith: structType)
					and: [(decl indexOf: $* ifAbsent: [decl indexOf: Character space]) > structType size]]]]) ifTrue:
		[(decl indexOf: $*) > 0
			ifTrue: [#pointer]
			ifFalse: [#struct]]
]

{ #category : #translation }
VMStructType class >> structTargetKindForType: type [
	StructTypeNameCache ifNil:
		[StructTypeNameCache := Set new.
		 self allSubclassesDo:
			[:sc| StructTypeNameCache add: sc name; add: sc structTypeName ]].
	^(type notNil
	   and: [StructTypeNameCache anySatisfy:
			[:structType|
			(type beginsWith: structType)
			and: [type size = structType size
				or: [(type at: structType size + 1) isAlphaNumeric not]]]]) ifTrue:
		[(type includes: $*)
			ifTrue: [#pointer]
			ifFalse: [#struct]]
]

{ #category : #translation }
VMStructType class >> structTypeName [
	"Provide the typedef name.  Subclases can override."
	^self name
]

{ #category : #translation }
VMStructType class >> typeForSelf [
	"Answer the type to give self if appropriate, or nil if not."
	^self structTypeName, ' *'
]

{ #category : #translation }
VMStructType class >> voidStructTypeCache [
	StructTypeNameCache := nil
]
