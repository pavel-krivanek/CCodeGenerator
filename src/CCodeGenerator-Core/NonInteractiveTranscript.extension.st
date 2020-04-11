Extension { #name : #NonInteractiveTranscript }

{ #category : #'*CCodeGenerator-Core' }
NonInteractiveTranscript >> atEnd [ 
	^ stream atEnd
]

{ #category : #'*CCodeGenerator-Core' }
NonInteractiveTranscript >> closed [ 
	^ false
]

{ #category : #'*CCodeGenerator-Core' }
NonInteractiveTranscript >> crtab [
	"Append a return character, followed by a single tab character, to the 
	receiver."

	self nextPut: Character cr.
	self nextPut: Character tab
]

{ #category : #'*CCodeGenerator-Core' }
NonInteractiveTranscript >> ensureCr [
	stream ensureCr
]

{ #category : #'*CCodeGenerator-Core' }
NonInteractiveTranscript >> isBinary [
	^ stream isBinary
]

{ #category : #'*CCodeGenerator-Core' }
NonInteractiveTranscript >> isStream [
	
	^ true
]

{ #category : #'*CCodeGenerator-Core' }
NonInteractiveTranscript >> next: times put: aCharacter [
	times timesRepeat: [ self nextPut: aCharacter ]
]

{ #category : #'*CCodeGenerator-Core' }
NonInteractiveTranscript >> position [
	^ stream position
]

{ #category : #'*CCodeGenerator-Core' }
NonInteractiveTranscript >> position: aNumber [ 
	stream position: aNumber
]

{ #category : #'*CCodeGenerator-Core' }
NonInteractiveTranscript >> print: aNumber maxDecimalPlaces: places [
	aNumber 
		printOn: stream 
		showingDecimalPlaces: places
]

{ #category : #'*CCodeGenerator-Core' }
NonInteractiveTranscript >> size [ 
	^ stream size
]

{ #category : #'*CCodeGenerator-Core' }
NonInteractiveTranscript >> store: anObject [ 
	anObject storeOn: self
]
