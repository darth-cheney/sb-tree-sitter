Class {
	#name : #SBJsRuntimeWeb,
	#superclass : #SBJsRuntimeOSProcess,
	#classVars : [
		'WatchServer'
	],
	#category : #'Sandblocks-Javascript'
}

{ #category : #'as yet unclassified' }
SBJsRuntimeWeb class >> runtimeName [

	^ 'web browser'
]

{ #category : #'as yet unclassified' }
SBJsRuntimeWeb class >> watchServer [

	^ WatchServer
]

{ #category : #'as yet unclassified' }
SBJsRuntimeWeb class >> watchServer: aServer [

	WatchServer := aServer
]

{ #category : #'as yet unclassified' }
SBJsRuntimeWeb >> evaluateFileAsync: aString cancel: aBlock [
	" we cannot actually evaluate the file -- but we can start the watch server "

	self startWatchServer
]

{ #category : #'as yet unclassified' }
SBJsRuntimeWeb >> startWatchServer [

	| server |
	self class watchServer ifNotNil: [:s | s destroy].
	
	server := WebServer new listenOn: 51234.
	server
		addService: '/sqReport'
		action: [:req | | params |
			params := WebUtils decodeUrlEncodedForm: (Url absoluteFromText: req rawUrl) query.
			SBTSWatch reportId: (params at: 'id') value: (params at: 'expression').
			req send200Response: 'ok']
		methods: #('GET' 'HEAD').
	self class watchServer: server
]

{ #category : #'as yet unclassified' }
SBJsRuntimeWeb >> stopWatchServer [

	self class watchServer ifNotNil: [:s | s destroy]
]

{ #category : #'as yet unclassified' }
SBJsRuntimeWeb >> writeWatchSourceOn: aStream watch: aWatch [

	aStream
		nextPutAll: '';
		nextPutAll: aWatch id;
		nextPutAll: '", ';
		nextPutAll: ''.
	aWatch expression writeSourceOn: aStream.
	aStream nextPutAll: ')'
]