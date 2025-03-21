Class {
	#name : #BeamPlatform,
	#superclass : #LanguageLinkPlatform,
	#category : #'Gt4beam-Processes'
}

{ #category : #accessing }
BeamPlatform >> folderForApplication [
	^ FileLocator imageDirectory / 'beam'
]
