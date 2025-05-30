Class {
	#name : #GtElixirCoderModel,
	#superclass : #GtSourceCoder,
	#instVars : [
		'pharoBindings',
		'exception',
		'application',
		'commandFactory',
		'elixirLinkApplicationStrategy'
	],
	#category : #'Gt4beam-Coder'
}

{ #category : #'instance creation' }
GtElixirCoderModel class >> code: aString [

	^ self new sourceCode:
		  (GtCoderExplicitStringSource new source: aString)
]

{ #category : #converting }
GtElixirCoderModel >> asCoderViewModel [

	^ GtSourceCoderViewModel new coder: self
]

{ #category : #accessing }
GtElixirCoderModel >> bindAndExecute: sourceString [
	"Answer the source code with all declared variables returned in an immediate dictionary"

	<gtIgnoreConstraint: #GtRBAcceptVisitorCalledFromNonVisitingMethods>
	<remoteDebuggerSignal>
	| res trimmedSource ast varNames lastStatement carpSource |
	trimmedSource := SmaCCString on: sourceString trimRight.
	ast := ElixirParser parse: trimmedSource.
	"The variables to be returned are names that are in pharoBindings"
	varNames := pharoBindings
			ifNil: [ Set new ]
			ifNotNil: [ pharoBindings bindingNames asSet ].	"Assign the final statement to snippetResult"
	"lastStatement := ast expressions last."
	"trimmedSource
		insert: '(defdynamic snippetResult '
		at: lastStatement startPosition.
	trimmedSource insert: ')' at: lastStatement stopPosition.
	varNames add: 'snippetResult'."
	carpSource := self
			sourceFrom: trimmedSource asString
			returnedVarNames: varNames.
	res := self bindAndExecuteRaw: sourceString.

	(res at: #result) = 'success' ifTrue: [ ^ res ].
	exception := PharoLinkRemoteError new
			application: application;
			command: commandFactory command;
			trace: (res at: #value).
	exception signal
]

{ #category : #accessing }
GtElixirCoderModel >> bindAndExecuteRaw: sourceString [
	self initializeApplication.
	commandFactory := application newCommandFactory.

	^ commandFactory
		<< sourceString;
		sendAndWait
]

{ #category : #accessing }
GtElixirCoderModel >> computeAst: theSourceString [
	^ ElixirParser
		parseWithErrors: theSourceString
]

{ #category : #accessing }
GtElixirCoderModel >> elixirLinkApplicationStrategy: anApplicationStrategy [
	elixirLinkApplicationStrategy := anApplicationStrategy
]

{ #category : #accessing }
GtElixirCoderModel >> exception [
	^ exception
]

{ #category : #accessing }
GtElixirCoderModel >> initializeAddOns: addOns [
	super initializeAddOns: addOns.

	addOns
		addStyler: (GtCoderAstSmaCCParserStyler new smaccStyler: ElixirParser gtStyler).

	elixirLinkApplicationStrategy
		ifNotNil: [ addOns
				addMainAction: 'Evaluate' translated
				icon: BrGlamorousVectorIcons play
				action: [ :aCoderUIModel :anElement | 
					GtCoderCodeExecutor doIt
						coderViewModel: aCoderUIModel;
						element: anElement;
						execute ]
				id: GtSourceCoderDoItActionId.
			addOns
				addMainAction: 'Inspect' translated
				icon: BrGlamorousVectorIcons playinspect
				action: [ :aCoderUIModel :anElement | 
					GtCoderCodeExecutor doItAndGo
						coderViewModel: aCoderUIModel;
						element: anElement;
						execute ]
				id: GtSourceCoderDoItAndGoActionId ]
]

{ #category : #accessing }
GtElixirCoderModel >> initializeApplication [
	application := elixirLinkApplicationStrategy applicationServer.
	application isRunning ifFalse: [ application start ].
]

{ #category : #accessing }
GtElixirCoderModel >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.

	elixirLinkApplicationStrategy
		ifNotNil: [ addOns
				addShortcut: GtSourceCoderDoItShortcut new;
				addShortcut: GtSourceCoderDoItAndInspectShortcut new ]
]

{ #category : #accessing }
GtElixirCoderModel >> newCompletionStrategy [
	^ GtCompletionStrategy new
]

{ #category : #accessing }
GtElixirCoderModel >> pharoBindings: anObject [
	pharoBindings := anObject
]

{ #category : #accessing }
GtElixirCoderModel >> primitiveEvaluate: aSourceString inContext: aGtSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	^ (self bindAndExecute: aSourceString) parse
		transformValue: [ :aValue | aValue expressions first toPharo ]
]

{ #category : #accessing }
GtElixirCoderModel >> sourceFrom: trimmedSourceString returnedVarNames: varNames [
	"Answer the modified source to return the declared variables"

	^ String
		streamContents: [ :stream | 
			stream << trimmedSourceString ]
]

{ #category : #accessing }
GtElixirCoderModel >> variableBindings: aGtSnippetBindings [

	^ self pharoBindings: aGtSnippetBindings
]
