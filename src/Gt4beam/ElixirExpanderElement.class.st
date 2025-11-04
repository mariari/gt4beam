Class {
	#name : #ElixirExpanderElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'expander',
		'leftButton',
		'index',
		'label',
		'rightButton',
		'total',
		'diffElement'
	],
	#category : #'Gt4beam-Tools'
}

{ #category : #'as yet unclassified' }
ElixirExpanderElement class >> onExpander: anExpander [
	^ self new expander: anExpander
]

{ #category : #accessing }
ElixirExpanderElement >> expander [
	^ expander
]

{ #category : #accessing }
ElixirExpanderElement >> expander: anObject [
	expander := anObject.
	index := 1.

	self updateElement
]

{ #category : #'as yet unclassified' }
ElixirExpanderElement >> initialize [
	super initialize.
	self fitContent.
	
	self initializeToolbar.
	
	self initializeDiffElement
]

{ #category : #'as yet unclassified' }
ElixirExpanderElement >> initializeDiffElement [
	self addChild: (diffElement := GtDiffElement new)
]

{ #category : #'as yet unclassified' }
ElixirExpanderElement >> initializeToolbar [
	self
		addChild: (BrToolbar new
				aptitude: BrGlamorousToolbarAptitude;
				addItem: (leftButton := BrButton new disable
							aptitude: BrGlamorousButtonWithIconAptitude;
							icon: BrGlamorousVectorIcons left;
							action: [ index := index - 1.
								self updateElement ]);
				addItem: (label := BrLabel new
							aptitude: BrGlamorousLabelAptitude;
							text: '1');
				addItem: (BrLabel new
						aptitude: BrGlamorousLabelAptitude;
						text: '/ ');
				addItem: (total := BrLabel new
							aptitude: BrGlamorousLabelAptitude;
							text: '1');
				addItem: (rightButton := BrButton new
							aptitude: BrGlamorousButtonWithIconAptitude;
							icon: BrGlamorousVectorIcons right;
							action: [ index := index + 1.
								self updateElement ]))
]

{ #category : #'as yet unclassified' }
ElixirExpanderElement >> updateElement [
	| step steps |
	steps := self expander steps asList.
	step := (steps at: index) -> (steps at: index + 1).

	label text: index asString.
	total text: steps size - 1.
	leftButton enabled: index > 1.
	rightButton enabled: index < (steps size - 1).

	diffElement
		change: (GtDiffBuilder
				computeDifferencesFrom: step key
				to: step value
				using: GtCharacterGroupDiffSplitter words ignoreWhitespace);
		scrollNext
]
