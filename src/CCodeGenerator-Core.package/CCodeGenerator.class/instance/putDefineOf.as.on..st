C code generator
putDefineOf: aConstantNameString as: valueOrValueString on: aStream
	aStream
		nextPutAll: '#define ';
		nextPutAll: aConstantNameString;
		space;
		nextPutAll: valueOrValueString asString;
		cr