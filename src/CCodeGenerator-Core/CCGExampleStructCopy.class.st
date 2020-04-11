Class {
	#name : #CCGExampleStructCopy,
	#superclass : #VMStructType,
	#instVars : [
		'x',
		'y',
		'z'
	],
	#category : 'CCodeGenerator-Core-Examples'
}

{ #category : #translation }
CCGExampleStructCopy class >> instVarNamesAndTypesForTranslationDo: aBinaryBlock [

	self allInstVarNames do:
		[:ivn| aBinaryBlock
				value: ivn
				value: #'sqInt']
]

{ #category : #accessing }
CCGExampleStructCopy >> sumCopy [

	"the method names for structures (except simple accessor) must be uique"

	^ self x + self y + self z
]

{ #category : #accessing }
CCGExampleStructCopy >> x [
	^ x
]

{ #category : #accessing }
CCGExampleStructCopy >> x: anObject [
	x := anObject
]

{ #category : #accessing }
CCGExampleStructCopy >> y [
	^ y
]

{ #category : #accessing }
CCGExampleStructCopy >> y: anObject [
	y := anObject
]

{ #category : #accessing }
CCGExampleStructCopy >> z [
	^ z
]

{ #category : #accessing }
CCGExampleStructCopy >> z: anObject [
	z := anObject
]
