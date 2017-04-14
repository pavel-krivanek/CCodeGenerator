as yet unclassified
fib4: k

	<export: true>
	<returnTypeC: #'sqInt'>
	<var: #k type: #'sqInt'>
	<ignoreForCoverage>	

	k < 4 
		ifTrue: [ ^ 1 ]
		ifFalse: [ 
			^ (self fib4: k-1) + (self fib4: k-2) + (self fib4: k-3) + (self fib4: k-4) ].