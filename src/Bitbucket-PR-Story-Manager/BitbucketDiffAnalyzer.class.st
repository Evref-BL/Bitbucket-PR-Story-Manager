Class {
	#name : 'BitbucketDiffAnalyzer',
	#superclass : 'Object',
	#instVars : [
		'bitbucketApi',
		'changeDictionary'
	],
	#category : 'Bitbucket-PR-Story-Manager',
	#package : 'Bitbucket-PR-Story-Manager'
}

{ #category : 'accessing' }
BitbucketDiffAnalyzer >> bitbucketApi [

	^ bitbucketApi
]

{ #category : 'accessing' }
BitbucketDiffAnalyzer >> bitbucketApi: anObject [

	bitbucketApi := anObject
]

{ #category : 'accessing' }
BitbucketDiffAnalyzer >> changeDictionary [

	^ changeDictionary
]

{ #category : 'accessing' }
BitbucketDiffAnalyzer >> changeDictionary: anObject [

	changeDictionary := anObject
]

{ #category : 'as yet unclassified' }
BitbucketDiffAnalyzer >> getDiffFor: diffs [

	| currentClassnameSource currentClassnameDestination |

	"Iterate over each diff in the collection"
	diffs do: [:currentClassName |
    	"Accessing source and destination using the correct key indices"
    	currentClassnameSource := currentClassName at: 'source' ifAbsent: [nil].
    	currentClassnameDestination := currentClassName at: 'destination' ifAbsent: [nil].

    	"Check if both source and destination are not nil before comparing"
    	(currentClassnameSource isNotNil and: [currentClassnameDestination isNotNil]) 
        	ifTrue: [
					"Check if both source and destination are the same"
            		(currentClassnameSource = currentClassnameDestination) 
                	ifTrue: [changeDictionary at: (currentClassnameSource at: 'name' ifAbsent: [nil]) put: 'modified']
        	].

    	"Check if the source is nil but the destination is not"
    	(currentClassnameSource isNil and: [currentClassnameDestination isNotNil]) 
        	ifTrue: [changeDictionary at: (currentClassnameDestination at: 'name' ifAbsent: [nil]) put: 'created'].

    	"Check if the source is not nil but the destination is nil"
    	(currentClassnameSource isNotNil and: [currentClassnameDestination isNil]) 
        	ifTrue: [changeDictionary at: (currentClassnameSource at: 'name' ifAbsent: [nil]) put: 'deleted'].
	].

	"Filter keys that end with .java"
	changeDictionary keysAndValuesDo: [:key :value |
    	(key endsWith: '.java') ifFalse: [changeDictionary removeKey: key].
	].

	^ changeDictionary.
]

{ #category : 'initialization' }
BitbucketDiffAnalyzer >> initialize [
	bitbucketApi := BitbucketApi new
        host: 'YOUR_BITBUCKET_HOST8URL_HERE';
        bearerToken: 'YOUR_USER_ACCES_TOKEN_HERE'.
	changeDictionary := Dictionary new.
]
