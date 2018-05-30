Class {
	#name : #MSReportByClass,
	#superclass : #Object,
	#instVars : [
		'analyzedClass',
		'instanceVariables',
		'indexedVariables',
		'nilInstanceVariables',
		'nilIndexedVariables',
		'visitedInstances'
	],
	#category : #MemoryStats
}

{ #category : #'instance creation' }
MSReportByClass class >> for: aClass [ 
	^ self new
		analyzedClass: aClass;
		yourself.
]

{ #category : #accessing }
MSReportByClass >> analyzedClass: aClass [ 
	analyzedClass := aClass
]

{ #category : #accessing }
MSReportByClass >> averageSizeInWords [
	^ self memorySizeInWords / self instances
]

{ #category : #testing }
MSReportByClass >> hasVisited: anObject [ 
	
	^ visitedInstances includes: anObject
]

{ #category : #initialization }
MSReportByClass >> initialize [
	visitedInstances := IdentitySet new.
	instanceVariables := 0.
	indexedVariables := 0.
	
	nilInstanceVariables := 0.
	nilIndexedVariables := 0.
]

{ #category : #accessing }
MSReportByClass >> instances [
	^ visitedInstances size
]

{ #category : #accessing }
MSReportByClass >> memorySizeInBytes [
	^ self memorySizeInWords * Smalltalk wordSize
]

{ #category : #accessing }
MSReportByClass >> memorySizeInWords [
	^ instanceVariables + indexedVariables + self totalHeaderWords
]

{ #category : #accessing }
MSReportByClass >> percentageInNil [
	^ (self variablesInNil / self variables	* 100) asFloat
]

{ #category : #accessing }
MSReportByClass >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPutAll: ' (instances:';
		print: self instances;
		nextPutAll: ' avgSize: ';
		print: self averageSizeInWords asFloat;
		nextPutAll: ' % in nil: ';
		print: self percentageInNil;
		nextPutAll: ')'
]

{ #category : #registering }
MSReportByClass >> register: anObject [
	visitedInstances add: anObject.
	
	instanceVariables := instanceVariables + anObject class instSize.
	indexedVariables := indexedVariables + anObject basicSize.
	1 to: anObject basicSize do: [ :idx | (anObject at: idx) ifNil: [ nilIndexedVariables := nilIndexedVariables + 1 ] ].
	
	1 to: anObject class instSize do:
		[ :idx | (anObject instVarAt: idx) ifNil: [ nilInstanceVariables := nilInstanceVariables + 1 ] ]
]

{ #category : #accessing }
MSReportByClass >> totalHeaderWords [
	^ self instances * 2
]

{ #category : #accessing }
MSReportByClass >> variables [
	^ indexedVariables + instanceVariables
]

{ #category : #accessing }
MSReportByClass >> variablesInNil [
	^ nilIndexedVariables + nilInstanceVariables
]
