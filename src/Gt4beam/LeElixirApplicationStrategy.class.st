Class {
	#name : #LeElixirApplicationStrategy,
	#superclass : #LeExternalServerStrategy,
	#category : #'Gt4beam-Lepiter'
}

{ #category : #accessing }
LeElixirApplicationStrategy class >> strategyName [

	^ #global
]

{ #category : #accessing }
LeElixirApplicationStrategy >> applicationServer [

	^ BeamLinkApplication uniqueInstance
]

{ #category : #accessing }
LeElixirApplicationStrategy >> applicationSettings [
	"Answer the settings that will be used by the server.
	This musn't actually start the server as that should be deferred until a snippet is evaluated for the first time."

	^ BeamLinkApplication isRunning ifTrue:
		[ BeamLinkApplication uniqueInstance settings ]
	ifFalse:
		[ BeamLinkApplication defaultSettings ]
]
