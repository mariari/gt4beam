Class {
	#name : #GtBeamColumnedListViewDeclaration,
	#superclass : #GtBeamViewDeclaration,
	#category : #'Gt4beam-Serialization'
}

{ #category : #'as yet unclassified' }
GtBeamColumnedListViewDeclaration class >> remoteName [
	^ 'GtPhlowColumnedListViewSpecification'
]

{ #category : #'as yet unclassified' }
GtBeamColumnedListViewDeclaration >> treatView: view [
	view items: [ self rawData at: #items ].

	(self rawData at: #columns)
		withIndexDo: [ :aColumn :anIndex | view column: (aColumn at: #title) text: [ :item | item at: anIndex ] ]
]

{ #category : #'as yet unclassified' }
GtBeamColumnedListViewDeclaration >> viewName [
	^ #columnedList
]
