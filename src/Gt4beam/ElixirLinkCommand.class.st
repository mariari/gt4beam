Class {
	#name : #ElixirLinkCommand,
	#superclass : #LanguageLinkCommand,
	#category : #'Gt4beam-Execution'
}

{ #category : #accessing }
ElixirLinkCommand >> codeForRemote [
	^ Character lf join: self instructions
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
