Class {
	#name : 'DictionaryUtils',
	#superclass : 'Object',
	#category : 'Bitbucket-PR-Story-Manager',
	#package : 'Bitbucket-PR-Story-Manager'
}

{ #category : 'removing' }
DictionaryUtils class >> removeExtensionsFrom: aCollection [
	^ aCollection collect: [:each | each copyUpToLast: $.].
]
