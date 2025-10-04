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
		views: (self viewDeclarations value collect: [ :decl | self viewFromDeclaration: decl ])
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

{ #category : #'as yet unclassified' }
BeamProxyObject >> viewDeclarations [
	^ self application newCommandFactory
		<< ('GtBridge.GtViewedObject.getViewsDeclarationsById(' , self elixirVar asString , ')');
		sendAndWait
]

{ #category : #'as yet unclassified' }
BeamProxyObject >> viewFromDeclaration: aDeclaration [
	| viewName |
	viewName := aDeclaration at: #viewName.

	viewName = 'GtPhlowListViewSpecification'
		ifTrue: [ ^ GtPhlowView empty list
				title: (aDeclaration at: #title);
				priority: (aDeclaration at: #priority);
				items: [ aDeclaration at: #items ] ].

	viewName = 'GtPhlowTextEditorViewSpecification'
		ifTrue: [ ^ GtPhlowView empty textEditor
				title: (aDeclaration at: #title);
				priority: (aDeclaration at: #priority);
				text: [ aDeclaration at: #string ] ].

	^ self error: 'Unknown view'
]
