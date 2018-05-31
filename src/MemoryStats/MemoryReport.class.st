Class {
	#name : #MemoryReport,
	#superclass : #Object,
	#instVars : [
		'root',
		'instancesByClass'
	],
	#category : #MemoryStats
}

{ #category : #'instance creation' }
MemoryReport class >> on: aRoot [
	^ self new
		root: aRoot;
		calculate;
		yourself.
]

{ #category : #visiting }
MemoryReport >> calculate [
	self visit: root
]

{ #category : #initialization }
MemoryReport >> initialize [
	super initialize.
	
	instancesByClass := Dictionary new.

]

{ #category : #'API - report' }
MemoryReport >> instances [
	^ instancesByClass sumNumbers: [ :each | each instances ]
]

{ #category : #'API - report' }
MemoryReport >> instancesByClass [
	^ instancesByClass
]

{ #category : #'API - report' }
MemoryReport >> instancesOf: aClass [ 
	^ (self reportFor: aClass) instances
]

{ #category : #'API - report' }
MemoryReport >> memorySizeInBytes [
	^ instancesByClass sumNumbers: [ :each | each memorySizeInBytes ]
]

{ #category : #'API - report' }
MemoryReport >> memorySizeInWords [
	^ instancesByClass sumNumbers: [ :each | each memorySizeInWords ] 
]

{ #category : #'API - report' }
MemoryReport >> reportFor: aClass [
	^ instancesByClass at: aClass ifAbsentPut: [ MSReportByClass for: aClass ]
]

{ #category : #accessing }
MemoryReport >> root: anObject [ 
	root := anObject
]

{ #category : #accessing }
MemoryReport >> variables [
	^ instancesByClass sumNumbers: [ :each | each variables ]
]

{ #category : #accessing }
MemoryReport >> variablesInNil [
	^ instancesByClass sumNumbers: [ :each | each variablesInNil ]
]

{ #category : #visiting }
MemoryReport >> visit: anObject [ 
	
	| reportForClass |
	
	anObject class isImmediateClass ifTrue: [ ^ self ].
	anObject isClass ifTrue: [ ^self ].	
		
	(self wellKnownObjects includes: anObject) ifTrue: [ ^ self ].
	
	reportForClass := self reportFor: anObject class.
	
	(reportForClass hasVisited: anObject) ifTrue: [ ^ self ].
	reportForClass register: anObject. 

	self visitReferences: anObject.
]

{ #category : #visiting }
MemoryReport >> visitReferences: anObject [ 
	
	1 to: anObject basicSize do: [ :idx | self visit: (anObject at:idx) ].
	1 to: anObject class instSize do: [ :idx | self visit: (anObject instVarAt: idx) ]
]

{ #category : #visiting }
MemoryReport >> wellKnownObjects [
	^ { nil. true. false }
]
