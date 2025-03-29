Class {
	#name : #BeamLinkCommandFactory,
	#superclass : #LanguageLinkCommandFactory,
	#category : #'Gt4beam-Execution'
}

{ #category : #initialization }
BeamLinkCommandFactory >> setNotifyToInstruction: aP3gInstruction [
	^ 'notify' asP3GIdentifier 
			callWith: (Array with: aP3gInstruction with: command id)
]
