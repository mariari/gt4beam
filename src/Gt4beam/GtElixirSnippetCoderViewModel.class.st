Class {
	#name : #GtElixirSnippetCoderViewModel,
	#superclass : #GtSourceCoderViewModel,
	#category : #'Gt4beam-Coder'
}

{ #category : #accessing }
GtElixirSnippetCoderViewModel >> newCompletionStrategy [
	^ GtElixirCompletionStrategy new
]
