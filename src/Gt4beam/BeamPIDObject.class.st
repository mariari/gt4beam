Class {
	#name : #BeamPIDObject,
	#superclass : #BeamProxyObject,
	#category : #'Gt4beam-Serialization'
}

{ #category : #dispatch }
BeamPIDObject class >> elixirClass [
	^ 'PID'
]

{ #category : #'as yet unclassified' }
BeamPIDObject >> printOn: str [
	str << (self evaluateAndWait: self resolve , '|> inspect()')
]
