Class {
	#name : 'SelectionMetrics',
	#superclass : 'Object',
	#instVars : [
		'impactedClasses',
		'createdClasses',
		'updatedClasses',
		'deletedClasses',
		'selectedTests',
		'selectedTestsCount',
		'meanTimeHours',
		'totalTimeHours',
		'execTimeHours',
		'timeSavedHours',
		'coveredClasses',
		'uncoveredExistingClasses',
		'uncoveredClasses',
		'totalClasses',
		'totalCoveredClasses',
		'totalUncoveredExistingClasses',
		'totalUncoveredClasses',
		'coveragePercent',
		'coverageExistingPercent',
		'isMaxStory',
		'prId',
		'isFullRun',
		'fullRunReason',
		'allStoriesCount',
		'selectionMode',
		'timestamp'
	],
	#category : 'Bitbucket-PR-Story-Manager',
	#package : 'Bitbucket-PR-Story-Manager'
}

{ #category : 'accessing' }
SelectionMetrics >> allStoriesCount [

	^ allStoriesCount
]

{ #category : 'accessing' }
SelectionMetrics >> allStoriesCount: anObject [

	allStoriesCount := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> coverageExistingPercent [

	^ coverageExistingPercent
]

{ #category : 'accessing' }
SelectionMetrics >> coverageExistingPercent: anObject [

	coverageExistingPercent := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> coveragePercent [

	^ coveragePercent
]

{ #category : 'accessing' }
SelectionMetrics >> coveragePercent: anObject [

	coveragePercent := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> coveredClasses [

	^ coveredClasses
]

{ #category : 'accessing' }
SelectionMetrics >> coveredClasses: anObject [

	coveredClasses := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> createMetricsTables: aDatabase [
    "Create tables for storing PR metrics for visualization"
    
    "Main PR metrics table"
    aDatabase execute: 'CREATE TABLE IF NOT EXISTS pr_metrics (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pr_id INTEGER NOT NULL UNIQUE,
        timestamp DATETIME,
        impacted_classes INTEGER,
        created_classes INTEGER,
        modified_classes INTEGER,
        deleted_classes INTEGER,
        selected_tests INTEGER,
        exec_time_hours REAL,
        time_saved_hours REAL,
        total_uncovered_classes INTEGER,
        existing_uncovered_classes INTEGER,
        coverage_percent REAL,
        total_classes INTEGER,
        covered_classes INTEGER,
        is_max_story BOOLEAN
    )'.
    
    "Class changes detail table"
    aDatabase execute: 'CREATE TABLE IF NOT EXISTS pr_class_changes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pr_id INTEGER NOT NULL,
        class_name TEXT,
        change_type TEXT,
        FOREIGN KEY(pr_id) REFERENCES pr_metrics(pr_id)
    )'.
    
    "Coverage details table"
    aDatabase execute: 'CREATE TABLE IF NOT EXISTS pr_coverage_details (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pr_id INTEGER NOT NULL,
        class_name TEXT,
        is_covered BOOLEAN,
        FOREIGN KEY(pr_id) REFERENCES pr_metrics(pr_id)
    )'.
    
    "Aggregate metrics table"
    aDatabase execute: 'CREATE TABLE IF NOT EXISTS aggregate_metrics (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        timestamp DATETIME,
        total_prs INTEGER,
        avg_stories_per_pr REAL,
        queue_clearance_time REAL,
        total_time_saved REAL,
        avg_coverage REAL,
        max_story_pr_count INTEGER,
        other_pr_count INTEGER
    )'.
    
    "Create indexes for better query performance"
    aDatabase execute: 'CREATE INDEX IF NOT EXISTS idx_pr_id ON pr_metrics(pr_id)'.
    aDatabase execute: 'CREATE INDEX IF NOT EXISTS idx_pr_class_changes ON pr_class_changes(pr_id)'.
    aDatabase execute: 'CREATE INDEX IF NOT EXISTS idx_pr_coverage ON pr_coverage_details(pr_id)'.
    aDatabase execute: 'CREATE INDEX IF NOT EXISTS idx_timestamp ON pr_metrics(timestamp)'.


]

{ #category : 'accessing' }
SelectionMetrics >> createdClasses [

	^ createdClasses
]

{ #category : 'accessing' }
SelectionMetrics >> createdClasses: anObject [

	createdClasses := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> deletedClasses [

	^ deletedClasses
]

{ #category : 'accessing' }
SelectionMetrics >> deletedClasses: anObject [

	deletedClasses := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> execTimeHours [

	^ execTimeHours
]

{ #category : 'accessing' }
SelectionMetrics >> execTimeHours: anObject [

	execTimeHours := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> fullRunReason [

	^ fullRunReason
]

{ #category : 'accessing' }
SelectionMetrics >> fullRunReason: anObject [

	fullRunReason := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> impactedClasses [

	^ impactedClasses
]

{ #category : 'accessing' }
SelectionMetrics >> impactedClasses: anObject [

	impactedClasses := anObject
]

{ #category : 'initialization' }
SelectionMetrics >> initialize [
    impactedClasses := OrderedCollection new.
    createdClasses := OrderedCollection new.
    updatedClasses := OrderedCollection new.
    deletedClasses := OrderedCollection new.
    selectedTests := OrderedCollection new.
    meanTimeHours := 48/3078.   "To retrieve from tag count number"
    totalTimeHours := 48.
    execTimeHours := 0.
    timeSavedHours := 0.
    uncoveredExistingClasses := OrderedCollection new.
    totalUncoveredClasses := OrderedCollection new.
]

{ #category : 'accessing' }
SelectionMetrics >> isFullRun [

	^ isFullRun
]

{ #category : 'accessing' }
SelectionMetrics >> isFullRun: anObject [

	isFullRun := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> isMaxStory [

	^ isMaxStory
]

{ #category : 'accessing' }
SelectionMetrics >> isMaxStory: anObject [

	isMaxStory := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> meanTimeHours [

	^ meanTimeHours
]

{ #category : 'accessing' }
SelectionMetrics >> meanTimeHours: anObject [

	meanTimeHours := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> prId [

	^ prId
]

{ #category : 'accessing' }
SelectionMetrics >> prId: anObject [

	prId := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> selectedTests [

	^ selectedTests
]

{ #category : 'accessing' }
SelectionMetrics >> selectedTests: anObject [

	selectedTests := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> selectedTestsCount [

	^ selectedTestsCount
]

{ #category : 'accessing' }
SelectionMetrics >> selectedTestsCount: anObject [

	selectedTestsCount := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> selectionMode [

	^ selectionMode
]

{ #category : 'accessing' }
SelectionMetrics >> selectionMode: anObject [

	selectionMode := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> storeAggregateMetrics: aDatabase 
    totalPRs: totalPRs 
    avgStoriesPerPR: avgStories
    queueClearanceTime: queueTime
    totalTimeSaved: timeSaved
    avgCoverage: avgCov
    maxStoryPRCount: maxCount
    otherPRCount: otherCount [
    
    "Store aggregate metrics"
    
    | stmt |
    stmt := 'INSERT INTO aggregate_metrics 
        (timestamp, total_prs, avg_stories_per_pr, queue_clearance_time, 
         total_time_saved, avg_coverage, max_story_pr_count, other_pr_count)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)'.
    
    aDatabase execute: stmt with: {
        DateAndTime now asString.
        totalPRs.
        avgStories.
        queueTime.
        timeSaved.
        avgCov.
        maxCount.
        otherCount
    }.

]

{ #category : 'accessing' }
SelectionMetrics >> storeCoverageDetails: aDatabase prId: prId coveredClasses: coveredSet uncoveredClasses: uncoveredSet [
    "Store coverage details for each class"
    
    | stmt |
    "Delete existing records for this PR"
    aDatabase execute: 'DELETE FROM pr_coverage_details WHERE pr_id = ?' with: { prId }.
    
    stmt := 'INSERT INTO pr_coverage_details (pr_id, class_name, is_covered) VALUES (?, ?, ?)'.
    
    coveredSet do: [ :className |
        aDatabase execute: stmt with: { prId. className. true }
    ].
    
    uncoveredSet do: [ :className |
        aDatabase execute: stmt with: { prId. className. false }
    ].
]

{ #category : 'accessing' }
SelectionMetrics >> storePRMetrics: aDatabase prId: prId metrics: metrics [
    "Store PR metrics in database"
    
    | stmt |
    stmt := 'INSERT OR REPLACE INTO pr_metrics 
        (pr_id, timestamp, impacted_classes, created_classes, modified_classes, 
         deleted_classes, selected_tests, exec_time_hours, time_saved_hours, 
         total_uncovered_classes, existing_uncovered_classes, coverage_percent,
         total_classes, covered_classes, is_max_story)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'.
    
    aDatabase execute: stmt with: {
        prId.
        metrics timestamp asString.
        metrics totalClasses.
        metrics createdClasses.
        metrics updatedClasses.
        metrics deletedClasses.
        metrics selectedTests size.
        metrics execTimeHours.
        metrics timeSavedHours.
        metrics totalUncoveredClasses size.
        metrics existingUncoveredClasses size.
        metrics coveragePercent.
        metrics totalClasses.
        metrics coveredClasses.
        metrics isMaxStory
    }.

]

{ #category : 'accessing' }
SelectionMetrics >> timeSavedHours [

	^ timeSavedHours
]

{ #category : 'accessing' }
SelectionMetrics >> timeSavedHours: anObject [

	timeSavedHours := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> timestamp [

	^ timestamp
]

{ #category : 'accessing' }
SelectionMetrics >> timestamp: anObject [

	timestamp := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> totalClasses [

	^ totalClasses
]

{ #category : 'accessing' }
SelectionMetrics >> totalClasses: anObject [

	totalClasses := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> totalCoveredClasses [

	^ totalCoveredClasses
]

{ #category : 'accessing' }
SelectionMetrics >> totalCoveredClasses: anObject [

	totalCoveredClasses := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> totalTimeHours [

	^ totalTimeHours
]

{ #category : 'accessing' }
SelectionMetrics >> totalTimeHours: anObject [

	totalTimeHours := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> totalUncoveredClasses [

	^ totalUncoveredClasses
]

{ #category : 'accessing' }
SelectionMetrics >> totalUncoveredClasses: anObject [

	totalUncoveredClasses := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> totalUncoveredExistingClasses [

	^ totalUncoveredExistingClasses
]

{ #category : 'accessing' }
SelectionMetrics >> totalUncoveredExistingClasses: anObject [

	totalUncoveredExistingClasses := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> uncoveredClasses [

	^ uncoveredClasses
]

{ #category : 'accessing' }
SelectionMetrics >> uncoveredClasses: anObject [

	uncoveredClasses := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> uncoveredExistingClasses [

	^ uncoveredExistingClasses
]

{ #category : 'accessing' }
SelectionMetrics >> uncoveredExistingClasses: anObject [

	uncoveredExistingClasses := anObject
]

{ #category : 'accessing' }
SelectionMetrics >> updatedClasses [

	^ updatedClasses
]

{ #category : 'accessing' }
SelectionMetrics >> updatedClasses: anObject [

	updatedClasses := anObject
]
