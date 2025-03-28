Class {
	#name : #BeamPlatform,
	#superclass : #LanguageLinkPlatform,
	#category : #'Gt4beam-Processes'
}

{ #category : #hooks }
BeamPlatform class >> weakRegistryClass [
	^ LanguageLinkPharoWeakRegistry
]

{ #category : #hooks }
BeamPlatform >> ensureEnvironmentForApp: anApplication [
	| proc repo iceRepository error |
	(anApplication workingDirectory exists
		and: [ (anApplication workingDirectory / 'mix.exs') exists ])
		ifFalse: [ [ anApplication workingDirectory createDirectory.	"TODO: See what has to change on Windows"

			repo := GtIceRepositorySwitcher new
					sshUrl: 'git@github.com:mariari/ElixirGtBridge.git';
					useLibgitCLI;
					icebergLocation: anApplication workingDirectory.
			iceRepository := repo creator
					fromUrl: repo sshUrl
					to: anApplication workingDirectory.
			iceRepository name: repo projectName.
			repo.



			proc := GtSubprocessWithInMemoryOutput new
					shellCommand: 'mix deps.get';
					workingDirectory: anApplication workingDirectory;
					runAndWait.
			proc isSuccess
				ifFalse: [ error := LanguageLinkProcessError new
							messageText: 'Unable to fetch dependencies for the bridge';
							application: anApplication;
							process: proc.
					error signal ] ] asJob title: 'Cloning the ElixirBridge Environment' ]
]

{ #category : #accessing }
BeamPlatform >> folderForApplication [
	^ FileLocator imageDirectory / 'beam'
]
