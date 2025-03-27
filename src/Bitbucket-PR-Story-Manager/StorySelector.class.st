Class {
	#name : 'StorySelector',
	#superclass : 'Object',
	#category : 'Bitbucket-PR-Story-Manager',
	#package : 'Bitbucket-PR-Story-Manager'
}

{ #category : 'as yet unclassified' }
StorySelector >> selectStoriesBasedOnDiff: aDiffDictionary forModel: sourceModel [

	| allTagsClassesNames selectedStories tags entityNames|

	allTagsClassesNames := OrderedCollection new.

	tags := sourceModel tags. 

	"iterate on tags and and create arry of collection with list of classes"
	1 to: (tags size) do: [ :i |
    	| tag tagged taggedClasses sortedNames |
    	tag := sourceModel tags at: i.
    	tagged := tag taggedEntitiesInModel: sourceModel.
    	taggedClasses := tagged select: [ :each | each isClass ].  
    
    	"Collect and sort class names"
    	sortedNames := (taggedClasses collect: [ :each | each name ]) asSortedCollection.
    
    	"Store in main collection"
    	allTagsClassesNames add: sortedNames.
	].

	entityNames := DictionaryUtils removeExtensionsFrom: aDiffDictionary keys.

	selectedStories := (tags select: [:tag | 
    	((tag taggedEntitiesInModel: sourceModel) select: [:each | each isClass]) anySatisfy: [:entity | entityNames includes: entity name]])
    	collect: [:tag | tag name].
	
	^ selectedStories
	

]
