Class {
	#name : #ElixirExecutionHandler,
	#superclass : #LanguageLinkExecutionHandler,
	#category : #'Gt4beam-Global'
}

{ #category : #initialization }
ElixirExecutionHandler >> initializeHandler [
	commandQueue := LanguageLinkCommandRegistry executionHandler: self.
	mapperFactory := LanguageLinkMapperFactory forExecutionHandler: self.
	promiseRegistry := LanguageLinkPromiseRegistry new.
	weakRegistry := self settings platform weakRegistry.
	objectRegistry := LanguageLinkObjectRegistry new.

	self communicationHandler
		addHandler: [ :msg | self notifyHandler: msg ]
			forMessageClass: LanguageLinkUpdatePromiseMessage;
		addHandler: [ :msg | self notifyErrorHandler: msg ]
			forMessageClass: LanguageLinkErrorMessage;
		addHandler: [ :msg | self notifyCallbackHandler: msg ]
			forMessageClass: LanguageLinkCallbackMessage
]

{ #category : #'as yet unclassified' }
ElixirExecutionHandler >> registerObject: aProxyObject [
	"Don't register the object. Gets a new proxy every time"
	weakRegistry 
		registerObject: aProxyObject 
		finalizer: (LanguageLinkRegistryFinalizer 
							variable: aProxyObject elixirVar
							executionHandler: self)
]
