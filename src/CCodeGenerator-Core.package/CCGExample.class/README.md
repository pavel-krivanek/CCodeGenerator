Generate the C code into generated.c

| cg |
cg := CCodeGenerator new initialize.
cg vmClass: CCGExample.
cg addClass: CCGExample.
CCGExample exportHeaders.
cg storeCodeOnFile: 'generated.c' doInlining: false.  

Compile it:

gcc -c -m32 generated.c
gcc -shared -m32 -o generated.dll generated.o
 
or: 
 
LibC uniqueInstance system: 'gcc -c -m32 generated.c'.
LibC uniqueInstance system: 'gcc -shared -m32 -o generated.dll generated.o'.

or:
| c | 
c := PipeableOSProcess command: 'gcc -c -m32 generated.c'.
(c output; succeeded)
		ifFalse: [ self error: 'Compilation error: ', c errorPipelineContents printString].
c := PipeableOSProcess command: 'gcc -shared -m32 -o generated.dll generated.o'.
(c output; succeeded)
		ifFalse: [ self error: 'Compilation error', c errorPipelineContents printString].		
				
Try it:

CCGExampleLib uniqueInstance fib4: 30.
CCGExampleLib uniqueInstance factorial: 5.