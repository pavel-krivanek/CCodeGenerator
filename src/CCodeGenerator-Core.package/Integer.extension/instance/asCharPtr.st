*CCodeGenerator-Core
asCharPtr
	^(Notification new tag: #getInterpreter; signal)
		ifNotNil: [:interpreter|
				(interpreter firstIndexableField: self) asInteger
					coerceTo: #'char *'
					sim: interpreter]
		ifNil: [self]