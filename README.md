# Bitbucket PR Story Manager

## Overview
Bitbucket PR Story Manager is a Pharo project designed to analyze Bitbucket pull requests and identify relevant functional test stories. It leverages diff analysis and tagged source code that map classes to stories. Additionally, it detects classes that are not impacted by any story, including newly added classes, unit test classes, or existing classes not yet covered.

## Project Components
### BitbucketDiffAnalyzer

Analyzes the differences in source code files and categorizes changes:

- Detects modified, created, and deleted Java files
- Provides a dictionary of file changes

### TagAnalyzer
Manages and retrieves class information from source model tags:

- Extracts class names from tags
- Provides methods to get class names and tagged classes

### SourceCodeTagger
Imports tags from a specified directory for a Famix model

### StorySelector
Selects stories based on code modifications:

- Finds stories related to changed classes
- Filters and matches tags with diff dictionary

### DictionaryUtils
Provides utility methods for dictionary manipulation:

- Removes file extensions from collection items

## Installation

### Prerequisites
- Pharo 9.0 or later
- Bitbucket Pharo API
- JaCoCo Tagger
### Installation Steps
1. Open Pharo Launcher
2. Create a new image
3. Open Playground
4. Load the project using the baseline:
```Metacello new
    baseline: 'BitbucketPRStoryManager';
    repository: 'github://Evref-BL/Bitbucket-PR-Story-Manager';
    load.
