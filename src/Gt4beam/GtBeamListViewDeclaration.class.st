Class {
	#name : #GtBeamListViewDeclaration,
	#superclass : #GtBeamViewDeclaration,
	#category : #'Gt4beam-Serialization'
}

{ #category : #'as yet unclassified' }
GtBeamListViewDeclaration class >> remoteName [
	^ 'GtPhlowListViewSpecification'
]

{ #category : #'as yet unclassified' }
GtBeamListViewDeclaration >> treatView: aView [
	aView items: [ self rawData at: #items ]
]

{ #category : #'as yet unclassified' }
GtBeamListViewDeclaration >> viewName [
	^ #list
]
