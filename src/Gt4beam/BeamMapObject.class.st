Class {
	#name : #BeamMapObject,
	#superclass : #BeamProxyObject,
	#category : #'Gt4beam-Serialization'
}

{ #category : #'as yet unclassified' }
BeamMapObject class >> elixirClass [
	^ 'Map'
]

{ #category : #'as yet unclassified' }
BeamMapObject >> gtItemsFor: aView [
	<gtView>
	^ aView forward
		title: 'Items';
		priority: 1;
		object: [ self value ];
		view: #gtItemsFor:
]
