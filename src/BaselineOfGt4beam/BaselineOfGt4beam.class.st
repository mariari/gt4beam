Class {
	#name : #BaselineOfGt4beam,
	#superclass : #BaselineOf,
	#category : #BaselineOfGt4beam
}

{ #category : #loading }
BaselineOfGt4beam class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'gt4beam' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfGt4beam >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'Gt4beam'
		]
]
