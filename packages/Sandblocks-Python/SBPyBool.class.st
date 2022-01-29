"
This class replaces all python boolean with checkboxes.
"
Class {
	#name : #SBPyBool,
	#superclass : #SBInlineBlockReplace,
	#category : #'Sandblocks-Python'
}

{ #category : #'as yet unclassified' }
SBPyBool class >> matchPython: aDictionary do: aBlock [
	<lang: #python match: '[(true) (false)] @bool' sample: 'True'>

	(aDictionary at: 'bool') type = 'true'
		ifTrue: [^ aBlock value: (aDictionary at: 'bool') value: (self new factory: (aDictionary at: 'bool') factory; checked: true)]
		ifFalse: [^ aBlock value: (aDictionary at: 'bool') value: (self new factory: (aDictionary at: 'bool') factory; checked: false)].
]

{ #category : #'initialize-release' }
SBPyBool >> checked: aBoolean [ 
	self addMorphBack: (SBCheckbox new value: aBoolean)
]