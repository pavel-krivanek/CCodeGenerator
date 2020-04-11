Extension { #name : #LiteralNode }

{ #category : #'*CCodeGenerator-Core' }
LiteralNode >> asTranslatorNodeIn: aTMethod [
	"make a CCodeGenerator equivalent of me"

	^TConstantNode new setValue: key
]
