# scoreSubjectResponses

## About
This repository contains code to automatically score speech intelligibility test results from experiments of normal hearing subjects listening to vocoded speech. Speech intelligibility can be quantified as the percent of correct words and phonemes. This respository assumes that speech intelligibility tests were conducted using the Subject Testing Toolbox available at https://github.com/kedarps/SubjectTestingToolbox.

## Usage
The main function is scoreSubjectResponses. This function takes a taskList file (produced from the SubjectTestingToolbox linked above), reads in the subject responses, and scores them against a truth file.

## Scoring
The responses can be scored in terms of words or phonemes. When scored in terms of words, a given word in a subject's response must match exactly with a word in the reference sentence in order to be counted as correct.

When scored in terms of phonemes, the responses are scored by finding the closest match between the subject's response and the reference sentence and scoring the number of correct phonemes. The words are converted into phonemes using the dictionary available in the Subject Testing Toolbox described above. This method of scoring allows for partial credit in instances where part of the word was correct, but not the entire word. Sentences where the subject responded "I don't know" are counted as having no correct words or phonemes. 
