Class {
	#name : #MSAbstractTest,
	#superclass : #TestCase,
	#instVars : [
		'report'
	],
	#category : #'MemoryStats-Tests'
}

{ #category : #tests }
MSAbstractTest >> testArrayOfImmediate [

	report := MemoryReport on: #(1 2 3 4).
	
	self assert: report instances equals: 1.
	self assert: (report instancesOf: Array) equals: 1.
	self assert: report memorySizeInWords equals: 6.
	self assert: report memorySizeInBytes equals: (6 * Smalltalk wordSize).
]

{ #category : #tests }
MSAbstractTest >> testArrayOfObjects [

	report := MemoryReport on: {Object new. Object new. Object new. Object new.}.
	
	self assert: report instances equals: 5.

	self assert: (report instancesOf: Array) equals: 1.
	self assert: (report instancesOf: Object) equals: 4.

	self assert: report memorySizeInWords equals: (6 + 8).
	self assert: report memorySizeInBytes equals: (14 * Smalltalk wordSize).
]

{ #category : #tests }
MSAbstractTest >> testFalse [

	report := MemoryReport on: false.
	
	self assert: report instances equals: 0.
	self assert: (report instancesOf: Object) equals: 0.
	self assert: report memorySizeInWords equals: 0.
	self assert: report memorySizeInBytes equals: 0.
]

{ #category : #tests }
MSAbstractTest >> testImmediate [

	report := MemoryReport on: 1.
	
	self assert: report instances equals: 0.
	self assert: (report instancesOf: Object) equals: 0.
	self assert: report memorySizeInWords equals: 0.
	self assert: report memorySizeInBytes equals: 0.
]

{ #category : #tests }
MSAbstractTest >> testLoop [

	| x |
	x := {Object new. Object new. Object new. Object new.} asOrderedCollection.
	x add: (MSClassForTest new a: x; yourself).
	
	report := MemoryReport on: x.
	
	self assert: report instances equals: 7.

	self assert: (report instancesOf: Array) equals: 1.
	self assert: (report instancesOf: Object) equals: 4.
	self assert: (report instancesOf: OrderedCollection) equals: 1.


]

{ #category : #tests }
MSAbstractTest >> testNil [

	report := MemoryReport on: nil.
	
	self assert: report instances equals: 0.
	self assert: (report instancesOf: Object) equals: 0.
	self assert: report memorySizeInWords equals: 0.
	self assert: report memorySizeInBytes equals: 0.
]

{ #category : #tests }
MSAbstractTest >> testOrderedCollection [

	report := MemoryReport on: {Object new. Object new. Object new. Object new.} asOrderedCollection.
	
	self assert: report instances equals: 6.

	self assert: (report instancesOf: Array) equals: 1.
	self assert: (report instancesOf: Object) equals: 4.
	self assert: (report instancesOf: OrderedCollection) equals: 1.


]

{ #category : #tests }
MSAbstractTest >> testSingleEmptyInstance [

	report := MemoryReport on: Object new.
	
	self assert: report instances equals: 1.
	self assert: (report instancesOf: Object) equals: 1.
	self assert: report memorySizeInWords equals: 2.
	self assert: report memorySizeInBytes equals: (2 * Smalltalk wordSize).
]

{ #category : #tests }
MSAbstractTest >> testTrue [

	report := MemoryReport on: true.
	
	self assert: report instances equals: 0.
	self assert: (report instancesOf: Object) equals: 0.
	self assert: report memorySizeInWords equals: 0.
	self assert: report memorySizeInBytes equals: 0.
]
