Class {
	#name : #ElixirLinkCommand,
	#superclass : #LanguageLinkCommand,
	#category : #'Gt4beam-Execution'
}

{ #category : #accessing }
ElixirLinkCommand >> codeForRemote [
	"I'm not sure if the commands coming in are strings or actual data... I assume data for now"

	| codeStream |
	codeStream := String new writeStream.
	self instructions do: [ :instr | codeStream << instr printString << String lf ].
	^ codeStream contents
]
