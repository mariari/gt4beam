Class {
	#name : #BeamTupleObject,
	#superclass : #BeamProxyObject,
	#category : #'Gt4beam-Serialization'
}

{ #category : #dispatch }
BeamTupleObject class >> elixirClass [
	^ 'Tuple'
]

{ #category : #'as yet unclassified' }
BeamTupleObject >> asElixirList [
	^ self evaluateAndWait: self resolve , '|>Tuple.to_list() '
]

{ #category : #'as yet unclassified' }
BeamTupleObject >> attributesAndValues [
	^ self asElixirList attributesAndValues
]
