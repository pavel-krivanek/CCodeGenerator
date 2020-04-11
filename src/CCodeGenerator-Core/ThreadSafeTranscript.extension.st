Extension { #name : #ThreadSafeTranscript }

{ #category : #'*CCodeGenerator-Core' }
ThreadSafeTranscript >> atEnd [ 
	^ stream atEnd
]

{ #category : #'*CCodeGenerator-Core' }
ThreadSafeTranscript >> closed [ 
	^ false
]

{ #category : #'*CCodeGenerator-Core' }
ThreadSafeTranscript >> crtab [
	"Append a return character, followed by a single tab character, to the 
	receiver."

	self nextPut: Character cr.
	self nextPut: Character tab
]

{ #category : #'*CCodeGenerator-Core' }
ThreadSafeTranscript >> ensureCr [
	stream ensureCr
]

{ #category : #'*CCodeGenerator-Core' }
ThreadSafeTranscript >> isBinary [
	^ stream isBinary
]

{ #category : #'*CCodeGenerator-Core' }
ThreadSafeTranscript >> isStream [
	
	^ true
]

{ #category : #'*CCodeGenerator-Core' }
ThreadSafeTranscript >> next: times put: aCharacter [
	times timesRepeat: [ self nextPut: aCharacter ]
]

{ #category : #'*CCodeGenerator-Core' }
ThreadSafeTranscript >> position [
	^ stream position
]

{ #category : #'*CCodeGenerator-Core' }
ThreadSafeTranscript >> position: aNumber [ 
	stream position: aNumber
]

{ #category : #'*CCodeGenerator-Core' }
ThreadSafeTranscript >> print: aNumber maxDecimalPlaces: places [
	aNumber 
		printOn: stream 
		showingDecimalPlaces: places
]

{ #category : #'*CCodeGenerator-Core' }
ThreadSafeTranscript >> size [ 
	^ stream size
]

{ #category : #'*CCodeGenerator-Core' }
ThreadSafeTranscript >> store: anObject [ 
	anObject storeOn: self
]
