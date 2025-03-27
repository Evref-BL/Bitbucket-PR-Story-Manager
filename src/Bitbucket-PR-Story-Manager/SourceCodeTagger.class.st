Class {
	#name : 'SourceCodeTagger',
	#superclass : 'Object',
	#category : 'Bitbucket-PR-Story-Manager',
	#package : 'Bitbucket-PR-Story-Manager'
}

{ #category : 'as yet unclassified' }
SourceCodeTagger >> importTagsOf: famixModel from: directoryPath [

	| tagger | 
	
	tagger := JTTagger new.
	
	tagger famixModel: famixModel;
		    importFromDirectory: directoryPath. 
]
