Class {
	#name : #CCGExampleLib,
	#superclass : #FFILibrary,
	#category : 'CCodeGenerator-Core-Examples'
}

{ #category : #accessing }
CCGExampleLib class >> reset [

	FFIMethodRegistry resetAll.
	uniqueInstance := nil.
	Smalltalk garbageCollect.
]

{ #category : #'as yet unclassified' }
CCGExampleLib >> builtInFunctions [ 

	^ self ffiCall: #( int builtInFunctions ( ) ) module: 'generated.dll'
]

{ #category : #'as yet unclassified' }
CCGExampleLib >> doesNotWork [ 

	^ self ffiCall: #( int doesNotWork ( ) ) module: 'generated.dll'
]

{ #category : #'as yet unclassified' }
CCGExampleLib >> factorial: anArgument [

	^ self ffiCall: #( int factorial (int anArgument) ) module: 'generated.dll'
]

{ #category : #'as yet unclassified' }
CCGExampleLib >> fib4: k [

	^ self ffiCall: #( int fib4 (int k) ) module: 'generated.dll'
]

{ #category : #'as yet unclassified' }
CCGExampleLib >> string: aString [

	^ self ffiCall: #( char *string (char *aString) ) module: 'generated.dll'
]

{ #category : #'as yet unclassified' }
CCGExampleLib >> tests [

	^ self ffiCall: #( int tests ( ) ) module: 'generated.dll'
]
