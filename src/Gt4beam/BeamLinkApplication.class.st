Class {
	#name : #BeamLinkApplication,
	#superclass : #LanguageLinkApplication,
	#category : #'Gt4beam-Global'
}

{ #category : #'start - stop' }
BeamLinkApplication class >> start [
	"We use startWith: however I need to override that to allow multiple toggleable instances"

	^ self startWith: LanguageLinkSettings elixirDefaultSettings
]

{ #category : #initialization }
BeamLinkApplication >> initializeHandlers [
	loggingHandler := LanguageLinkLoggingHandler application: self.
	processHandler := LanguageLinkServerHandler application: self.
	communicationHandler := LanguageLinkCommunicationHandler application: self.
	executionHandler := ElixirExecutionHandler application: self
]

{ #category : #directory }
BeamLinkApplication >> workingDirectory [
	^ self settings workingDirectory
]
