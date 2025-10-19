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
BeamPIDObject >> gtInformationFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Information';
		priority: 1;
		items: [ self information associations ];
		column: 'Name'
			text: #key
			width: 150;
		column: 'Value'
			text: [ :anItem | anItem value isArray ifTrue: [ anItem value second ] ifFalse: [ anItem value ] ];
		send: #value
]

{ #category : #'as yet unclassified' }
BeamPIDObject >> information [
	| informationTuples result |
	informationTuples := self evaluateAndWait: 'Process.info(' , self resolve , ')'.
	result := Dictionary new.
	informationTuples asList do: [:aTuple |
		| pair |
		pair := aTuple asList.
		result at: pair first second put: pair second
	].
	^ result
]

{ #category : #'as yet unclassified' }
BeamPIDObject >> printOn: str [
	str << (self evaluateAndWait: self resolve , '|> inspect()')
]
