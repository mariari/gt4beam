Class {
	#name : #BeamProxyObject,
	#superclass : #Object,
	#instVars : [
		'elixirClass',
		'elixirVar',
		'rawData',
		'value',
		'application'
	],
	#category : #'Gt4beam-Serialization'
}

{ #category : #'as yet unclassified' }
BeamProxyObject class >> elixirClass [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
BeamProxyObject class >> elixirClass: aClass [
	| proxyClass proxyClasses |
	proxyClasses := (self allSubclasses
			collect: [ :each | each elixirClass -> each ]) asDictionary.
	proxyClass := proxyClasses at: aClass ifAbsent: [ BeamProxyObject ].
	^ proxyClass new elixirClass: aClass
]

{ #category : #accessing }
BeamProxyObject >> application [
	^ application
]

{ #category : #accessing }
BeamProxyObject >> application: anObject [
	application := anObject
]

{ #category : #accessing }
BeamProxyObject >> elixirClass [
	^ elixirClass
]

{ #category : #accessing }
BeamProxyObject >> elixirClass: anObject [
	elixirClass := anObject
]

{ #category : #accessing }
BeamProxyObject >> elixirVar [
	^ elixirVar
]

{ #category : #accessing }
BeamProxyObject >> elixirVar: anObject [
	elixirVar := anObject
]

{ #category : #accessing }
BeamProxyObject >> rawData [
	^ rawData
]

{ #category : #accessing }
BeamProxyObject >> rawData: anObject [
	rawData := anObject
]

{ #category : #accessing }
BeamProxyObject >> value [
	^ value
]

{ #category : #accessing }
BeamProxyObject >> value: anObject [
	value := anObject
]
