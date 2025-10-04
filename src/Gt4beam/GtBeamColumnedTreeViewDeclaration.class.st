Class {
	#name : #GtBeamColumnedTreeViewDeclaration,
	#superclass : #GtBeamViewDeclaration,
	#category : #'Gt4beam-Serialization'
}

{ #category : #'as yet unclassified' }
GtBeamColumnedTreeViewDeclaration class >> remoteName [
	^ 'GtPhlowColumnedTreeViewSpecification'
]

{ #category : #'as yet unclassified' }
GtBeamColumnedTreeViewDeclaration >> treatView: view [
	view
		items: [ self rawData at: #items ];
		children: [ :item | item at: #children ].

	(self rawData at: #columns)
		withIndexDo: [ :aColumn :anIndex | view column: (aColumn at: #title) text: [ :item | item at: #values at: anIndex ] ]
]

{ #category : #'as yet unclassified' }
GtBeamColumnedTreeViewDeclaration >> viewName [
	^ #columnedTree
]
