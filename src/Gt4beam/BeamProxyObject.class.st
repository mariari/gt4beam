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

{ #category : #'as yet unclassified' }
BeamProxyObject >> asList [
	^ (1 to: self length) collect: [ :anIndex | self itemAt: anIndex - 1 ]
]

{ #category : #'as yet unclassified' }
BeamProxyObject >> attributeAt: name [
	^ self
		evaluateAndWait: 'GtBridge.ObjectRegistry.get_attribute(' , self elixirVar asString , ', :', name, ')'
]

{ #category : #'as yet unclassified' }
BeamProxyObject >> attributes [
	^ self
		evaluateAndWait: 'GtBridge.ObjectRegistry.list_attributes(' , self elixirVar asString , ')'
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

{ #category : #'as yet unclassified' }
BeamProxyObject >> evaluateAndWait: string [
	^ self application newCommandFactory
		<< string;
		sendAndWait
]

{ #category : #'as yet unclassified' }
BeamProxyObject >> gtElixirRawFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Elixir raw';
		priority: 99;
		items: [ self attributes asList ];
		column: 'Variable' text: #yourself;
		column: 'Value' text: [ :aName | self attributeAt: aName ];
		send: [ :aName | self attributeAt: aName ];
		actionUpdateButton
]

{ #category : #'as yet unclassified' }
BeamProxyObject >> gtLiveFor: aView [
	<gtView>
	^ aView forward
		title: 'Live';
		priority: 5;
		object: [ self value ];
		view: #gtLiveFor:
]

{ #category : #'as yet unclassified' }
BeamProxyObject >> gtRemoteViewsFor: aView [
	"Create a composite view with all remote views"

	<gtView>
	^ aView composite
		title: 'Remote views';
		priority: 1;
		views: (self viewDeclarations asList collect: [ :decl | self viewFromDeclaration: decl ])
]

{ #category : #'as yet unclassified' }
BeamProxyObject >> itemAt: idx [
	^ self
		evaluateAndWait: 'GtBridge.ObjectRegistry.get_item(' , self elixirVar asString , ', ', idx asString , ')'
]

{ #category : #'as yet unclassified' }
BeamProxyObject >> length [
	^ self
		evaluateAndWait: 'GtBridge.ObjectRegistry.get_length(' , self elixirVar asString , ')'
]

{ #category : #accessing }
BeamProxyObject >> rawData [
	^ rawData
]

{ #category : #accessing }
BeamProxyObject >> rawData: anObject [
	rawData := anObject
]

{ #category : #'as yet unclassified' }
BeamProxyObject >> viewDeclarations [
	^ self
		evaluateAndWait: 'GtBridge.GtViewedObject.getViewsDeclarationsById(' , self elixirVar asString
				, ')'
]

{ #category : #'as yet unclassified' }
BeamProxyObject >> viewFromDeclaration: aDeclaration [
	^ (GtBeamViewDeclaration fromRawData: aDeclaration) asView
]
