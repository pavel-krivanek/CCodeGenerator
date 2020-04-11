Extension { #name : #VariableNode }

{ #category : #'*CCodeGenerator-Core-C translation' }
VariableNode >> asTranslatorNodeIn: aTMethod [
	"make a CCodeGenerator equivalent of me"
	name = 'true' ifTrue: [^ TConstantNode new setValue: true].
	name = 'false' ifTrue: [^ TConstantNode new setValue: false].
	^ TVariableNode new setName: name
]
