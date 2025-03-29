Class {
	#name : #ElixirLinkCommand,
	#superclass : #LanguageLinkCommand,
	#category : #'Gt4beam-Execution'
}

{ #category : #accessing }
ElixirLinkCommand >> codeForRemote [
	"For Now we shall use the py3CodeStream, this isn't ideal but we should make our own later"

	| codeStream |
	codeStream := String new writeStream.
	self instructions
		do: [ :instr | 
			instr writePython3On: codeStream.
			codeStream << String lf ].
	^ codeStream contents
]

{ #category : #visualization }
ElixirLinkCommand >> gtViewCodeForRemoteFor: aView [
	<gtView>
	^ aView textEditor
		aptitude: BrGlamorousCodeEditorAptitude;
		styler: (BrRBTextStyler new
				isForWorkspace: true;
				yourself);
		title: 'Command string' translated;
		text: [ self codeForRemote ];
		priority: 15
]
