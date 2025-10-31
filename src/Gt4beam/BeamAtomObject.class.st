Class {
	#name : #BeamAtomObject,
	#superclass : #Object,
	#instVars : [
		'symbol'
	],
	#category : #'Gt4beam-Serialization'
}

{ #category : #'as yet unclassified' }
BeamAtomObject class >> new: aSymbol [
	^ self new symbol: aSymbol
]

{ #category : #comparing }
BeamAtomObject >> = aSymbol [
	"I should probably do this better"

	self class == aSymbol class ifFalse: [ ^ false ].
	^ self symbol = aSymbol symbol
]

{ #category : #comparing }
BeamAtomObject >> hash [
	^ self symbol hash hashMultiply
]

{ #category : #'as yet unclassified' }
BeamAtomObject >> printOn: aStream [
	self symbol printOn: aStream
]

{ #category : #'elixir - resolution' }
BeamAtomObject >> resolve [
	^ (symbol at: 1) = (symbol at: 1) asUppercase
		ifTrue: [ symbol ]
		ifFalse: [ ':' , symbol ]
]

{ #category : #accessing }
BeamAtomObject >> symbol [
	^ symbol
]

{ #category : #accessing }
BeamAtomObject >> symbol: anObject [
	symbol := anObject
]
