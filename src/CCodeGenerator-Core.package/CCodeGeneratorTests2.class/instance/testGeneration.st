tests
testGeneration

| cg |

CCGExampleLib reset.

cg := CCodeGenerator new initialize.
cg vmClass: CCGExample.
cg addClass: CCGExample.
CCGExample exportHeaders.
cg storeCodeOnFile: 'generated.c' doInlining: false.  

LibC uniqueInstance system: 'gcc -c -fPIC generated.c'.
LibC uniqueInstance system: 'gcc -shared -o generated.dll generated.o'.

Smalltalk vm unloadModule: 'generated.dll'.

self assert: ((CCGExampleLib uniqueInstance fib4: 30) =  90799453).
self assert: ((CCGExampleLib uniqueInstance factorial: 5) =  120).


