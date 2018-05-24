Class {
	#name : #BaselineOfMemoryStats,
	#superclass : #BaselineOf,
	#category : #BaselineOfMemoryStats
}

{ #category : #baselines }
BaselineOfMemoryStats >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec
				package: 'MemoryStats';
				package: 'MemoryStats-Tests' with: [ spec requires: #('MemoryStats') ].

			spec group: 'default' with: #('MemoryStats').
			spec group: 'development' with: #('default' 'MemoryStats-Tests') ]
]
