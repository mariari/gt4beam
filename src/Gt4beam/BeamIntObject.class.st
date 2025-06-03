Class {
	#name : #BeamIntObject,
	#superclass : #BeamProxyObject,
	#category : #'Gt4beam-Serialization'
}

{ #category : #'as yet unclassified' }
BeamIntObject class >> elixirClass [
	^ 'Integer'
]

{ #category : #'as yet unclassified' }
BeamIntObject >> gtIntegerFor: aView [
	<gtView>
	^ aView forward
		title: 'Integer';
		priority: 1;
		object: [ self value ];
		view: #gtIntegerFor:
]
