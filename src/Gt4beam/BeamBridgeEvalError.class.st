Class {
	#name : #BeamBridgeEvalError,
	#superclass : #BeamProxyObject,
	#category : #'Gt4beam-Serialization'
}

{ #category : #'as yet unclassified' }
BeamBridgeEvalError class >> elixirClass [
	^ 'GtBridge.Eval.Error'
]

{ #category : #predicates }
BeamBridgeEvalError >> isError [
	^ false
]
