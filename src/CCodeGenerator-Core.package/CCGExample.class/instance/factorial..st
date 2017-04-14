as yet unclassified
factorial: anArgument

	<export: true>
	<returnTypeC: #'usqInt'>
	<var: #anArgument type: #'usqInt'>
	<ignoreForCoverage>	
	
	| count factorial |
		
	count := anArgument.
	factorial := 1.
	[ count > 0 ] whileTrue: 
		[ factorial := factorial * count.
		count := count - 1 ].
	
	^ factorial