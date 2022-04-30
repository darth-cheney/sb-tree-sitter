Class {
	#name : #SBStSqueakRuntime,
	#superclass : #SBTSLanguageRuntime,
	#category : #'Sandblocks-TSSmalltalk'
}

{ #category : #'as yet unclassified' }
SBStSqueakRuntime >> buildWatchSourceFor: aBlock id: aString [

	| watch |
	watch := (SBTSFileParser new
		parse: 'a SBWatch2 report: x for: ''y'''
		language: SBTSSmalltalk) childSandblocks second.
	watch childSandblocks third replaceBy: aBlock.
	watch childSandblocks fifth textMorphs second contents: aString.
	^ watch
]

{ #category : #'as yet unclassified' }
SBStSqueakRuntime >> evaluate: aString [

	^ Compiler evaluate: aString
]

{ #category : #'as yet unclassified' }
SBStSqueakRuntime >> prettyPrint: aString [

	^ [PPFormatter formatString: aString class: nil class noPattern: false]
		on: SyntaxErrorNotification
		do: [aString]
]