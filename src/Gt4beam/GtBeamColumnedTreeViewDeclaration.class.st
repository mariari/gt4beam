Class {
	#name : #GtBeamColumnedTreeViewDeclaration,
	#superclass : #GtBeamViewDeclaration,
	#category : #'Gt4beam-Serialization'
}

{ #category : #'as yet unclassified' }
GtBeamColumnedTreeViewDeclaration class >> remoteName [
]

{ #category : #'as yet unclassified' }
GtBeamColumnedTreeViewDeclaration >> treatView: view [
	self rawData inspect.
	view items: [ self rawData at: #items ].

	(self rawData at: #columns)
		withIndexDo: [ :aColumn :anIndex | view column: (aColumn at: #title) text: [ :item | item at: anIndex ] ]
]

{ #category : #'as yet unclassified' }
GtBeamColumnedTreeViewDeclaration >> viewName [
	^ #columnedTree
]
