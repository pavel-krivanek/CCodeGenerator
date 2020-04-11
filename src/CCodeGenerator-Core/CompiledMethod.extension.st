Extension { #name : #CompiledMethod }

{ #category : #'*CCodeGenerator-Core' }
CompiledMethod >> decompileString [
	^ self decompile decompileString
]
