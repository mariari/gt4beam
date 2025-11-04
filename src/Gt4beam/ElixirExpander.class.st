Class {
	#name : #ElixirExpander,
	#superclass : #Object,
	#instVars : [
		'code',
		'application'
	],
	#category : #'Gt4beam-Tools'
}

{ #category : #accessing }
ElixirExpander >> application [
	^ application ifNil: [ application := BeamLinkApplication uniqueInstance ]
]

{ #category : #accessing }
ElixirExpander >> application: anObject [
	application := anObject
]

{ #category : #accessing }
ElixirExpander >> code [
	^ code
]

{ #category : #accessing }
ElixirExpander >> code: anObject [
	code := anObject
]

{ #category : #'as yet unclassified' }
ElixirExpander >> evaluateAndWait: string [
	^ self application newCommandFactory
		<< string;
		sendAndWait
]

{ #category : #'as yet unclassified' }
ElixirExpander >> gtExpansionsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Expansions';
		priority: 0;
		stencil: [ (ElixirExpanderElement onExpander: self) hMatchParent ]
]

{ #category : #'as yet unclassified' }
ElixirExpander >> gtStepsFor: aView [
	<gtView>
	^ aView list
		title: 'Steps';
		priority: 1;
		items: [ self steps asList ]
]

{ #category : #'as yet unclassified' }
ElixirExpander >> steps [
	^ self evaluateAndWait: 'GtBridge.MacroInspector.inspect(quote do: (' , self code , '))'
]
