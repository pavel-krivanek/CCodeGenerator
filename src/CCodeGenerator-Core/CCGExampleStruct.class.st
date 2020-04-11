Class {
	#name : #CCGExampleStruct,
	#superclass : #VMStructType,
	#instVars : [
		'x',
		'y',
		'z'
	],
	#category : 'CCodeGenerator-Core-Examples'
}

{ #category : #translation }
CCGExampleStruct class >> instVarNamesAndTypesForTranslationDo: aBinaryBlock [

	self allInstVarNames do:
		[:ivn| aBinaryBlock
				value: ivn
				value: #'sqInt']
]

{ #category : #accessing }
CCGExampleStruct >> sum [

	^ self x + self y + self z
]

{ #category : #accessing }
CCGExampleStruct >> x [

	^ x
]

{ #category : #accessing }
CCGExampleStruct >> x: anObject [
	x := anObject
]

{ #category : #accessing }
CCGExampleStruct >> y [
	^ y
]

{ #category : #accessing }
CCGExampleStruct >> y: anObject [
	y := anObject
]

{ #category : #accessing }
CCGExampleStruct >> z [
	^ z
]

{ #category : #accessing }
CCGExampleStruct >> z: anObject [
	z := anObject
]
