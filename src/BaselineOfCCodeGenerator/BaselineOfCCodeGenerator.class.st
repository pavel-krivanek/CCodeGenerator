Class {
	#name : #BaselineOfCCodeGenerator,
	#superclass : #BaselineOf,
	#category : 'BaselineOfCCodeGenerator'
}

{ #category : #baselines }
BaselineOfCCodeGenerator >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			package: #'CCodeGenerator-Core'
	] 
]
