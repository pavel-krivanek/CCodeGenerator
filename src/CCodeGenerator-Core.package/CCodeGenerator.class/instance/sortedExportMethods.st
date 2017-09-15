public
sortedExportMethods
	"Answer a suitably-sorted array of all exported TMethods"
	^(methods select: [:m| m export]) asSortedCollection: [:a :b| a selector caseSensitiveLessOrEqual: b selector]