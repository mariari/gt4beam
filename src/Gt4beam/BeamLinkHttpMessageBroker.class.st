Class {
	#name : #BeamLinkHttpMessageBroker,
	#superclass : #LanguageLinkHttpMessageBroker,
	#category : #'Gt4beam-Pharo-MessageBroker'
}

{ #category : #accessing }
BeamLinkHttpMessageBroker class >> serializerClass [
	^ ElixirLinkNeoJsonSerializer
]
