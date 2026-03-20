Class {
	#name : 'StorySelector',
	#superclass : 'Object',
	#category : 'Bitbucket-PR-Story-Manager',
	#package : 'Bitbucket-PR-Story-Manager'
}

{ #category : 'as yet unclassified' }
StorySelector >> getAllCoveredClassesBasedOnMatrix: db for: classNameInClause [
    | sql result coveredClasses items unionSQL token |

    "If no class names were provided, return an empty set early"
    (classNameInClause isEmpty or: [ classNameInClause trimBoth isEmpty ]) ifTrue: [
        ^ Set new
    ].

    "Split the comma-separated list into individual class names"
    items := classNameInClause findTokens: ','.

    "Build the UNION ALL SQL inline"
    unionSQL := String streamContents: [ :str |
        items doWithIndex: [ :each :i |
            token := each trimBoth.

            "Strip surrounding quotes if present"
            (token first = $' and: [token last = $']) ifTrue: [
                token := token copyFrom: 2 to: token size - 1.
            ].

            "Wrap in single quotes for SQL"
            str nextPutAll: 'SELECT '''; nextPutAll: token; nextPutAll: ''''.
            (i < items size) ifTrue: [ str nextPutAll: ' UNION ALL ' ].
        ].
    ].

    "SQL that returns *covered* classes (present AND tagged)"
    sql := 'WITH input_classes(class_name) AS (', unionSQL, ')
            SELECT ic.class_name
            FROM input_classes ic
            JOIN classes c ON c.class_name = ic.class_name
            JOIN class_tags t ON t.class_id = c.id'.

    Transcript show: sql; cr.

    result := db execute: sql.

    coveredClasses := Set new.
    result do: [ :row | coveredClasses add: (row at: 'class_name') ].

    ^ coveredClasses

]

{ #category : 'as yet unclassified' }
StorySelector >> getAllUncoveredClassesBasedOnMatrix: db for: classNameInClause [
	| sql result uncoveredClasses items unionSQL token |
	
	"If no class names were provided, return an empty set early"
    (classNameInClause isEmpty or: [ classNameInClause trimBoth isEmpty ]) ifTrue: [
        ^ Set new
    ].

	"Split the comma-separated list into individual class names"
	items := classNameInClause findTokens: ','.

	"Build the UNION ALL SQL inline"
	unionSQL := String streamContents: [ :str |
		items doWithIndex: [ :each :i |
			"Trim leading/trailing spaces"
			token := each trimBoth.

			"Strip surrounding quotes if present"
			(token first = $' and: [token last = $']) ifTrue: [
				token := token copyFrom: 2 to: token size - 1.
			].

			"Wrap in single quotes for SQL"
			str nextPutAll: 'SELECT '''; nextPutAll: token; nextPutAll: ''''.
			(i < items size) ifTrue: [ str nextPutAll: ' UNION ALL ' ].
		].
	].

	"SQL that handles both missing and untagged classes"
	sql := 'WITH input_classes(class_name) AS (', unionSQL, ')
	        SELECT ic.class_name
	        FROM input_classes ic
	        LEFT JOIN classes c ON c.class_name = ic.class_name
	        LEFT JOIN class_tags t ON t.class_id = c.id
	        WHERE c.id IS NULL OR t.id IS NULL'.

	Transcript show: sql; cr.

	result := db execute: sql.

	uncoveredClasses := Set new.
	result do: [ :row | uncoveredClasses add: (row at: 'class_name') ].

	^ uncoveredClasses

]

{ #category : 'as yet unclassified' }
StorySelector >> getExistingUncoveredClassBasedOnMatrix: db for: classNameInClause [
	|sql result uncoveredExistingClasses|
	sql := 'SELECT c.class_name FROM classes c ',
          'WHERE c.class_name IN (', classNameInClause, ') ',
          'AND NOT EXISTS (',
      			'SELECT 1 ',
      			'FROM class_tags ct ',
      			'WHERE ct.class_id = c.id',
  			 ')'.
			
	result := db execute: sql.
	uncoveredExistingClasses := Set new.
	result do: [ :row | uncoveredExistingClasses add: (row at: 'class_name') ].
	^ uncoveredExistingClasses
]

{ #category : 'as yet unclassified' }
StorySelector >> selectStoriesBasedOnDiff: aDiffDictionary forModel: sourceModel [

	|selectedStories entityNames |

	entityNames := DictionaryUtils removeExtensionsFrom: aDiffDictionary keys.
	
	selectedStories := (sourceModel tags 
		select: [ :tag |
			(tag taggedEntitiesInModel: sourceModel)
				anySatisfy: [ :entity |
					entity isClass and: [ entityNames includes: entity name ] ] ])
		collect: [ :tag | tag name ].
	
	^ selectedStories
]

{ #category : 'as yet unclassified' }
StorySelector >> selectStoriesBasedOnMatrix: db for: classNameInClause [
	|sql result tags|

	sql := 'SELECT DISTINCT ct.tag_name FROM class_tags ct ',
           'INNER JOIN classes c ON ct.class_id = c.id ',
           'WHERE c.class_name IN (', classNameInClause, ')'.


	result := db execute: sql.

	tags := Set new.
	result do: [ :row | tags add: (row at: 'tag_name') ].

	^ tags
]
