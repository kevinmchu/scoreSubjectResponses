# scoreSubjectResponses

## About
This repository contains code to automatically score speech intelligibility test results from experiments of normal hearing subjects listening to vocoded speech. Speech intelligibility can be quantified as the percent of correct words and phonemes. This respository assumes that speech intelligibility tests were conducted using the Subject Testing Toolbox available at https://github.com/kedarps/SubjectTestingToolbox.

## Usage
The main function is scoreSubjectResponses. This function takes a taskList file (produced from the SubjectTestingToolbox linked above), reads in the subject responses, and scores them against a truth file.
