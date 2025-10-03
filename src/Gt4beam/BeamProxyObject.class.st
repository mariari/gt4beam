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

{ #category : #'as yet unclassified' }
BeamProxyObject >> addViewFromDeclaration: aDeclaration to: aCompositeView [
	| viewName |
	viewName := aDeclaration at: #viewName.

	viewName = 'GtPhlowListViewSpecification'
		ifTrue: [ ^ aCompositeView list
				title: (aDeclaration at: #title);
				priority: (aDeclaration at: #priority);
				items: [ aDeclaration at: #items ] ].

	viewName = 'GtPhlowTextEditorViewSpecification'
		ifTrue: [ ^ aCompositeView textEditor
				title: (aDeclaration at: #title);
				priority: (aDeclaration at: #priority);
				text: [ aDeclaration at: #string ] ].

	^ aCompositeView
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
	<gtView>
	| viewDeclarations |
	"Get view declarations from the remote side"
	viewDeclarations := self application
			sendAndWait: 'GtBridge.GtViewedObject.getViewsDeclarations(' , self elixirVar , ')'.	"Create a composite view with all remote views"
	^ viewDeclarations
		inject: aView composite
		into: [ :composite :eachDecl | self addViewFromDeclaration: eachDecl to: composite ]
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
