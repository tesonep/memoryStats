Class {
	#name : #MSReportByClass,
	#superclass : #Object,
	#instVars : [
		'analyzedClass',
		'instances',
		'instanceVariables',
		'indexedVariables'
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

{ #category : #initialization }
MSReportByClass >> initialize [
	instances := 0.
	instanceVariables := 0.
	indexedVariables := 0
]

{ #category : #accessing }
MSReportByClass >> instances [
	^ instances
]

{ #category : #accessing }
MSReportByClass >> memorySizeInBytes [
	^ self memorySizeInWords * Smalltalk wordSize
]

{ #category : #accessing }
MSReportByClass >> memorySizeInWords [
	^ instanceVariables + indexedVariables + self totalHeaderWords
]

{ #category : #registering }
MSReportByClass >> register: anObject [ 
	instances := instances + 1.
	instanceVariables := instanceVariables + anObject class instSize.
	indexedVariables := indexedVariables + anObject basicSize 
]

{ #category : #accessing }
MSReportByClass >> totalHeaderWords [
	^ self instances * 2
]
