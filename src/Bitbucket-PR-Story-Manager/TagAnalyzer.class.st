Class {
	#name : 'TagAnalyzer',
	#superclass : 'Object',
	#instVars : [
		'sourceModel',
		'allTagsClassesNames',
		'allClassNames'
	],
	#category : 'Bitbucket-PR-Story-Manager',
	#package : 'Bitbucket-PR-Story-Manager'
}

{ #category : 'accessing' }
TagAnalyzer >> allClassNames [

	^ allClassNames
]

{ #category : 'accessing' }
TagAnalyzer >> allClassNames: anObject [

	allClassNames := anObject
]

{ #category : 'accessing' }
TagAnalyzer >> allTagsClassesNames [

	^ allTagsClassesNames
]

{ #category : 'accessing' }
TagAnalyzer >> allTagsClassesNames: anObject [

	allTagsClassesNames := anObject
]

{ #category : 'as yet unclassified' }
TagAnalyzer >> getAllClassNamesOf: sourceModel [
	allClassNames := (((sourceModel tags) collect: [:tag | 
        ((tag taggedEntitiesInModel: sourceModel) select: [:each | each isClass]) collect: [:each | each name]
    ]) flatten) asSet asSortedCollection.

    ^ allClassNames.
]

{ #category : 'as yet unclassified' }
TagAnalyzer >> getClassesForTags [
    | allTagsClassesNames |
    allTagsClassesNames := OrderedCollection new.

    sourceModel tags do: [:tag |
        | taggedClasses sortedNames |
        taggedClasses := (tag taggedEntitiesInModel: sourceModel) select: [:each | each isClass].
        sortedNames := (taggedClasses collect: [:each | each name]) asSortedCollection.
        allTagsClassesNames add: sortedNames.
    ].

    ^ allTagsClassesNames.

]

{ #category : 'as yet unclassified' }
TagAnalyzer >> getClassesFromTagsOf: sourceModel [

	allTagsClassesNames := OrderedCollection new: sourceModel tags size.

	sourceModel tags do: [ :tag |
		| tagged taggedClasses sortedNames |
		tagged := tag taggedEntitiesInModel: sourceModel.
		allTagsClassesNames add: (tagged
				 select: [ :each | each isClass ]
				 thenCollect: [ :each | each name ])

		"[taggedClasses := tagged select: [ :each | each isClass ].
        sortedNames := (taggedClasses collect: [ :each | each name ]) asSortedCollection.] bench
        allTagsClassesNames add: sortedNames." ].

	^ allTagsClassesNames
]

{ #category : 'accessing' }
TagAnalyzer >> sourceModel [

	^ sourceModel
]

{ #category : 'accessing' }
TagAnalyzer >> sourceModel: anObject [

	sourceModel := anObject
]
