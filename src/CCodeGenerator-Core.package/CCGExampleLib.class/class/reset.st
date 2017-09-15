accessing
reset

	FFIMethodRegistry resetAll.
	uniqueInstance := nil.
	Smalltalk garbageCollect.