inlining
isIntegralCType: aCType "<String>"
	^(#('sqLong' 'usqLong' 'sqInt' 'usqInt' 'sqIntptr_t' 'usqIntptr_t'
		'long' 'long long' 'int' 'short' 'short int' 'char' 'signed char'
		'size_t' 'pid_t') includes: aCType asString)
	or: [(aCType beginsWith: 'unsigned') "Accept e.g. 'unsigned long' and also 'unsigned  : 8'"
		and: [(aCType includesAnyOf: '[*]') not]]