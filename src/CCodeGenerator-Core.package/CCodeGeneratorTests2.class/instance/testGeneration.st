tests
testGeneration

| cg |

CCGExampleLib reset.

cg := CCodeGenerator new initialize.
cg vmClass: CCGExample.
cg addClass: CCGExample.
CCGExample exportHeaders.
cg storeCodeOnFile: 'generated.c' doInlining: false.  

LibC uniqueInstance system: 'gcc -c -m32 generated.c'.
LibC uniqueInstance system: 'gcc -shared -m32 -o generated.dll generated.o'.

self assert: ((CCGExampleLib uniqueInstance fib4: 30) =  90799453).
self assert: ((CCGExampleLib uniqueInstance factorial: 5) =  120).


