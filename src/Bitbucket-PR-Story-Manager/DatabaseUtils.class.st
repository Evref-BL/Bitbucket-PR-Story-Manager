Class {
	#name : 'DatabaseUtils',
	#superclass : 'Object',
	#category : 'Bitbucket-PR-Story-Manager',
	#package : 'Bitbucket-PR-Story-Manager'
}

{ #category : 'as yet unclassified' }
DatabaseUtils class >> buildInClauseFrom: classNames [
    "Return a comma-separated string of quoted class names for use in an SQL IN clause."
    | inClause |
    inClause := ''.
    1 to: classNames size do: [ :i | 
        inClause := inClause , '''', (classNames at: i), ''''.
        (i < classNames size) ifTrue: [ inClause := inClause , ', ' ].
    ].
    ^ inClause
]
