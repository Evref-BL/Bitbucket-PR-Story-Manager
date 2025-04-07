Class {
	#name : 'BaselineOfBitbucketPRStoryManager',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfBitbucketPRStoryManager',
	#package : 'BaselineOfBitbucketPRStoryManager'
}

{ #category : 'baselines' }
BaselineOfBitbucketPRStoryManager >> baseline: spec [
	<baseline>
	spec for: #common do: [
		self defineDependencies: spec.
		self definePackages: spec.
		self defineGroups: spec ]
]

{ #category : 'baselines' }
BaselineOfBitbucketPRStoryManager >> defineDependencies: spec [

	spec
		baseline: 'Bitbucket-Pharo-API'
		with: [ spec repository: 'github://Evref-BL/Bitbucket-Pharo-API:develop' ].
		
		spec
		baseline: 'JaCoCo-Tagger'
		with: [ spec repository: 'github://Evref-BL/JaCoCo-Tagger:main' ]
]

{ #category : 'baselines' }
BaselineOfBitbucketPRStoryManager >> defineGroups: spec [
]

{ #category : 'baselines' }
BaselineOfBitbucketPRStoryManager >> definePackages: spec [

	spec package: 'Bitbucket-PR-Story-Manager'.
]
