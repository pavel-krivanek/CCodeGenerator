"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestCCodeGeneratorCore,
	#superclass : #PackageManifest,
	#category : 'CCodeGenerator-Core'
}

{ #category : #'meta-data - dependency analyser' }
ManifestCCodeGeneratorCore class >> manuallyResolvedDependencies [
	^ #(#Traits #Transcript #'Morphic-Core' #UnifiedFFI #'OpalCompiler-Core')
]
