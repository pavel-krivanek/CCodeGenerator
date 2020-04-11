Extension { #name : #LiteralNode }

{ #category : #'*CCodeGenerator-Core-C translation' }
LiteralNode >> asTranslatorNodeIn: aTMethod [
	"make a CCodeGenerator equivalent of me"

	^TConstantNode new setValue: key
]
